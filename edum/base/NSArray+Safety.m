//
//  NSArray+Safety.m
//  TKApp
//
//  Created by 张薇薇 on 2021/9/8.
//  Copyright © 2021 liubao. All rights reserved.
//

#import "NSArray+Safety.h"
#import <objc/runtime.h>

@implementation NSArray (Safety)
+ (void)load {
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndexedSubscript:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    
    Method oldMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndex:));
    method_exchangeImplementations(oldMObjectAtIndex, newMObjectAtIndex);
    
    Method oldMMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method newMMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndexedSubscript:));
    method_exchangeImplementations(oldMMutableObjectAtIndex, newMMutableObjectAtIndex);
}

- (id)newObjectAtIndex:(NSUInteger)index {
    @try {
        return [self newObjectAtIndex:index];
    } @catch (NSException * exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newObjectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self newObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newMutableObjectAtIndex:(NSUInteger)index {
    @try {
        return [self newMutableObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newMutableObjectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self newMutableObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

@end
