//
//  CourseHeaderView.m
//  edum
//
//  Created by Kevin Chan on 24/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "CourseHeaderView.h"

#define BOX_WIDTH (APPScreenWidth - 40) / 3

@implementation CourseHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label_title];
        [self addSubview:self.label_subtitle];
        [self addSubview:self.button_more];
        [self addSubview:self.view_box];
        [self addSubview:self.view_border];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth - 20, 30)];
        _label_title.font = __fontmedium(22);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (UIView *)view_box
{
    if (!_view_box) {
        _view_box = [[UIView alloc] initWithFrame:CGRectMake(0, 50, APPScreenWidth, 220)];
        
        [_view_box addSubview:self.intensitybox];
        [_view_box addSubview:self.calbox];
        [_view_box addSubview:self.durationbox];
        
        [_view_box addSubview:self.view_contact];
    
    }
    return _view_box;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, APPScreenWidth - 20, 30)];
        _label_subtitle.textColor = __color_font_subtitle;
        _label_subtitle.font = __font(14);
        _label_subtitle.numberOfLines = 4;
    }
    return _label_subtitle;
}

- (UIButton *)button_more
{
    if (!_button_more) {
        _button_more = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_more.frame = CGRectMake(10, 30, 80, 16);
        [_button_more setTitle:@"全部内容" forState:UIControlStateNormal];
        [_button_more setTitleColor:__color_main forState:UIControlStateNormal];
        _button_more.titleLabel.font = __font(14);
        _button_more.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _button_more;
}

- (CourseHeadBox *)durationbox
{
    if (!_durationbox) {
        _durationbox = [[CourseHeadBox alloc] initWithFrame:CGRectMake(20 + BOX_WIDTH, 10, BOX_WIDTH, 70)];
    }
    return _durationbox;
}

- (CourseHeadBox *)intensitybox
{
    if (!_intensitybox) {
        _intensitybox = [[CourseHeadBox alloc] initWithFrame:CGRectMake(APPScreenWidth - BOX_WIDTH - 10, 10, BOX_WIDTH, 70)];
    }
    return _intensitybox;
}

- (CourseHeadBox *)calbox
{
    if (!_calbox) {
        _calbox = [[CourseHeadBox alloc] initWithFrame:CGRectMake(10, 10, BOX_WIDTH, 70)];
    }
    return _calbox;
}

- (UIView *)view_contact
{
    if (!_view_contact) {
        _view_contact = [[UIView alloc] initWithFrame:CGRectMake(0, 130, APPScreenWidth, 54)];
        [_view_contact addSubview:self.imageview_avatar];
        [_view_contact addSubview:self.label_name];
        [_view_contact addSubview:self.label_bio];
        [_view_contact addSubview:self.button_teacher];
//        [_view_contact addSubview:self.button_follow];
    }
    return _view_contact;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 34, 34)];
        _imageview_avatar.layer.masksToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 17.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, 10, 200, 18)];
        _label_name.font = __fontthin(14);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, self.label_name.bottom, 200, 18)];
        _label_bio.font = __fontthin(12);
        _label_bio.textColor = __color_font_placeholder;
    }
    return _label_bio;
}

- (UIButton *)button_teacher
{
    if (!_button_teacher) {
        _button_teacher = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_teacher.clipsToBounds = YES;
        _button_teacher.frame = CGRectMake(0, 15, 200, 44);
        [_button_teacher addTarget:self action:@selector(action_teacher) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_teacher;
}

- (UIButton *)button_follow
{
    if (!_button_follow) {
        _button_follow = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_follow.clipsToBounds = YES;
        _button_follow.frame = CGRectMake(APPScreenWidth - 70, 15, 55, 24);
        _button_follow.layer.backgroundColor = [__color_main CGColor];
        _button_follow.layer.cornerRadius = CORNERRADIUS;
        [_button_follow setTitle:@"关注" forState:UIControlStateNormal];
        [_button_follow setTitleColor:__color_white forState:UIControlStateNormal];
        _button_follow.titleLabel.font = __font(12);
    }
    return _button_follow;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 299, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (void)action_teacher
{
    if (self.block) {
        self.block(self.teacher_id);
    }
}

- (void)bindCourseHeader:(NSDictionary *)data
{
    NSDictionary *user = [data dictionaryForKey:@"user"];
    
//    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oprice attributes:attribtDic];
//    self.label_price_fake.attributedText = attribtStr;
    
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[user stringForKey:@"avatar"]] placeholderImage:ImageNamed(@"logo_launch")];
    self.teacher_id = [user stringForKey:@"user_id"];
    self.label_name.text = [user stringForKey:@"name"];
    self.label_bio.text = @"暂无简介";
    self.label_title.text = [data stringForKey:@"title"];
    self.label_title.width = APPScreenWidth - 20;
    [self.label_title sizeToFit];
    
    self.label_subtitle.top = self.label_title.bottom + 10;
    
    
    
    self.label_subtitle.text = [data stringForKey:@"desc"];
    self.label_subtitle.width = APPScreenWidth - 20;
    [self.label_subtitle sizeToFit];
    
    self.button_more.top = self.label_subtitle.bottom + 15;
    
    self.view_box.top = self.button_more.bottom + 10;
    
    self.durationbox.icon.image = ImageNamed(@"course_duration");
    self.durationbox.label_name.text = @"训练时间";
    self.durationbox.label_bio.text = @"20 分钟";
    
    self.calbox.icon.image = ImageNamed(@"course_cal");
    self.calbox.label_name.text = @"练习频次";
    self.calbox.label_bio.text = @"每天";
    
    self.intensitybox.icon.image = ImageNamed(@"course_intensity");
    self.intensitybox.label_name.text = @"练习强度";
    self.intensitybox.label_bio.text = @"中";
    
    self.view_contact.top = 90;
}

@end
