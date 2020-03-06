//
//  CourseDetailBriefCell.m
//  edum
//
//  Created by Kevin Chan on 9/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseDetailBriefCell.h"
#import "UILabel+LineSpace.h"

@implementation CourseDetailBriefCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.view_accessory];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.view_border];
    }
    return self;
}

- (UIView *)view_accessory
{
    if (!_view_accessory) {
        _view_accessory = [[UIView alloc] initWithFrame:CGRectMake(10, 14, 4, 16)];
        _view_accessory.layer.cornerRadius = 2.f;
        _view_accessory.clipsToBounds = YES;
        _view_accessory.layer.backgroundColor = [__color_main CGColor];
    }
    return _view_accessory;
}

- (UILabel *)label_title
{
    if (!_label_title) {
//        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(22, 12, APPScreenWidth - 22, 20)];
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, APPScreenWidth - 10, 20)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_font_title;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 15;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, APPScreenWidth - 15, 20)];
        _label_subtitle.font = __font(16);
        _label_subtitle.textAlignment = NSTextAlignmentRight;
        _label_subtitle.textColor = __color_font_placeholder;
    }
    return _label_subtitle;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 43.5, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (void)bindDict:(NSDictionary *)dic
{
    self.label_title.text = [dic stringForKey:@"title"];
    self.label_subtitle.text = [dic stringForKey:@"content"];
}


@end
