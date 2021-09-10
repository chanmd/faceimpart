//
//  AvatarView.m
//  gwlx
//
//  Created by Chan Kevin on 19/9/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "AvatarView.h"
#import "UIColor+ColorExtension.h"
#import "UIView+BFExtension.h"
#import "BaseUser.h"

@implementation AvatarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rect = frame;
        [self addSubview:self.imageview_bg];
        [self addSubview:self.view_avatar];
        [self addSubview:self.imageview_avatar];
        [self addSubview:self.label_name];
        [self addSubview:self.button];
//        [self addSubview:self.view_separator];
    }
    return self;
}

- (UIView *)view_avatar
{
    if (!_view_avatar) {
        _view_avatar = [[UIView alloc] initWithFrame:CGRectMake((APPScreenWidth - 74) / 2, 73, 74, 74)];
        _view_avatar.backgroundColor = __color_white;
        _view_avatar.clipsToBounds = YES;
        _view_avatar.layer.cornerRadius = 37;
    }
    return _view_avatar;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 70) / 2, 75, 70, 70)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 35.f;
        _imageview_avatar.hidden = YES;
        _imageview_avatar.image = ImageNamed(@"logo_avatar");
    }
    return _imageview_avatar;
}

- (UIImageView *)imageview_bg
{
    if (!_imageview_bg) {
        _imageview_bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidth / 2)];
        _imageview_bg.image = ImageNamed(@"profile_cover");
    }
    return _imageview_bg;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageview_avatar.bottom + 10, APPScreenWidth, 20)];
        _label_name.font = __fontthin(18);
        _label_name.textColor = __color_font_title;
        _label_name.textAlignment = NSTextAlignmentCenter;
    }
    return _label_name;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.rect;
    }
    return _button;
}

- (UIView *)view_separator
{
    if (!_view_separator) {
        _view_separator = [[UIView alloc] initWithFrame:CGRectMake(0, self.rect.size.height - 0.5, APPScreenWidth, 0.5)];
        _view_separator.backgroundColor = __color_gray_separator;
    }
    return _view_separator;
}

- (void)bindData:(NSDictionary *)dic
{
//    NSString *string = [dic objectForKey:@"headimgurl"];
//    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:string]];
//    self.label_name.text = [dic objectForKey:@"nickname"];
}

@end
