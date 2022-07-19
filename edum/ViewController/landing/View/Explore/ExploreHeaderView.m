//
//  ExploreHeaderView.m
//  edum
//
//  Created by Md Chen on 6/3/22.
//  Copyright © 2022 MD Chen. All rights reserved.
//

#import "ExploreHeaderView.h"
#import "UIColor+ColorExtension.h"
#define PADDING_LEFT 20
#define PADDING_TOP 20

@implementation ExploreHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = __color_white;
        [self.contentView addSubview:self.title_label];
//        [self.contentView addSubview:self.imageview_accessory];
    }
    return self;
}

- (UILabel *)title_label
{
    if (!_title_label) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(PADDING_LEFT, PADDING_TOP, APPScreenWidth - PADDING_LEFT * 2, 20)];
        _title_label.font = __fontmedium(18);
        _title_label.textColor = __color_font_title;
        _title_label.textAlignment = NSTextAlignmentLeft;
    }
    return _title_label;
}

- (UIImageView *)imageview_accessory
{
    if (!_imageview_accessory) {
        _imageview_accessory = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 20 - PADDING_LEFT, PADDING_TOP, 20, 20)];
        _imageview_accessory.image = ImageNamed(@"header_accessory");
    }
    return _imageview_accessory;
}

@end
