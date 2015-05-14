//
//  AccountService.swift
//  testSwift
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

import Foundation

private let _AccountServiceSharedInstance = AccountService()

protocol AccountServiceProtocol {
    //For Signin View Controller
    func loginRequestCallback(success: Bool, failureResponse response: String)
}

class AccountService: AccountGatewayProtocol {
    
    var delegate:AccountServiceProtocol?
    
    static let sharedInstance = AccountService()
    
    //I used this mode of lazy initialization in ObjC to deal with dependencies when unit-testing easily but don't know how necessary it is for SWIFT, I guess that'll require a bit of research
    private var _accountGateway: AccountGateway? = nil
    var accountGateway: AccountGateway = AccountGateway()
    
    func makeLoginRequestWithEmailAddress(emailAddress: String, andPassword password: String)
    {
        if !self.isInternetAvailable()
        {
            self.delegate?.loginRequestCallback(false, failureResponse: "No Internet Connection");
        }
        else if !self.isValidEmailAddress(emailAddress, andPassword: password)
        {
            self.delegate?.loginRequestCallback(false, failureResponse: "Incorrect Email / Password Format");
        }
        else {
            self.accountGateway.gatewayDelegate = self
            self.accountGateway.requestLogin(emailAddress, password: password)
        }
    }

    
    func respondLoginSuccessWithResponseObject(responseObject:AnyObject?) {
        if let responseDic: AnyObject? = responseObject {
            //Parse and save user object
            let userModel:UserModel = UserModel(fromDictionary: responseDic as! Dictionary<String, String>)
            self.storeSignedInUser(userModel)
            self.delegate?.loginRequestCallback(true, failureResponse: "")
        }
        else {
            self.delegate?.loginRequestCallback(false, failureResponse: "Empty Response");
        }
    }
    func respondLoginFailedWithErrorMessage(errorMessage:String) {
        self.delegate?.loginRequestCallback(false, failureResponse: errorMessage);
    }
    
    func isInternetAvailable() -> Bool {
        let networkReachability:Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus:NetworkStatus = networkReachability.currentReachabilityStatus()
        if networkStatus == NetworkStatus.NotReachable {
            return false
        }
        else {
            return true
        }
    }
    
    func isValidEmailAddress(emailAddress: String, andPassword password: String) -> Bool
    {
        var emailAddress:String = emailAddress.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var password:String = password.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if count(emailAddress) > 1 && self.validateRfcCompliantEmail(emailAddress) && count(password) >= 5 {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Email Address Helper Functions
    
    func validateRfcCompliantEmail(candidate: String) -> Bool
    {
        if candidate.rangeOfString("@") == nil {
            return false
        }
        
        if let match = candidate.rangeOfString("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", options: .RegularExpressionSearch) {
            return true
        }
        return false
    }
    
    
    func validatePassword(candidate: String) -> Bool {
        let passwordRegex:String?
        if AppUtility.getCurrentLanguage() == "ar" {
            passwordRegex = "^[\\S]{5,}$";
        }
        else {
            passwordRegex = "^[A-Za-z0-9$@#%&*!]{5,}$";
        }

        var passwordTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex!)
        return passwordTest.evaluateWithObject(candidate);
}

    // MARK: - NSUserDefaults Methods
    
    func getSignedInUser() -> UserModel?
    {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(SIGNED_IN_USER_KEY) as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? UserModel
        }
        return nil
    }
    
    func storeSignedInUser(signedInUserModel: UserModel) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(signedInUserModel)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: SIGNED_IN_USER_KEY)
    }
    
    func signOutUser() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(SIGNED_IN_USER_KEY)
    }
}

