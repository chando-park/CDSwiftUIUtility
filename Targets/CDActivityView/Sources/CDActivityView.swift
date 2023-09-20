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

    public func makeUIViewController(context: Context) -> UIActivityViewController {
  
        let activityViewController = UIActivityViewController(
            activityItems: [self.activityItem.toActivity],
            applicationActivities: nil
        )
        
        return activityViewController
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }
}
