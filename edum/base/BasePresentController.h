//
//  BasePresentController.h
//  gwlx
//
//  Created by Kevin Chan on 4/7/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BaseViewController.h"

@interface BasePresentController : BaseViewController

@property (nonatomic, strong) UIView *view_navigationbar;
@property (nonatomic, strong) UIView *view_navigationitem;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIButton *button_back;
@property (nonatomic, strong) UIView *view_navi_border;

- (NSString *)uniqueIdentity;

@end
