//
//  CourseContentBriefCell.m
//  edum
//
//  Created by Kevin Chan on 10/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseContentBriefCell.h"

@implementation CourseContentBriefCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_category];
        [self.contentView addSubview:self.label_title];
    }
    return self;
}

- (UIButton *)button_user
{
    if (!_button_user) {
        _button_user = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 80)];
    }
    return _button_user;
}

- (UILabel *)label_category
{
    if (!_label_category) {
        _label_category = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APPScreenWidth - 10, 20)];
        _label_category.font = __fontmedium(12);
        _label_category.textColor = __color_font_placeholder;
    }
    return _label_category;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, APPScreenWidth - 30, 30)];
        _label_title.font = __fontbold(22);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (UIView *)view_lark
{
    if (!_view_lark) {
        _view_lark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 180)];
        [_view_lark addSubview:self.imageview_feature];
        [_view_lark addSubview:self.imageview_avatar];
        [_view_lark addSubview:self.label_name];
        [_view_lark addSubview:self.button_user];
        [_view_lark addSubview:self.imageview_chat];
        [_view_lark addSubview:self.imageview_group];
        [_view_lark addSubview:self.imageview_address];
        [_view_lark addSubview:self.label_chat];
        [_view_lark addSubview:self.label_group];
        [_view_lark addSubview:self.label_address];
        //        [_view_lark addSubview:self.view_border];
    }
    return _view_lark;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 30 - 60, 6, 60, 60)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 30.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(14, 20, APPScreenWidth - 100, 20)];
        _label_name.font = __font(16);
        _label_name.textColor = __color_font_title;
        _label_name.numberOfLines = 0;
    }
    return _label_name;
}

- (UIImageView *)imageview_group
{
    if (!_imageview_group) {
        _imageview_group = [[UIImageView alloc] initWithFrame:CGRectMake(15, 90, 22, 22)];
        _imageview_group.image = [UIImage imageNamed:@"order_group"];
    }
    return _imageview_group;
}

- (UIImageView *)imageview_chat
{
    if (!_imageview_chat) {
        _imageview_chat = [[UIImageView alloc] initWithFrame:CGRectMake(15, 126, 18, 18)];
        _imageview_chat.image = [UIImage imageNamed:@"order_chat"];
    }
    return _imageview_chat;
}

- (UIImageView *)imageview_address
{
    if (!_imageview_address) {
        _imageview_address = [[UIImageView alloc] initWithFrame:CGRectMake(15, 160, 22, 22)];
        _imageview_address.image = [UIImage imageNamed:@"order_pin"];
    }
    return _imageview_address;
}

- (UILabel *)label_group
{
    if (!_label_group) {
        _label_group = [[UILabel alloc] initWithFrame:CGRectMake(44, 90, 200, 20)];
        _label_group.font = __font(14);
        _label_group.textColor = __color_font_title;
    }
    return _label_group;
}

- (UILabel *)label_chat
{
    if (!_label_chat) {
        _label_chat = [[UILabel alloc] initWithFrame:CGRectMake(44, 125, 200, 20)];
        _label_chat.font = __font(14);
        _label_chat.textColor = __color_font_title;
    }
    return _label_chat;
}

- (UILabel *)label_address
{
    if (!_label_address) {
        _label_address = [[UILabel alloc] initWithFrame:CGRectMake(44, 160, 200, 20)];
        _label_address.font = __font(14);
        _label_address.textColor = __color_font_title;
    }
    return _label_address;
}


- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 69.5, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (void)bindUser:(NSDictionary *)dic
{
    NSString *fb_url;
    if ([[dic stringForKey:@"fb_picture"] length] > 0) {
        fb_url =  [dic stringForKey:@"fb_picture"];
    } else {
        if ([dic stringForKey:@"fb_id"]) {
            fb_url =  [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", [dic stringForKey:@"fb_id"]];
        }
    }
    [self.imageview_avatar sd_setImageWithURL:SHORTURL(fb_url) placeholderImage:ImageNamed(@"logo_avatar")];
    
    if ([[dic stringForKey:@"languages"] length] > 0) {
        self.label_chat.text = [NSString stringWithFormat:@"Offered in %@", [dic stringForKey:@"languages"]];
    } else {
        self.label_chat.text = @"Offered in English";
    }
    
    NSString *user_name = [dic stringForKey:@"fb_name"];
    if ([user_name length] == 0) {
        self.label_name.text = @"Hello, I'm your guide.";
    } else {
        self.label_name.text = [NSString stringWithFormat:@"Hello, I'm your guide %@", user_name];
    }
    
    [self.label_name sizeToFit];
}

- (void)bindDict:(NSDictionary *)dic
{
    self.label_title.text = [dic stringForKey:@"title"];
    self.label_title.width = APPScreenWidth - 30;
    [self.label_title sizeToFit];
    self.view_lark.top = self.label_title.bottom + 20;
    if ([dic stringForKey:@"country"] && [dic stringForKey:@"type"]) {
//        self.label_category.text = [NSString stringWithFormat:@"%@ | %@", [dic stringForKey:@"country"], [dic stringForKey:@"type"]];
        self.label_category.text = [NSString stringWithFormat:@"%@ | %@", @"练习时间10分钟", @"难度指数 ★★"];
    }
    NSInteger feature = [[dic stringIntForKey:@"feature"] integerValue];
    if (feature == 1) {
        //        self.imageview_feature.hidden = NO;
    }
    //    self.view_border.top = self.label_category.bottom + 14 + 68;
}

- (NSString *)star_rate:(NSInteger)rate
{
    switch (rate) {
        case 1:
            return @"★";
            break;
        case 2:
            return @"★★";
            break;
        case 3:
            return @"★★★";
            break;
        case 4:
            return @"★★★★";
            break;
        case 5:
            return @"★★★★★";
            break;
        default:
            return @"★";
            break;
    }
}

@end
