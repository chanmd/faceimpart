//
//  CourseHeadBox.m
//  edum
//
//  Created by Md Chen on 29/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "CourseHeadBox.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "NSDictionary+JSONExtern.h"

@implementation CourseHeadBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CORNERRADIUS;
        self.layer.backgroundColor = [__color_gray_background CGColor];
        [self addSubview:self.icon];
        [self addSubview:self.label_name];
        [self addSubview:self.label_bio];
    }
    return self;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 16, 16)];
    }
    return _icon;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.icon.right + 3, 13, self.width - 20 - 18, 18)];
        _label_name.font = __font(14);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(16, self.label_name.bottom + 8, self.width - 20, 18)];
        _label_bio.font = __font(12);
        _label_bio.textColor = __color_font_placeholder;
        _label_bio.numberOfLines = 0;
    }
    return _label_bio;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
