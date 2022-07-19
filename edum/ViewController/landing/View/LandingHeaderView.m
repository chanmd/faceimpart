//
//  LandingHeaderView.m
//  gwlx
//
//  Created by Chan Kevin on 10/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "LandingHeaderView.h"

#define __avatar_size 32

@implementation LandingHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithHEX:0xffffff Alpha:0.96];
        self.backgroundColor = __color_white;
        [self addSubview:self.view_separator_up];
        [self addSubview:self.imageview_avatar];
        [self addSubview:self.label_name];
//        [self addSubview:self.label_bio];
        [self addSubview:self.button_profile];
        [self addSubview:self.label_time];
        [self addSubview:self.view_separator];
    }
    return self;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(6.5, 6.5, __avatar_size, __avatar_size)];
        _imageview_avatar.layer.cornerRadius = __avatar_size / 2;
        _imageview_avatar.clipsToBounds = YES;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(10 + __avatar_size + 6.5, 12.5, 200, 20)];
        _label_name.font = __fontbold(14);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UIButton *)button_profile
{
    if (!_button_profile) {
        _button_profile = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 230, 45)];
    }
    return _button_profile;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(10 + __avatar_size + 6.5, 5 + 20, 200, 20)];
        _label_bio.font = __font(12);
        _label_bio.textColor = __color_font_placeholder;
       
    }
    return _label_bio;
}

- (UIView *)view_separator_up
{
    if (!_view_separator_up) {
        _view_separator_up = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.5)];
        _view_separator_up.layer.borderWidth = 0.5;
        _view_separator_up.layer.borderColor = [__color_gray_separator CGColor];
    }
    return _view_separator_up;
}

- (UIView *)view_separator
{
    if (!_view_separator) {
        _view_separator = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, APPScreenWidth, 0.5)];
        _view_separator.layer.borderWidth = 0.5;
        _view_separator.layer.borderColor = [__color_gray_separator CGColor];
    }
    return _view_separator;
}

- (void)bindData:(NSDictionary *)dict
{
    
    self.label_name.text = [dict stringForKey:@"nickname"];
    [self.imageview_avatar sd_setImageWithURL:SHORTURL([dict stringForKey:@"headimgurl"])];
}

@end
