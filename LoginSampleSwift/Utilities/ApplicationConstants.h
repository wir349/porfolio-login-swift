//
//  ApplicationConstants.h
//  LoginSampleSwift
//
//  Created by Waleed Rahman on 5/13/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

#ifndef LoginSampleSwift_ApplicationConstants_h
#define LoginSampleSwift_ApplicationConstants_h

#define IS_IOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
#define IS_IOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

#define NAV_BAR_COLOR [UIColor colorWithRed:40.0/255.0 green:105.0/255.0 blue:133.0/255.0 alpha:1]
#define TEXT_COLOR [UIColor colorWithRed:0.0/255.0 green:81.0/255.0 blue:114.0/255.0 alpha:1]

#define USER_ID_KEY @"user_id"
#define SIGNED_IN_USER_KEY @"signedInUser"
#define USER_EMAIL_KEY @"emailAdress"
#define USER_PHONE_NUMBER_KEY @"phoneNumber"
#define USER_FIRST_NAME_KEY @"firstName"
#define USER_LAST_NAME_KEY @"lastName"
#define USER_ACCESS_TOKEN_KEY @"accessToken"

#define SIGN_IN_TO_PAYMENT_OPTIONS_SEGUE @"SignInToPaymentOptionsSegue"

#define API_BASR_URL @"https://api.someDummyValue.com/"
#define API_LOGIN @"cloud/customer/login.json"
#define API_USER_ID_HEADER_KEY @"signedInUserId"
#define API_ACCESS_TOKEN_HEADER_KEY @"accessToken"

#define API_AUTHORIZATION_HEADER_KEY @"Authorization"
#define API_AGENT_HEADER_KEY @"Agent"
#define API_PROVIDER_ACCESS_HEADER_KEY @"Provider-Access-Key"

#define API_AGENT_HEADER @"IPHONE"
#define API_PROVIDER_ACCESS_TOKEN @"9cbd776e"

#endif
