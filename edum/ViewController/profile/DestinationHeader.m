//
//  DestinationHeader.m
//  gwlx
//
//  Created by Kevin Chan on 22/2/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "DestinationHeader.h"
#import "UIColor+ColorExtension.h"

@implementation DestinationHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xf1f1f1 Alpha:0.9];
        [self addSubview:self.label_title];
//        [self addSubview:self.view_separator];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APPScreenWidth - 30, 20)];
        _label_title.font = __fontmedium(18);
        _label_title.textColor = __color_font_subtitle;
    }
    return _label_title;
}

- (UIView *)view_separator
{
    if (!_view_separator) {
        _view_separator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.5)];
        _view_separator.backgroundColor = __color_gray_separator;
    }
    return _view_separator;
}

@end
