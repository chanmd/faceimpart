//
//  GeneralHeaderView.m
//  edum
//
//  Created by Kevin Chan on 26/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "GeneralHeaderView.h"
#import "UIColor+ColorExtension.h"

@implementation GeneralHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.view_accessory];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.image_accessory];
        self.contentView.backgroundColor = __color_white;
    }
    return self;
}

- (UIView *)view_accessory
{
    if (!_view_accessory) {
        _view_accessory = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 6, 20)];
        _view_accessory.layer.masksToBounds = YES;
        _view_accessory.layer.cornerRadius = 1.f;
        _view_accessory.layer.backgroundColor = [__color_main CGColor];
    }
    return _view_accessory;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(27, 20, APPScreenWidth, 20)];
        _label.font = __fontbold(20);
        _label.textColor = __color_font_title;
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, self.label.frame.origin.y, APPScreenWidth, self.label.frame.size.height);
    }
    return _button;
}

- (UIImageView *)image_accessory
{
    if (!_image_accessory) {
        _image_accessory = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 20 - 10, 10, 20, 20)];
        _image_accessory.image = ImageNamed(@"header_accessory");
    }
    return _image_accessory;
}


@end
