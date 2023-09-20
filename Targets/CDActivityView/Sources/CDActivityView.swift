//
//  CDActivityView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI

public struct CDActivityView: UIViewControllerRepresentable {

    @Binding var activityItem: CDActivityType
    
    public init(activityItem: Binding<CDActivityType>) {
        self._activityItem = activityItem
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        return UIActivityViewController(
            activityItems: [self.activityItem.toActivity],
            applicationActivities: nil
        )
        
//        uiViewController.present(activityViewController, animated: true)
        
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
