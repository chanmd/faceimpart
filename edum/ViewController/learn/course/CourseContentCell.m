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
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.label_content];
        [self.contentView addSubview:self.view_border];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth - 20, 22)];
        _label_title.font = __fontbold(18);
        _label_title.textColor = __color_font_title;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 20;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, APPScreenWidth - 20, 20)];
        _label_subtitle.font = __font(16);
        _label_subtitle.numberOfLines = 0;
        //        _label_subtitle.lineBreakMode = NSLineBreakByWordWrapping;
        _label_subtitle.textColor = __color_font_subtitle;
    }
    return _label_subtitle;
}

- (UILabel *)label_content
{
    if (!_label_content) {
        _label_content = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, APPScreenWidth - 20, 20)];
        _label_content.font = __font(14);
        _label_content.numberOfLines = 0;
        //        _label_subtitle.lineBreakMode = NSLineBreakByWordWrapping;
        _label_content.textColor = __color_font_subtitle;
    }
    return _label_content;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 99.5, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (void)bindDict:(NSDictionary *)dic
{
    self.label_title.text = [dic stringForKey:@"title"];
    self.label_subtitle.width = APPScreenWidth - 30;
    self.label_subtitle.text = [dic stringForKey:@"subtitle"];
    self.label_content.width = APPScreenWidth - 30;
    self.label_content.text = [dic stringForKey:@"content"];
//    NSString *content = [dic stringForKey:@"subtitle"];
//    [self.label_subtitle setText:content lineSpacing:SIGHT_DETAIL_LINESPACE];
    [self.label_subtitle sizeToFit];
}


@end
