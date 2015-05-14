//
//  AccountGateway.swift
//  testSwift
//
//  Created by Waleed Rahman on 5/13/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

import Foundation

protocol AccountGatewayProtocol
{
    func respondLoginSuccessWithResponseObject(responseObject:AnyObject?)
    func respondLoginFailedWithErrorMessage(errorMessage:String)
}

class AccountGateway: BaseApiRequest {
    
    var gatewayDelegate:AccountGatewayProtocol?
    
    func requestLogin(email:String, password:String) {
        let manager:AFHTTPSessionManager? = self.createLoggedOutHTTPSessionManager
        if let managerConst = manager {
            let apiCall:String = self.createAPI(API_LOGIN, parameters: "")
            managerConst.GET(apiCall, parameters: nil, success: {(task, responseObject) in
                //In a real app, I would be sending the response object
                var sampleDict = [USER_EMAIL_KEY : "wir349@gmail.com",
                    USER_ID_KEY : "349",
                    USER_PHONE_NUMBER_KEY : "9516421363",
                    USER_ACCESS_TOKEN_KEY : "321QWERTY",
                    USER_FIRST_NAME_KEY : "Waleed",
                    USER_LAST_NAME_KEY : "Rahman"]
                self.gatewayDelegate?.respondLoginSuccessWithResponseObject(sampleDict)
                }, failure: {(task, error) in
                    //In a real app, I would be returning the error description and success false
                    var sampleDict = [USER_EMAIL_KEY : "wir349@gmail.com",
                        USER_ID_KEY : "349",
                        USER_PHONE_NUMBER_KEY : "9516421363",
                        USER_ACCESS_TOKEN_KEY : "321QWERTY",
                        USER_FIRST_NAME_KEY : "Waleed",
                        USER_LAST_NAME_KEY : "Rahman"]
                    self.gatewayDelegate?.respondLoginSuccessWithResponseObject(sampleDict)
                })
        }

    }
}

