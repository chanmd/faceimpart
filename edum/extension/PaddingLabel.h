//
//  PaddingLabel.h
//  gwlx
//
//  Created by Chan Kevin on 26/1/16.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaddingLabel : UILabel

@property(nonatomic) UIEdgeInsets insets;

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets;
- (id)initWithInsets:(UIEdgeInsets)insets;

@end
