//
//  NSObject+Swizzling.h
//  TKApp
//
//  Created by 张薇薇 on 2021/9/14.
//  Copyright © 2021 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end

NS_ASSUME_NONNULL_END
