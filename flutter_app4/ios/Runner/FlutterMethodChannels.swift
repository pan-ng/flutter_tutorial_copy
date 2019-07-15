//
//  FlutterMethodChannels.swift
//  Runner
//
//  Created by Ng Yat Pan on 10/6/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class FlutterMethodChannels {
    static let shared = FlutterMethodChannels()
    
    init(){
        
    }
    
    func register(with: FlutterAppDelegate){
        guard let fvc = with.window.rootViewController as? FlutterViewController else {
            return
        }
        
        
        let channel = FlutterMethodChannel(name: "pan.flutter.dev/default_method_channel",
                                                       binaryMessenger: fvc)
        
        
    
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result:@escaping FlutterResult) -> Void in
            switch call.method {
            case "getDebugMsg":
               
                
                channel.invokeMethod("getDartNumber", arguments:  nil, result : {
                    dartResult in
                    if let successResult = dartResult as? NSNumber {
                        result("Success iOS: \(successResult)")
                        NSLog("Success iOS \(successResult)")
                    } else {
                        result("from iOS: 1234")
                        NSLog("Error iOS")
                    }
                });
                
                
                 NSLog("from iOS: 1234")
               //  result("from iOS: 1234")
                
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        FlutterMethodChannel.method
    }
}
