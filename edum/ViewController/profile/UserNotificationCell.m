//
//  UserNotificationCell.m
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "UserNotificationCell.h"
#import "UILabel+LineSpace.h"
#import "NSDate+Category.h"

@implementation UserNotificationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = __color_gray_background;
        [self.contentView addSubview:self.label_datetime];
        [self.contentView addSubview:self.view_container];
    }
    return self;
}

- (UILabel *)label_datetime
{
    if (!_label_datetime) {
        _label_datetime = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 150, 22)];
        _label_datetime.font = __font(11);
        _label_datetime.textColor = __color_font_subtitle;
        _label_datetime.centerX = APPScreenWidth / 2;
        _label_datetime.textAlignment = NSTextAlignmentCenter;
        _label_datetime.layer.cornerRadius = 11.f;
        _label_datetime.layer.backgroundColor = [__color_gray_separator CGColor];
    }
    return _label_datetime;
}

-(UILabel *)newMessageLabel
{
    if (!_newMessageLabel)
    {
        _newMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 30)];
        _newMessageLabel.backgroundColor = __color_clear;
        _newMessageLabel.textAlignment = NSTextAlignmentCenter;
        _newMessageLabel.font = __font(16);
        _newMessageLabel.textColor = __color_font_title;
        _newMessageLabel.text = @"————  以下是最新消息  ————";
        _newMessageLabel.hidden = YES;
    }
    return _newMessageLabel;
}

-(UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, APPScreenWidth - 70, 22)];
        _label_title.font = __fontthin(18);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
    }
    return _label_title;
}

- (UIView *)view_container {
    if (!_view_container){
        _view_container = [[UIView alloc] initWithFrame:CGRectMake(10, 62, APPScreenWidth - 20, 150)];
        _view_container.backgroundColor = __color_white;
        _view_container.layer.cornerRadius = 3;
        _view_container.layer.masksToBounds = YES;
        [_view_container addSubview:self.label_title];
        [_view_container addSubview:self.imageview_accessroy];
        [_view_container addSubview:self.view_border];
        [_view_container addSubview:self.label_subtitle];
    }
    return _view_container;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 40, APPScreenWidth - 40, 0.5)];
        _view_border.backgroundColor = __color_gray_light;
    }
    return _view_border;
}

-(UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, APPScreenWidth - 40, 25)];
        _label_subtitle.font = __fontthin(16);
        _label_subtitle.textColor = __color_font_subtitle;
        _label_subtitle.numberOfLines = 0;
    }
    return _label_subtitle;
}



- (UIImageView *)imageview_accessroy
{
    if (!_imageview_accessroy) {
        _imageview_accessroy = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 20 - 18 - 10, 11, 18, 18)];
        _imageview_accessroy.image = ImageNamed(@"cell_arrow");
    }
    return _imageview_accessroy;
}

- (void)bindUserNotification:(NSDictionary *)message
{
//    NSDate *date = [NSDate dateFromString:((NSString *)[message stringForKey:@"created_at"]) dateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    self.label_datetime.text = [NSDate stringWithDescending:date];
    self.label_datetime.text = [message stringForKey:@"created_at"];
    [self.label_datetime sizeToFit];
    self.label_datetime.width = self.label_datetime.width + 26;
    self.label_datetime.height = 22;
    self.label_datetime.centerX = APPScreenWidth / 2;
    
    
    self.label_title.text = [message stringForKey:@"title"];
    self.label_subtitle.width = APPScreenWidth - 40;
    [self.label_subtitle setText:[message stringForKey:@"content"] lineSpacing:5];
    [self.label_subtitle sizeToFit];
    self.view_container.height = self.label_subtitle.bottom + 10;
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
