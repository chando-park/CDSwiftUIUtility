//
//  CDWebStatus.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

public protocol JavascripFunctionList_P: RawRepresentable where RawValue == String{}

public extension JavascripFunctionList_P{    
    func call(with param: [String]?) -> String{
        if let _ = param{
            var f = self.rawValue + "("
            for p in param!{
                let e = "'\(p)'"
                f += e
                f += ","
            }
            let _ = f.removeLast()
            return f + ")"
            
        }else{
            return self.rawValue + "()"
        }
    }
}


extension WKWebView {
    public func callJavaScript<List:JavascripFunctionList_P>(function jf: List, param: [String]? = nil){
        let f = jf.call(with: param)
        self.evaluateJavaScript(f, completionHandler: nil)
    }
}




//public enum JavascripFunctionList: String, JavascripFunctionList_P {
//    case jf_LFAPP_Alert_Confirm
//    case jf_LFAPP_Finish_EndPlayer
//    case jf_LFAPP_back
//    case jf_LFAPP_PaymentData
//    case jf_LFAPP_SetPushStatus
//}
