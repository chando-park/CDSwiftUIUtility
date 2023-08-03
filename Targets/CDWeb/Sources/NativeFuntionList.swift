//
//  NativeFuntionList.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

public protocol NativeFuntionList_P: RawRepresentable where RawValue == String{}

public extension WKUserContentController{
    func removeScriptMessage<Message:NativeFuntionList_P>(message: Message){
        self.removeScriptMessageHandler(forName: message.rawValue)
    }

    func addScriptMessage<Message:NativeFuntionList_P>(_ handler: WKScriptMessageHandler, message: Message){
        self.add(handler, name: message.rawValue)
    }
    
    func addScriptMessages<Message:NativeFuntionList_P>(_ handler: WKScriptMessageHandler, messages: [Message]){
        for message in messages{
            self.addScriptMessage(handler, message: message)
        }
    }
}
