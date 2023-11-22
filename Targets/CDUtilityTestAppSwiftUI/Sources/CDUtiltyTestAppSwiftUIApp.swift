//
//  CDUtiltyTestAppSwiftUIApp.swift
//  CDUtiltyTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import SwiftUI
import CDSheetRouter
import CDNavigation
import CDWeb
import CDOrientation


extension NSObject {
    class func swizzle(origSelector: Selector, withSelector: Selector, forClass: AnyClass) {
          let originalMethod = class_getInstanceMethod(forClass, origSelector)
          let swizzledMethod = class_getInstanceMethod(forClass, withSelector)
          method_exchangeImplementations(originalMethod!, swizzledMethod!)
     }
}

extension UIViewController {

   @objc var swizzle_prefersHomeIndicatorAutoHidden: Bool {
       return true
   }

   public class func swizzleHomeIndicatorProperty() {
       self.swizzle(origSelector:#selector(getter: UIViewController.prefersHomeIndicatorAutoHidden),
                    withSelector:#selector(getter: UIViewController.swizzle_prefersHomeIndicatorAutoHidden),
                    forClass:UIViewController.self)
   }
}

@main
struct CDUtiltyTestAppSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate

//    @ObservedObject var vm = AppRouterVM()
//    @ObservedObject var platform = PlatformOperator<AppRouter,AppRouterVM>(viewModel: AppRouterVM())
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }

        }
        
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Override 'prefersHomeIndicatorAutoHidden' in all UIViewControllers
        UIViewController.swizzleHomeIndicatorProperty()

        return true
      }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        print("CDOrientationLock.mask \(CDOrientationLock.shared.currentMask == .portrait)")
        return CDOrientationLock.shared.currentMask
    }
}
