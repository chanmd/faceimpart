//
//  NSTimer+UnretainCircle.m
//  edum
//
//  Created by Kevin Chan on 1/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "NSTimer+UnretainCircle.h"
#if TARGET_IPHONE_SIMULATOR
#else
#import <AppKit/AppKit.h>
#endif

@implementation NSTimer (UnretainCircle)

+ (NSTimer *)proxyScheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                      repeats:(BOOL)repeats
                                        block:(void(^)(NSTimer *timer))block {
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
