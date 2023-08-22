//
//  NView.swift
//  Phonics
//
//  Created by Littlefox iOS Developer on 2023/07/24.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public class NController: UINavigationController {
    
    private let topInset: CGFloat
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    init(topInset:CGFloat, rootViewController: UIViewController) {
        self.topInset = topInset
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        additionalSafeAreaInsets.top = self.topInset
    }
}

public struct NView<Content: View>: UIViewControllerRepresentable {
    
    @Binding var statusBarColor: Color
    @Binding var bgImage: UIImage?
    
    var topInset: CGFloat
    
    var configure:((NController) -> Void)? = nil
    var content: () -> Content
    
    var callback: (UINavigationController, UIViewController) -> Void

    public func makeUIViewController(context: Context) -> NController {
        let navigationController = NController(topInset: topInset, rootViewController: UIHostingController(rootView: content()))
        navigationController.delegate = context.coordinator
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: NController, context: Context) {

        uiViewController.setStatusBar(color: UIColor(self.statusBarColor))
        uiViewController.additionalSafeAreaInsets.top = self.topInset - UINavigationController().navigationBar.frame.size.height
        
        let v = UIImageView(frame: CGRect(origin: CGPoint(x: 0,
                                                          y: uiViewController.statusBarHeight),
                                          size: CGSize(width: uiViewController.view.frame.size.width,
                                                       height: self.topInset)))
        v.image = self.bgImage
        uiViewController.view.addSubview(v)
        
        self.configure?(uiViewController)
    }
    
    public func makeCoordinator() -> NavigationSlave {
        NavigationSlave(owner: self)
    }
    
    
    public class NavigationSlave: NSObject, UINavigationControllerDelegate{
        
        var owner: NView
        
        public init(owner: NView) {
            self.owner = owner
        }
        
        public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
            self.owner.callback(navigationController, viewController)
        }
        
    }
}

struct TestView: View{
    @State var statusBarColor: Color = .green
    @State var bgImage: UIImage? = UIImage(named: Bundle.module.bundlePath + "/top-bg-img.png")
    
    var body: some View{
        
        NView(
            statusBarColor: $statusBarColor,
            bgImage: $bgImage,
            topInset: 180) {
                ZStack{
                    Color.yellow
                    NavigationLink("new") {
                        SecoundScreenView()
                    }
                }
            } callback: { n, c in
                print("n \(n), c \(c.self)")
                if n.children.count > 1 {
                    self.bgImage = nil
                }else{
                    self.bgImage = UIImage(named: Bundle.module.bundlePath + "/top-bg-img.png")
                }
                
                
            }
            .ignoresSafeArea()
        
        
    }
}


struct NView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}



struct SecoundScreenView: View {

    var body: some View {
        VStack(spacing: 0){
            Color.black
            Color.gray
        }//.ignoresSafeArea()
    }
}

public extension UIViewController{
    
    var statusBarHeight : CGFloat {
        if let safeFrame = UIApplication.shared.windows.first?.safeAreaInsets{
            return Swift.max(safeFrame.top, safeFrame.left)
        }
        return 0
    }
    
    func setStatusBar(color: UIColor){
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        self.view.addSubview(statusbarView)
        
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        statusbarView.heightAnchor
            .constraint(equalToConstant: statusBarHeight).isActive = true
        statusbarView.widthAnchor
            .constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        statusbarView.topAnchor
            .constraint(equalTo: self.view.topAnchor).isActive = true
        statusbarView.centerXAnchor
            .constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
