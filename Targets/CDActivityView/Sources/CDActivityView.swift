//
//  CDActivityView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI

public struct CDActivityView: UIViewControllerRepresentable {

    @Binding var activityItem: CDActivityType
    @Binding var isPresented: Bool

    public init(activityItem:  Binding<CDActivityType>, isPresented:  Binding<Bool>) {
        self._activityItem = activityItem
        self._isPresented = isPresented
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
        
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let activityViewController = UIActivityViewController(
            activityItems: [self.activityItem.toActivity],
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
