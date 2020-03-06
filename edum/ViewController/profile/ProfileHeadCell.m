//
//  ProfileHeadCell.m
//  gwlx
//
//  Created by Chan Kevin on 20/12/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "ProfileHeadCell.h"

@interface ProfileHeadCell()



@end

@implementation ProfileHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.view_bg];
        [self.contentView addSubview:self.view_avatar];
        [self.contentView addSubview:self.imageview_avatar];
        [self.contentView addSubview:self.label_name];
        [self.contentView addSubview:self.button_follow];
        self.backgroundColor = __color_gray_background;
    }
    return self;
}

- (UIView *)view_bg
{
    if (!_view_bg) {
        _view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 42, APPScreenWidth, 180)];
        _view_bg.backgroundColor = __color_white;
    }
    return _view_bg;
}

- (UIView *)view_avatar
{
    if (!_view_avatar) {
        _view_avatar = [[UIView alloc] initWithFrame:CGRectMake((APPScreenWidth - 84) / 2, 40, 84, 84)];
        _view_avatar.clipsToBounds = YES;
        _view_avatar.layer.cornerRadius = 42.f;
        _view_avatar.backgroundColor = [UIColor colorWithWhite:0xffffff alpha:0.7];
    }
    return _view_avatar;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 80) / 2, 42, 80, 80)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 40.f;
        _imageview_avatar.image = ImageNamed(@"avatar");
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, APPScreenWidth, 20)];
        _label_name.textColor = __color_font_title;
        _label_name.font = __font(18);
        _label_name.textAlignment = NSTextAlignmentCenter;
        _label_name.text = @"Kevin Chan";
    }
    return _label_name;
}

- (UIButton *)button_follow
{
    if (!_button_follow) {
        _button_follow = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_follow.frame = CGRectMake((APPScreenWidth - 70) / 2, 170, 70, 30);
        _button_follow.layer.borderWidth = 1.f;
        [_button_follow setTitleColor:__color_font_title forState:UIControlStateNormal];
        _button_follow.layer.borderColor = [__color_font_title CGColor];
        [_button_follow setTitle:@"关注" forState:UIControlStateNormal];
        _button_follow.titleLabel.font = __font(14);
        _button_follow.layer.cornerRadius = 3.f;
    }
    return _button_follow;
}

@end
