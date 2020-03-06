//
//  LandingHeaderView.h
//  gwlx
//
//  Created by Chan Kevin on 10/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+JSONExtern.h"
#import "UIColor+ColorExtension.h"
#import "UIView+BFExtension.h"

@interface LandingHeaderView : UIView

@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;
@property (nonatomic, strong) UILabel *label_time;
@property (nonatomic, strong) UIView *view_separator;
@property (nonatomic, strong) UIView *view_separator_up;
@property (nonatomic, strong) UIButton *button_profile;

- (void)bindData:(NSDictionary *)dict;

@end
