//
//  CDActivityView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI

public struct CDActivityView: UIViewControllerRepresentable {

    @Binding var activityItmes: [CDActivityType]
    
    public init(activityItmes: Binding<[CDActivityType]>) {
        self._activityItmes = activityItmes
    }
    
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
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let activityViewController = UIActivityViewController(
            activityItems: activityItmes.map({$0.toActivity}),
            applicationActivities: nil
        )
        
        return activityViewController
    }
    
    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }
}
