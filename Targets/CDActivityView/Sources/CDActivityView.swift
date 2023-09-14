//
//  CDActivityView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI

public struct CDActivityView: UIViewControllerRepresentable {

    @Binding var activityItmes: [Any]
    
    public func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let activityViewController = UIActivityViewController(
            activityItems: activityItmes,
            applicationActivities: nil
        )
        
        var isPresented: Binding<Bool> {
            if activityItmes.isEmpty {
                return .constant(false)
            } else {
                return Binding(
                    get: {
                        activityItmes.isEmpty == false
                    },
                    set: { isShowing in
                    }
                )
            }
        }
        
        if isPresented.wrappedValue && uiViewController.presentedViewController == nil {
            uiViewController.present(activityViewController, animated: true)
        }
    }
    
    
    
}
