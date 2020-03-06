//
//  BTKeychain.h
//  gwlx
//
//  Created by Chan Kevin on 3/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTKeychain : NSObject

+ (void)saveUUID;
+ (NSString *)readUUID;
+ (NSString *)getUUID;

+ (void)saveKeychain:(NSString *)service withData:(id)data;
+ (id)loadKeychain:(NSString *)service;
+ (void)deleteKeyChain:(NSString *)service;

@end
