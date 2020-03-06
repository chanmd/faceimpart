//
//  CourseTitleCell.m
//  edum
//
//  Created by Kevin Chan on 13/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseTitleCell.h"
#import "UILabel+LineSpace.h"

@implementation CourseTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, APPScreenWidth - 30, 30)];
        _label_title.font = __fontbold(22);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, APPScreenWidth - 30, 20)];
        _label_subtitle.font = __font(16);
        _label_subtitle.textColor = __color_font_title;
        _label_subtitle.numberOfLines = 0;
        _label_subtitle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_subtitle;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, APPScreenWidth, 18)];
        [_button setTitle:@"查看更多" forState:UIControlStateNormal];
        _button.titleLabel.font = __fontlight(16);
        [_button setTitleColor:__color_main forState:UIControlStateNormal];
    }
    return _button;
}

- (void)bindDict:(NSDictionary *)dic
{
    self.label_title.text = [dic stringForKey:@"title"];
    self.label_title.width = APPScreenWidth - 30;
    [self.label_title sizeToFit];
    
    self.label_subtitle.width = APPScreenWidth - 30;
    NSString *cutString = @"";
    if ([dic stringForKey:@"subtitle"].length > 100) {
        cutString = [NSString stringWithFormat:@"%@...", [[dic stringForKey:@"subtitle"] substringToIndex:100]];
    }
    [self.label_subtitle setText:cutString lineSpacing:SIGHT_DETAIL_LINESPACE];
    [self.label_subtitle sizeToFit];
    
    self.label_subtitle.top = self.label_title.bottom + 10;
    [self.label_subtitle sizeToFit];
    self.button.top = self.label_subtitle.bottom + 20;
}

@end
