//
//  CourseBannerCell.m
//  edum
//
//  Created by Kevin Chan on 22/4/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "CourseBannerCell.h"

@implementation CourseBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = __color_white;
        [self.contentView addSubview:self.bg_view];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.imageview_avatar];
        [self.contentView addSubview:self.button_avatar];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)bg_view
{
    if (!_bg_view) {
        _bg_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 200)];
        _bg_view.backgroundColor = __color_main;
    }
    return _bg_view;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, APPScreenWidth - 30, 22)];
        _label_title.font = __font(20);
        _label_title.textColor = __color_white;
        _label_title.numberOfLines = 0;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, APPScreenWidth - 30, 16)];
        _label_subtitle.font = __fontlight(16);
        _label_subtitle.textColor = __color_white;
        _label_subtitle.numberOfLines = 0;
    }
    return _label_subtitle;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 170, 60, 60)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 30;
    }
    return _imageview_avatar;
}

- (UIButton *)button_avatar
{
    if (!_button_avatar) {
        _button_avatar = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_avatar.frame = self.imageview_avatar.frame;
    }
    return _button_avatar;
}

- (void)bindData:(NSDictionary *)data
{
    self.label_title.text = [data stringForKey:@"name"];
    self.label_subtitle.width = APPScreenWidth - 30;
    self.label_subtitle.text = [data stringForKey:@"desc"];
    [self.label_subtitle sizeToFit];
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[[data dictionaryForKey:@"teacher_info"] stringForKey:@"headimgurl"]]];
}

@end
