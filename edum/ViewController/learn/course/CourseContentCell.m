//
//  CourseContentCell.m
//  edum
//
//  Created by Kevin Chan on 11/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseContentCell.h"
#import "UILabel+LineSpace.h"

@implementation CourseContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.view_shadow];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
    }
    return self;
}

- (UIView *)view_shadow
{
    if (!_view_shadow) {
        _view_shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 50)];
        _view_shadow.backgroundColor = __color_gray_background;
    }
    return _view_shadow;
}


- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, APPScreenWidth - 40, 20)];
        _label_title.font = __fontthin(18);
        _label_title.textColor = __color_font_title;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 40;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, APPScreenWidth - 40, 20)];
        _label_subtitle.preferredMaxLayoutWidth = APPScreenWidth - 40;
        _label_subtitle.font = __fontthin(16);
        _label_subtitle.numberOfLines = 0;
        _label_subtitle.lineBreakMode = NSLineBreakByWordWrapping;
        _label_subtitle.textColor = __color_font_subtitle;
    }
    return _label_subtitle;
}

- (void)bindCourseContent:(NSDictionary *)data
{
    self.label_title.text = [data stringForKey:@"title"];
    self.label_subtitle.width = APPScreenWidth - 40;
    self.label_subtitle.text = [data stringForKey:@"subtitle"];
    [self.label_subtitle setText:[data stringForKey:@"subtitle"] lineSpacing:5];
    [self.label_subtitle sizeToFit];
}

@end
