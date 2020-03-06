//
//  StudyListCell.m
//  edum
//
//  Created by Kevin Chan on 19/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "StudyListCell.h"

@implementation StudyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.button_video];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.view_border];
    }
    return self;
}

- (UIButton *)button_video
{
    if (!_button_video) {
        _button_video = [[UIButton alloc] initWithFrame:CGRectMake(25, 25, 30, 30)];
        [_button_video setImage:ImageNamed(@"course_video_n") forState:UIControlStateNormal];
        [_button_video setImage:ImageNamed(@"course_video_h") forState:UIControlStateHighlighted];
    }
    return _button_video;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, APPScreenWidth - 95, 22)];
        _label_title.font = __font(16);
        _label_title.textColor = __color_font_title;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 46, APPScreenWidth - 95, 15)];
        _label_subtitle.font = __fontlight(12);
        _label_subtitle.textColor = __color_font_subtitle;
        _label_subtitle.numberOfLines = 0;
    }
    return _label_subtitle;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, APPScreenWidth, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (void)bindData:(NSDictionary *)course
{
    self.label_title.text = [course stringForKey:@"name"];
    self.label_subtitle.text = [course stringForKey:@"desc"];
}

@end
