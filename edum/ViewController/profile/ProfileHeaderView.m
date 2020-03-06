//
//  ProfileHeaderView.m
//  gwlx
//
//  Created by Chan Kevin on 1/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "ProfileHeaderView.h"
#import "UIColor+ColorExtension.h"
#import "UIView+BFExtension.h"
#import "BaseUser.h"

@implementation ProfileHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.view_background];
        [self addSubview:self.imageview_avatar];
        [self addSubview:self.label_name];
        [self addSubview:self.view_separator];
        [self addSubview:self.label_follower];
        [self addSubview:self.label_following];
        [self addSubview:self.button_follower];
        [self addSubview:self.button_following];
        [self addSubview:self.view_split];
    }
    return self;
}

- (UIView *)view_background
{
    if (!_view_background) {
        _view_background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 110)];
        _view_background.backgroundColor = __color_white;
    }
    return _view_background;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 70, 70)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 35.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(120, 24, APPScreenWidth - 130, 20)];
        _label_name.font = __font(16);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UIView *)view_separator
{
    if (!_view_separator) {
        _view_separator = [[UIView alloc] initWithFrame:CGRectMake(120, 60, APPScreenWidth - 120, 0.5)];
        _view_separator.backgroundColor = __color_gray_separator;
    }
    return _view_separator;
}

- (UIButton *)button_follower
{
    if (!_button_follower) {
        _button_follower = [[UIButton alloc] initWithFrame:CGRectMake(120, 60, 80, 50)];
        _button_follower.backgroundColor = __color_clear;
    }
    return _button_follower;
}

- (UIButton *)button_following
{
    if (!_button_following) {
        _button_following = [[UIButton alloc] initWithFrame:CGRectMake(200, 60, 80, 50)];
        _button_following.backgroundColor = __color_clear;
    }
    return _button_following;
}

- (UILabel *)label_follower
{
    if (!_label_follower) {
        _label_follower = [[UILabel alloc] initWithFrame:CGRectMake(120, 74, 80, 14)];
        _label_follower.font = __font(12);
        _label_follower.textColor = __color_font_placeholder;
    }
    return _label_follower;
}

- (UILabel *)label_following
{
    if (!_label_following) {
        _label_following = [[UILabel alloc] initWithFrame:CGRectMake(220, 74, 80, 14)];
        _label_following.font = __font(12);
        _label_following.textColor = __color_font_placeholder;
    }
    return _label_following;
}

- (UIView *)view_split
{
    if (!_view_split) {
        _view_split = [[UIView alloc] initWithFrame:CGRectMake(0, 109.5, APPScreenWidth, 0.5)];
        _view_split.backgroundColor = __color_gray_separator;
    }
    return _view_split;
}

- (void)bindData:(NSDictionary *)dic
{
    [self bindAvatar:dic];
    [self bindNumber:dic];
}

- (void)bindAvatar:(NSDictionary *)dic
{
    NSString *string = [dic objectForKey:@"headimgurl"];
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:string]];
    self.label_name.text = [dic objectForKey:@"nickname"];
}

- (void)bindNumber:(NSDictionary *)dic
{
    NSString *follower = [dic objectForKey:@"follower"];
    NSString *following = [dic objectForKey:@"following"];
    NSString *string_followers = [NSString stringWithFormat:@"关注者 %@", follower];
    NSString *string_followings = [NSString stringWithFormat:@"关注中 %@", following];
    NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
    [attributesDictionary setObject:__font(16) forKey:NSFontAttributeName];
    [attributesDictionary setObject:__color_font_title forKey:NSForegroundColorAttributeName];
    NSMutableAttributedString *attri_followers = [[NSMutableAttributedString alloc] initWithString:string_followers];
    [attri_followers addAttributes:attributesDictionary range:NSMakeRange(4, string_followers.length - 4)];
    
    NSMutableAttributedString *attri_followings = [[NSMutableAttributedString alloc] initWithString:string_followings];
    [attri_followings addAttributes:attributesDictionary range:NSMakeRange(4, string_followings.length - 4)];
    
    self.label_follower.attributedText = attri_followers;
    [self.label_follower sizeToFit];
    self.label_following.left = self.label_follower.right + 20;
    self.label_following.attributedText = attri_followings;
    [self.label_following sizeToFit];
}

@end
