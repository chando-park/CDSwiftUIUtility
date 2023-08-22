//
//  NativeFuntionList.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

public protocol NativeMessageList_P: RawRepresentable where RawValue == String{}

public extension WKUserContentController{
    func removeScriptMessage<Message:NativeMessageList_P>(message: Message){
        self.removeScriptMessageHandler(forName: message.rawValue)
    }
    
    func removeScriptMessages<Message:NativeMessageList_P>(messages: [Message]){
        for message in messages{
            self.removeScriptMessageHandler(forName: message.rawValue)
        }
    }

    func addScriptMessage<Message:NativeMessageList_P>(_ handler: WKScriptMessageHandler, message: Message){
        self.add(handler, name: message.rawValue)
    }
    
    func addScriptMessages<Message:NativeMessageList_P>(_ handler: WKScriptMessageHandler, messages: [Message]){
        for message in messages{
            self.addScriptMessage(handler, message: message)
        }
    }
}
