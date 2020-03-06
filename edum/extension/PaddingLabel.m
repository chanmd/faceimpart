//
//  PaddingLabel.m
//  gwlx
//
//  Created by Chan Kevin on 26/1/16.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "PaddingLabel.h"

@implementation PaddingLabel

@synthesize insets=_insets;

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

- (id)initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
