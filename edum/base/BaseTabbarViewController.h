//
//  BaseTabbarViewController.h
//  gwlx
//
//  Created by Chan Kevin on 6/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+initWithColor.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#define TAB_COUNT 3

@interface BaseTabbarViewController : BaseViewController

@property (nonatomic, strong) UIView *toolbar;
@property (nonatomic, strong) UIButton *button_a;
@property (nonatomic, strong) UIButton *button_b;
@property (nonatomic, strong) UIButton *button_c;
@property (nonatomic, strong) UIButton *button_d;
@property (nonatomic, strong) UIButton *button_e;

- (void)___action_a;
- (void)___action_b;
- (void)___action_c;
- (void)___action_d;
- (void)___action_e;

- (void)actionLoginView;

- (void)addMyTabbar;

@end
