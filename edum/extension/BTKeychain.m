//
//  BTKeychain.m
//  gwlx
//
//  Created by Chan Kevin on 3/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "BTKeychain.h"
#import "KeychainItemWrapper.h"
#import <Security/Security.h>

@implementation BTKeychain

+(NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service,(__bridge_transfer id)kSecAttrService,
            service,(__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+(void)saveKeychain:(NSString *)service withData:(id)data {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]
                      forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+(id)loadKeychain:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue
                      forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne
                      forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed:%@",service, exception);
        }
        @finally {
        }
    }
    
    return ret;
}

+(void)deleteKeyChain:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

+ (void)saveUUID {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_ACCESS_KEY accessGroup:KEYCHAIN_ACCESS_GROUP];
    NSString *string = [keychainItem objectForKey: (__bridge id)kSecAttrGeneric];
    if([string isEqualToString:@""] || !string){
        [keychainItem setObject:[self getUUID] forKey:(__bridge id)kSecAttrGeneric];
    }
}

+ (NSString *)readUUID {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_ACCESS_KEY accessGroup:KEYCHAIN_ACCESS_GROUP];
    NSString *UUID = [keychainItem objectForKey: (__bridge id)kSecAttrGeneric];
    return UUID;
}

+ (NSString *)getUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}

@end
