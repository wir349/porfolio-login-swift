//
//  UserModel.swift
//  testSwift
//
//  Created by Waleed Rahman on 5/13/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

import Foundation

class UserModel: NSObject, NSCoding, Printable {
    
    let userId:Int
    let email:String
    let phoneNumber:String
    let firstName:String
    let lastName:String
    let accessToken:String
    
    override var description: String {
        get {
            return "User Model Is: \(userId) \(email) \(phoneNumber) \(firstName) \(lastName) \(accessToken)"
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.userId, forKey: USER_ID_KEY)
        aCoder.encodeObject(self.email, forKey: USER_EMAIL_KEY)
        aCoder.encodeObject(self.phoneNumber, forKey: USER_PHONE_NUMBER_KEY)
        aCoder.encodeObject(self.firstName, forKey: USER_FIRST_NAME_KEY)
        aCoder.encodeObject(self.lastName, forKey: USER_LAST_NAME_KEY)
        aCoder.encodeObject(self.accessToken, forKey: USER_ACCESS_TOKEN_KEY)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.userId = aDecoder.decodeIntegerForKey(USER_ID_KEY)
        self.email = aDecoder.decodeObjectForKey(USER_EMAIL_KEY) as! String
        self.phoneNumber = aDecoder.decodeObjectForKey(USER_PHONE_NUMBER_KEY) as! String
        self.firstName = aDecoder.decodeObjectForKey(USER_FIRST_NAME_KEY) as! String
        self.lastName = aDecoder.decodeObjectForKey(USER_LAST_NAME_KEY) as! String
        self.accessToken = aDecoder.decodeObjectForKey(USER_ACCESS_TOKEN_KEY) as! String
    }
    
    init(fromDictionary dictionary:Dictionary<String, String>) {
        self.userId = dictionary[USER_ID_KEY]!.toInt()!
        self.email = dictionary[USER_EMAIL_KEY]!
        self.phoneNumber = dictionary[USER_PHONE_NUMBER_KEY]!
        self.firstName = dictionary[USER_FIRST_NAME_KEY]!
        self.lastName = dictionary[USER_LAST_NAME_KEY]!
        self.accessToken = dictionary[USER_ACCESS_TOKEN_KEY]!
    }
    
}