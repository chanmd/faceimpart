//
//  SightBriefCell.m
//  gwlx
//
//  Created by Chan Kevin on 27/9/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "SightBriefCell.h"

@implementation SightBriefCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.button];
//        [self.contentView addSubview:self.view_border];
    }
    return self;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label.font = __font(16);
        _label.textColor = __color_font_title;
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, APPScreenWidth, 18)];
//        _button.layer.cornerRadius = 2.f;
//        _button.clipsToBounds = YES;
//        _button.layer.borderWidth = 1.f;
//        _button.layer.borderColor = [__color_main CGColor];
//        _button.layer.backgroundColor = [__color_main CGColor];
        [_button setTitle:@"更多" forState:UIControlStateNormal];
        _button.titleLabel.font = __fontlight(16);
        [_button setTitleColor:__color_main forState:UIControlStateNormal];
    }
    return _button;
}


- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 204.5, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}


@end
