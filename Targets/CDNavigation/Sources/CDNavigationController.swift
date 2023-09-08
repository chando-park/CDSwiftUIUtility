//
//  ConvertedNavigationController.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import UIKit
import SwiftUI

public class ConvertedNavigationController: UINavigationController {
    
    public enum NavigationBarBackgroundType{
        case image(image: UIImage)
        case paint(color: UIColor)
    }
    
    public struct FontInfo : Equatable{
        let name: String?
        let size: CGFloat
        
        public init(name: String? = nil, size: CGFloat) {
            self.name = name
            self.size = size
        }
        
        var uiFont: UIFont?{
            if let name = name {
                return UIFont(name: name, size: size)
            }else{
                return UIFont.systemFont(ofSize: size)
            }
            
        }
    }
    
    public enum NavigationBarTitleType: Equatable{
//        case image(image: UIImage)
        case text(title: String?, color: UIColor?, font: FontInfo)
        var title: String?{
            switch self {
            case .text(let title, _,_):
                return title
            }
        }
        var fontInfo: FontInfo{
            switch self{
            case .text(_,_, let font):
                return font
            }
        }
    }
    
    private let navigationBarHeight: CGFloat
    private var naviBar: UIImageView?
    
    private var backBtn: UIButton?
    private var closeBtn: UIButton?
    
    private var titleLabel: UILabel?
    
    private var statusbarView: UIView!
    private var fontInfo: FontInfo!
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var isNaviBarHidden: Bool = false{
        didSet{
            UIView.animate(withDuration: 0.3) {
                self.navigationBar.isHidden = self.isNaviBarHidden
                if self.isNaviBarHidden{
                    self.naviBar?.frame.origin.y = -(self.statusBarHeight + UINavigationController().navigationBar.frame.size.height)
                    self.additionalSafeAreaInsets.top = 0
                }else{
                    self.naviBar?.frame.origin.y = self.statusBarHeight
                    self.additionalSafeAreaInsets.top = self.navigationBarHeight - UINavigationController().navigationBar.frame.size.height
                }
            }
        }
    }
    
    var isBackBtnHidden: Bool = false{
        didSet{
            
            guard let backBtn = self.backBtn else{
                return
            }
            
            UIView.animate(withDuration: 0.3) {
                if self.isBackBtnHidden{
                    backBtn.frame.origin.x = -backBtn.frame.size.width
                }else{
                    let left = backBtn.frame.size.width*(42.0/110)
                    backBtn.frame.origin.x = left
                }
            }
            
        }
    }
    
    var isCloseBtnHidden: Bool = false{
        didSet{
            
            guard let closeBtn = self.closeBtn else{
                return
            }
            
            UIView.animate(withDuration: 0.3) {
                if self.isCloseBtnHidden{
                    closeBtn.frame.origin.x = self.view.frame.size.width
                }else{
                    let left = closeBtn.frame.size.width*(42.0/110)
                    closeBtn.frame.origin.x = self.view.frame.size.width - left - closeBtn.frame.size.width
                }
            }
        }
    }
    
    var navigationBarTitleType: NavigationBarTitleType?{
        set{
            switch newValue{
            case .text(let title, let color, let fontInfo):
                self.titleLabel?.text = title
                self.titleLabel?.textColor = color
                self.titleLabel?.font = fontInfo.uiFont
                
                self.titleLabel?.sizeToFit()
                self.titleLabel?.center.x = self.naviBar!.frame.size.width/2
                self.titleLabel?.frame.origin.y = (self.navigationBarHeight - (self.titleLabel?.frame.size.height ?? 0))/2 + self.statusBarHeight

                break
            default:
                break
            }
        }
        get{
            .text(title: self.titleLabel?.text, color: self.titleLabel?.textColor, font: self.fontInfo)
        }
    }
    
    init(navigationBarHeight:CGFloat, navigationBarBackgroundType: NavigationBarBackgroundType, navigationBarTitleType: NavigationBarTitleType, statusBarColor: UIColor, closeImage: UIImage?, backImage: UIImage?, rootViewController: UIViewController) {
        self.navigationBarHeight = navigationBarHeight
        super.init(rootViewController: rootViewController)
        
        self.additionalSafeAreaInsets.top = self.navigationBarHeight - UINavigationController().navigationBar.frame.size.height
        
        self.naviBar = UIImageView(frame: CGRect(origin: CGPoint(x: 0,
                                                                 y: self.statusBarHeight),
                                                 size: CGSize(width: self.view.frame.size.width,
                                                              height: self.navigationBarHeight)))
        switch navigationBarBackgroundType {
        case .image(let image):
            self.naviBar?.image = image
            break
        case .paint(let color):
            self.naviBar?.backgroundColor = color
            break
        }
        self.view.addSubview(naviBar!)
        
        
        if let backImage = backImage {
            let btnHeight = (118.0/183.0)*self.navigationBarHeight
            let btnWidth = btnHeight*(backImage.size.width/backImage.size.height)
            let left = btnWidth*(42.0/110)
            let top = (self.navigationBarHeight - btnHeight)/2
            self.backBtn = UIButton(frame: CGRect(origin: CGPoint(x: left, y: top+statusBarHeight),
                                                   size: CGSize(width: btnWidth, height: btnHeight)))
            self.backBtn?.setImage(backImage, for: .normal)
            self.backBtn?.addTarget(self, action: #selector(backCallback(_:)), for: .touchUpInside)
            self.view.addSubview(self.backBtn!)
            
        }
        
        if let closeImage = closeImage {
            let btnHeight = (118.0/183.0)*self.navigationBarHeight
            let btnWidth = btnHeight*(closeImage.size.width/closeImage.size.height)
            let left = btnWidth*(42.0/110)
            let top = (self.navigationBarHeight - btnHeight)/2
            self.closeBtn = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.size.width - left - btnWidth, y: top+statusBarHeight),
                                                   size: CGSize(width: btnWidth, height: btnHeight)))
            self.closeBtn?.setImage(closeImage, for: .normal)
            self.closeBtn?.addTarget(self, action: #selector(closeCallback(_:)), for: .touchUpInside)
            self.view.addSubview(self.closeBtn!)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel?.frame.size.width = self.view.frame.size.width - ((self.backBtn?.frame.origin.x ?? 0) + (self.backBtn?.frame.size.width ?? 0))*2.1
//        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: (74.0/183.0)*self.navigationBarHeight)
        
        self.view.addSubview(self.titleLabel!)
        
        self.navigationBarTitleType = navigationBarTitleType
        self.fontInfo = navigationBarTitleType.fontInfo
        
        self.statusbarView = UIView()
        self.statusbarView.backgroundColor = statusBarColor
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
        
        self.navigationBar.backgroundColor = .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func backCallback(_ sender: UIButton){
        self.popViewController(animated: true)
    }
    
    @objc private func closeCallback(_ sender: UIButton){
        self.dismiss(animated: true)
    }
    
    func setStatusBar(color: UIColor){
//        UIView.animate(withDuration: 0.1) {
            self.statusbarView.backgroundColor = color
//        }
        
    }
}
