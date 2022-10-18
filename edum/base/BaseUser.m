//
//  BaseUser.m
//  gwlx
//
//  Created by Chan Kevin on 26/7/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "BaseUser.h"

@implementation BaseUser

static BaseUser *_instance;

+ (BaseUser *)instance
{
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    });
    
    return _instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


- (NSString *)sex
{
    return [BTKeychain loadKeychain:@"sex"];
}

- (void)setSex:(NSString *)sex
{
    if (!sex) {
        return;
    }
    [BTKeychain saveKeychain:@"sex" withData:sex];
}

- (NSString *)openid
{
    return [BTKeychain loadKeychain:@"openid"];
}

- (void)setOpenid:(NSString *)openid
{
    if (!openid) {
        return;
    }
    [BTKeychain saveKeychain:@"openid" withData:openid];
}

- (NSString *)unionid
{
    return [BTKeychain loadKeychain:@"unionid"];
}

- (void)setUnionid:(NSString *)unionid
{
    if (!unionid) {
        return;
    }
    [BTKeychain saveKeychain:@"unionid" withData:unionid];
}

- (NSString *)nickname
{
    return [BTKeychain loadKeychain:@"nickname"];
}

- (void)setNickname:(NSString *)nickname
{
    if (!nickname) {
        return;
    }
    [BTKeychain saveKeychain:@"nickname" withData:nickname];
}


- (NSString *)province
{
    return [BTKeychain loadKeychain:@"province"];
}

- (void)setProvince:(NSString *)province
{
    if (!province) {
        return;
    }
    [BTKeychain saveKeychain:@"province" withData:province];
}

- (NSString *)country
{
    return [BTKeychain loadKeychain:@"country"];
}

- (void)setCountry:(NSString *)country
{
    if (!country) {
        return;
    }
    [BTKeychain saveKeychain:@"country" withData:country];
}

- (NSString *)city
{
    return [BTKeychain loadKeychain:@"city"];
}

- (void)setCity:(NSString *)city
{
    if (!city) {
        return;
    }
    [BTKeychain saveKeychain:@"city" withData:city];
}

- (NSString *)headimgurl
{
    if (![BTKeychain loadKeychain:@"headimgurl"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"headimgurl"];
}

- (void)setHeadimgurl:(NSString *)headimgurl
{
    if (!headimgurl) {
        return;
    }
    [BTKeychain saveKeychain:@"headimgurl" withData:headimgurl];
}

- (NSString *)ap_givenName
{
    if (![BTKeychain loadKeychain:@"ap_givenName"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"ap_givenName"];
}

- (void)setAp_givenName:(NSString *)ap_givenName
{
    if (!ap_givenName) {
        return;
    }
    [BTKeychain saveKeychain:@"ap_givenName" withData:ap_givenName];
}

- (NSString *)ap_email
{
    if (![BTKeychain loadKeychain:@"ap_email"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"ap_email"];
}

- (void)setAp_email:(NSString *)ap_email
{
    if (!ap_email) {
        return;
    }
    [BTKeychain saveKeychain:@"ap_email" withData:ap_email];
}

- (NSData *)ap_authorizationCode
{
    if (![BTKeychain loadKeychain:@"ap_authorizationCode"]) {
        return [NSData new];
    }
    return [BTKeychain loadKeychain:@"ap_authorizationCode"];
}

- (void)setAp_authorizationCode:(NSString *)ap_authorizationCode
{
    if (!ap_authorizationCode) {
        return;
    }
    [BTKeychain saveKeychain:@"ap_authorizationCode" withData:ap_authorizationCode];
}

- (NSData *)ap_identityToken
{
    if (![BTKeychain loadKeychain:@"ap_identityToken"]) {
        return [NSData new];
    }
    return [BTKeychain loadKeychain:@"ap_identityToken"];
}

- (void)setAp_identityToken:(NSData *)ap_identityToken
{
    if (!ap_identityToken) {
        return;
    }
    [BTKeychain saveKeychain:@"ap_identityToken" withData:ap_identityToken];
}

- (NSString *)loginType
{
    if (![BTKeychain loadKeychain:@"loginType"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"loginType"];
}

- (void)setLoginType:(NSString *)loginType
{
    if (!loginType) {
        return;
    }
    [BTKeychain saveKeychain:@"loginType" withData:loginType];
}


- (NSString *)user_id
{
//    return @"test_user_id";
    if (![BTKeychain loadKeychain:@"user_id"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"user_id"];
}

- (void)setUser_id:(NSString *)user_id
{
    if (!user_id) {
        return;
    }
    [BTKeychain saveKeychain:@"user_id" withData:user_id];
}

- (void)setToken:(NSString *)token
{
    if (!token) {
        return;
    }
    [BTKeychain saveKeychain:@"token" withData:token];
}

- (NSString *)token
{
    if (![BTKeychain loadKeychain:@"token"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"token"];
}

- (void)setMobile_phone:(NSString *)mobile_phone
{
    if (!mobile_phone) {
        return;
    }
    [BTKeychain saveKeychain:@"mobile_phone" withData:mobile_phone];
}

- (NSString *)mobile_phone
{
    if (![BTKeychain loadKeychain:@"mobile_phone"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"mobile_phone"];
}

- (void)setCode:(NSString *)code
{
    if (!code) {
        return;
    }
    [BTKeychain saveKeychain:@"code" withData:code];
}

- (NSString *)code
{
    if (![BTKeychain loadKeychain:@"code"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"code"];
}

- (void)setStatus:(NSString *)status
{
    if (!status) {
        return;
    }
    [BTKeychain saveKeychain:@"status" withData:status];
}

- (NSString *)status
{
    if (![BTKeychain loadKeychain:@"status"]) {
        return @"";
    }
    return [BTKeychain loadKeychain:@"status"];
}

- (BOOL)isLogin
{
    if (self.user_id.length > 0 && self.token.length > 0) {
        return YES;
    }
    return NO;
}

- (NSDictionary *)user
{
    if (![BTKeychain loadKeychain:@"user"]) {
        return [NSDictionary dictionary];
    }
    return [BTKeychain loadKeychain:@"user"];
}

- (void)setUser:(NSDictionary *)user
{
    if (!user) {
        return;
    }
    [BTKeychain saveKeychain:@"status" withData:user];
}

- (NSDictionary *)teacher
{
    if (![BTKeychain loadKeychain:@"teacher"]) {
        return [NSDictionary dictionary];
    }
    return [BTKeychain loadKeychain:@"teacher"];
}

- (void)setTeacher:(NSDictionary *)teacher
{
    if (!teacher) {
        return;
    }
    [BTKeychain saveKeychain:@"teacher" withData:teacher];
}

- (void)destory_all
{
    [BTKeychain deleteKeyChain:@"user_id"];
    [BTKeychain deleteKeyChain:@"openid"];
    [BTKeychain deleteKeyChain:@"unionid"];
    [BTKeychain deleteKeyChain:@"sex"];
    [BTKeychain deleteKeyChain:@"nickname"];
    [BTKeychain deleteKeyChain:@"province"];
    [BTKeychain deleteKeyChain:@"city"];
    [BTKeychain deleteKeyChain:@"country"];
    [BTKeychain deleteKeyChain:@"headimgurl"];
    
    [BTKeychain deleteKeyChain:@"token"];
    
    [BTKeychain deleteKeyChain:@"user"];
    [BTKeychain deleteKeyChain:@"teacher"];
    [BTKeychain deleteKeyChain:@"user_id"];
    [BTKeychain deleteKeyChain:@"code"];
    [BTKeychain deleteKeyChain:@"mobile_phone"];
    [BTKeychain deleteKeyChain:@"status"];
}


@end
