//
//  BasePager.m
//  gwlx
//
//  Created by Chan Kevin on 18/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "BasePager.h"

@implementation BasePager

- (id)initWithNumber:(int)number Size:(int)size
{
    self = [super init];
    if (self) {
        self.number = number;
        self.size = size;
        self.total = 0;
    }
    return self;
}

- (void)addpage
{
    self.number ++;
}

- (NSDictionary *)output
{
    NSDictionary *dic = @{@"number": @(self.number), @"size": @(self.size)};
    return dic;
}

- (BOOL)can_load_more
{
    if (self.total > 0 && (self.number - 1) * self.size < self.total) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
