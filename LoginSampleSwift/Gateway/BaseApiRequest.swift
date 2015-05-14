//
//  BaseApiRequest.swift
//  testSwift
//
//  Created by Waleed Rahman on 5/13/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

import Foundation
import UIKit



class BaseApiRequest {
    var createLoggedOutHTTPSessionManager: AFHTTPSessionManager {
        var manager:AFHTTPSessionManager = AFHTTPSessionManager(baseURL: NSURL(string: API_BASR_URL))
        manager.requestSerializer = AFJSONRequestSerializer()
        
        manager.requestSerializer.setValue(API_AGENT_HEADER, forHTTPHeaderField: API_AGENT_HEADER_KEY)
        manager.requestSerializer.setValue(API_PROVIDER_ACCESS_TOKEN, forHTTPHeaderField: API_PROVIDER_ACCESS_HEADER_KEY)
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding
        manager.responseSerializer = AFJSONResponseSerializer()
        
        return manager;
    }
    var createHTTPSessionManager: AFHTTPSessionManager? {
        let user:UserModel? = AccountService.sharedInstance.getSignedInUser()
        if let variableName = user {
            let manager:AFHTTPSessionManager = AFHTTPSessionManager(baseURL: NSURL(string: API_BASR_URL))
            manager.requestSerializer = AFJSONRequestSerializer()
            
            manager.requestSerializer.setValue("\(user?.userId)", forHTTPHeaderField:API_USER_ID_HEADER_KEY)
            manager.requestSerializer.setValue("\(user?.accessToken)", forHTTPHeaderField:API_ACCESS_TOKEN_HEADER_KEY);
            
            manager.requestSerializer.setValue("\(user?.accessToken)", forHTTPHeaderField:API_AUTHORIZATION_HEADER_KEY);
            manager.requestSerializer.setValue("IPHONE", forHTTPHeaderField:API_AGENT_HEADER_KEY);
            manager.requestSerializer.setValue(API_PROVIDER_ACCESS_TOKEN, forHTTPHeaderField:API_PROVIDER_ACCESS_HEADER_KEY);
            
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            
            manager.responseSerializer = AFJSONResponseSerializer();
            
            return manager;
        }
        return nil
    }
    
    func createAPI(apiString:String, parameters:String) -> (String) {
        return "\(apiString)?\(parameters)&device=IPHONE&lang=\(AppUtility.getCurrentLanguage())"
    }
}