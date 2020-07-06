//
//  NSTimer+UnretainCircle.h
//  edum
//
//  Created by Kevin Chan on 1/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#if TARGET_IPHONE_SIMULATOR
#else
//#import <AppKit/AppKit.h>
#endif



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (UnretainCircle)

+ (NSTimer *)proxyScheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                      repeats:(BOOL)repeats
                                        block:(void(^)(NSTimer *timer))block;

+ (void)blcokInvoke:(NSTimer *)timer;

@end

NS_ASSUME_NONNULL_END
