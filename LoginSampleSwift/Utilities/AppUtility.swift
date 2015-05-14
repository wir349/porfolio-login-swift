//
//  AppUtility.swift
//  testSwift
//
//  Created by Waleed Rahman on 5/13/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

import Foundation
import UIKit

class AppUtility {
    class func getCurrentLanguageDirection() -> NSLocaleLanguageDirection {
        return NSLocale.characterDirectionForLanguage(NSLocale.preferredLanguages()[0] as! String)
    }
    
    class func getCurrentLanguage() -> String {
        return NSLocale.preferredLanguages()[0] as! String;
    }
    
    class func createAlertViewWithMessage(message:String, title:String, tag:NSInteger) -> UIAlertView {
        let alertView:UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "Ok")
        
        alertView.tag  = tag;
        return alertView;

    }
}
