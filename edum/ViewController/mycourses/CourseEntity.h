//
//  CourseEntity.h
//  edum
//
//  Created by Md Chen on 14/7/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseEntity : NSObject

@property (copy, nonatomic) NSString *string;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
