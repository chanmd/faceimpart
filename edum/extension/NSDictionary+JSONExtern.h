
//  Created by Hunter on 13-03-16.
//  Copyright (c) 2013年 Hunter. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  字典里的取值
 */

@interface NSDictionary (JSONExtern)

- (NSString *)stringForKey:(id)key;

- (NSString *)stringIntForKey:(id)key;

- (NSString *)stringDoubleValueForKey:(id) key;

- (NSString *)stringFloatForKey:(id)key;

// json: return nil if the object is NSNull or not a NSDictionary
- (NSDictionary *)dictionaryForKey:(id)key;

// json: return nil if the object is null or not a NSArray.
- (NSMutableArray *)arrayForKey:(id)key;

@end
