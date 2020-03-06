//
//  GuideGeneralCell.m
//  gwlx
//
//  Created by Kevin Chan on 25/10/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "GuideGeneralCell.h"

@implementation GuideGeneralCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.view_border];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, APPScreenWidth - 30, 18)];
        _label_title.font = __font(14);
        _label_title.textColor = __color_font_title;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 34, APPScreenWidth - 30, 24)];
        _label_subtitle.font = __fontlight(18);
        _label_subtitle.textColor = __color_font_subtitle;
        _label_subtitle.numberOfLines = 0;
    }
    return _label_subtitle;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 69.5, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

@end
