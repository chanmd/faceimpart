//
//  CourseSectionHeaderView.m
//  edum
//
//  Created by Kevin Chan on 27/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "CourseSectionHeaderView.h"
#import "UIColor+ColorExtension.h"

@implementation CourseSectionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.button_more];
        self.contentView.backgroundColor = __color_white;
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, APPScreenWidth - 40, 20)];
        _label_title.font = __fontmedium(18);
        _label_title.textColor = __color_font_title;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 40;
    }
    return _label_title;
}

- (UIButton *)button_more
{
    if (!_button_more) {
        _button_more = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_more.frame = CGRectMake(APPScreenWidth - 60 - 10, 17, 60, 20);
        _button_more.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -_button_more.titleLabel.frame.size.width);
        [_button_more setTitle:@"查看全部" forState:UIControlStateNormal];
        _button_more.titleLabel.font = __font(14);
        [_button_more setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        _button_more.hidden = YES;
    }
    return _button_more;
}

@end
