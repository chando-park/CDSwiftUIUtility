//
//  CDActivityView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI

public struct CDActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    public let activityItmes: [CDActivityType]
    
    public init(isPresented: Binding<Bool>, activityItmes: [CDActivityType]) {
        self._isPresented = isPresented
        self.activityItmes = activityItmes
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let activityViewController = UIActivityViewController(
            activityItems: activityItmes.map({$0.toActivity}),
            applicationActivities: nil
        )
        
        if isPresented && uiViewController.presentedViewController == nil {
            uiViewController.present(activityViewController, animated: true)
        }
        activityViewController.completionWithItemsHandler = { (_, _, _, _) in
            isPresented = false
        }
    }
}
