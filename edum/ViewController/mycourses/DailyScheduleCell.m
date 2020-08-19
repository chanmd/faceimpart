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
        _label_title.textColor = __color_font_title;
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
        _label_time = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_time.right + 5, self.label_title.bottom + 14, APPScreenWidth - 30, 15)];
        _label_time.font = __fontthin(14);
        _label_time.textColor = __color_font_subtitle;
    }
    return _label_time;
}

- (UIButton *)button_status
{
    if (!_button_status) {
        _button_status = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_status.frame = CGRectMake(APPScreenWidth - 45 - 40, 15, 40, 40);
        [_button_status addTarget:self action:@selector(action_call:) forControlEvents:UIControlEventTouchUpInside];
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
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, 12, APPScreenWidth - 100, 18)];
        _label_name.font = __fontthin(14);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, self.label_name.bottom + 2, APPScreenWidth - 100, 18)];
        _label_bio.font = __fontthin(12);
        _label_bio.textColor = __color_font_subtitle;
    }
    return _label_bio;
}

- (void)action_call:(UIButton *)button
{
    NSInteger status = button.tag;
    if (status < 3) {
        if (self.enteryCall) {
            self.enteryCall(self.daily);
        }
    }
}

- (void)setDaily:(NSDictionary *)daily
{
    _daily = daily;
    NSDictionary *user = [daily dictionaryForKey:@"user"];
    NSDictionary *course = [daily dictionaryForKey:@"course"];
    self.label_time.text = [daily stringForKey:@"start_time"];
    self.label_title.text = [course stringForKey:@"title"];
        
    NSString *start_time_string = [daily stringForKey:@"start_time"];
    NSString *end_time_string = [daily stringForKey:@"end_time"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *start_time = [formatter dateFromString:start_time_string];
    NSDate *end_time = [formatter dateFromString:end_time_string];
    NSInteger status = 0;
    NSDate *current_time = [NSDate date];
    NSComparisonResult result_start = [start_time compare:current_time];
    NSComparisonResult result_end = [end_time compare:current_time];
    if (result_start == NSOrderedAscending && result_end == NSOrderedDescending) {
            status = 2;
    } else if (result_start == NSOrderedDescending) {
            status = 1;
    } else if (result_end == NSOrderedAscending) {
            status = 3;
    }
    
    self.label_time.textColor = __color_font_subtitle;
    [self bindScheduleStatus:status];
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[user stringForKey:@"avatar"]] placeholderImage:ImageNamed(@"logo_launch")];
    self.label_name.text = [user stringForKey:@"name"];
    self.label_bio.text = [user stringForKey:@"bio"];
    self.button_status.tag = status;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindScheduleStatus:(NSInteger )status
{
    if (status == 1) {
        self.button_status.tag = status;
        self.button_status.hidden = NO;
        [self.button_status setBackgroundImage:ImageNamed(@"waitingclass") forState:UIControlStateNormal];
        
    } else if (status == 2) {
        self.button_status.hidden = NO;
        [self.button_status setBackgroundImage:ImageNamed(@"processing") forState:UIControlStateNormal];
        self.label_time.textColor = __color_red;
        
    } else if (status == 3){
        self.button_status.hidden = NO;
        [self.button_status setBackgroundImage:ImageNamed(@"ended") forState:UIControlStateNormal];
        
    } else {
        self.button_status.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
