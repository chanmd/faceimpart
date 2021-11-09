//
//  CourseSectionTopHeader.m
//  edum
//
//  Created by Kevin Chan on 28/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "CourseSectionTopHeader.h"
#import "UIColor+ColorExtension.h"

@implementation CourseSectionTopHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
        _view_shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 50, APPScreenWidth, 44)];
        _view_shadow.backgroundColor = __color_gray_background;
    }
    return _view_shadow;
}


- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_font_subtitle;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 30;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 50 + 12, APPScreenWidth - 40, 20)];
        _label_subtitle.preferredMaxLayoutWidth = APPScreenWidth - 40;
        _label_subtitle.font = __font(18);
        _label_subtitle.numberOfLines = 0;
        _label_subtitle.lineBreakMode = NSLineBreakByWordWrapping;
        _label_subtitle.textColor = __color_font_title;
    }
    return _label_subtitle;
}

- (void)bindCourseContent:(NSDictionary *)data
{
    
}


@end
