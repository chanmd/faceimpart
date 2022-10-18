//
//  BaseUser.h
//  gwlx
//
//  Created by Chan Kevin on 26/7/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTKeychain.h"
#define UserInfo [BaseUser instance]

@interface BaseUser : NSObject

+ (BaseUser *)instance;

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *headimgurl;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *mobile_phone;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSDictionary *user;
@property (nonatomic, copy) NSDictionary *teacher;

@property (nonatomic, copy) NSString *loginType;
@property (nonatomic, copy) NSString *ap_givenName;
@property (nonatomic, copy) NSString *ap_email;
@property (nonatomic, copy) NSData *ap_authorizationCode;
@property (nonatomic, copy) NSData *ap_identityToken;

- (BOOL)isLogin;

- (void)destory_all;

@end
