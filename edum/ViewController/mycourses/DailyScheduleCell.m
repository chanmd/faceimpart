//
//  DailyScheduleCell.m
//  edum
//
//  Created by Kevin Chan on 17/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "DailyScheduleCell.h"

@implementation DailyScheduleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = __color_gray_background;
        [self.contentView addSubview:self.view_container];
    }
    return self;
}

- (UIView *)view_container
{
    if (!_view_container) {
        _view_container = [[UIView alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, WEEKLY_CELL_HEIGHT)];
        _view_container.layer.masksToBounds = YES;
        _view_container.layer.cornerRadius = 3.f;
        _view_container.backgroundColor = __color_white;
        [_view_container addSubview:self.label_title];
        [_view_container addSubview:self.imageview_time];
        [_view_container addSubview:self.label_time];
        [_view_container addSubview:self.button_status];
        [_view_container addSubview:self.view_contact];
        
    }
    return _view_container;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, APPScreenWidth - 60, 18)];
        _label_title.font = __fontlight(20);
        _label_title.textColor = __color_font_subtitle;
    }
    return _label_title;
}

- (UIImageView *)imageview_time
{
    if (!_imageview_time) {
        _imageview_time = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.label_title.bottom + 15, 14, 14)];
        _imageview_time.image = ImageNamed(@"time");
    }
    return _imageview_time;
}

- (UILabel *)label_time
{
    if (!_label_time) {
        _label_time = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_time.right + 10, self.label_title.bottom + 14, APPScreenWidth - 30, 15)];
        _label_time.font = __fontlight(14);
        _label_time.textColor = __color_font_placeholder;
    }
    return _label_time;
}

- (UIButton *)button_status
{
    if (!_button_status) {
        _button_status = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_status.frame = CGRectMake(APPScreenWidth - 45 - 40, 15, 40, 40);
        [_button_status setBackgroundImage:ImageNamed(@"processing") forState:UIControlStateNormal];
    }
    return _button_status;
}

- (UIView *)view_contact
{
    if (!_view_contact) {
        _view_contact = [[UIView alloc] initWithFrame:CGRectMake(15, WEEKLY_CELL_HEIGHT - 15 - 64, APPScreenWidth - 60, 64)];
        _view_contact.backgroundColor = __color_gray_background;
        _view_contact.layer.masksToBounds = YES;
        _view_contact.layer.cornerRadius = 3.f;
        [_view_contact addSubview:self.imageview_avatar];
        [_view_contact addSubview:self.label_name];
        [_view_contact addSubview:self.label_bio];
    }
    return _view_contact;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 34, 34)];
        _imageview_avatar.layer.masksToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 17.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, 10, APPScreenWidth - 100, 18)];
        _label_name.font = __fontthin(14);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, self.label_name.bottom, APPScreenWidth - 100, 18)];
        _label_bio.font = __fontthin(12);
        _label_bio.textColor = __color_font_placeholder;
    }
    return _label_bio;
}

- (void)bindDailyData:(NSDictionary *)daily
{
    self.label_time.text = [daily stringForKey:@"time"];
    self.label_title.text = [daily stringForKey:@"title"];
    if ([[daily stringIntForKey:@"status"] isEqualToString:@"1"]) {
        self.button_status.hidden = NO;
        [self.button_status setBackgroundImage:ImageNamed(@"processing") forState:UIControlStateNormal];
        
    } else if ([[daily stringForKey:@"status"] isEqualToString:@"2"]) {
        self.button_status.hidden = NO;
        [self.button_status setBackgroundImage:ImageNamed(@"ended") forState:UIControlStateNormal];
    } else {
        self.button_status.hidden = YES;
    }
    self.imageview_avatar.image = ImageNamed(@"logo_launch");
    self.label_name.text = @"张天一";
    self.label_bio.text = @"大提琴课";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
