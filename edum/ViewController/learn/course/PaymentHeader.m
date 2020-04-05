//
//  PaymentHeader.m
//  edum
//
//  Created by Kevin Chan on 28/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "PaymentHeader.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "NSDictionary+JSONExtern.h"

@implementation PaymentHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label_title];
        [self addSubview:self.label_subtitle];
        [self addSubview:self.label_price_title];
        [self addSubview:self.label_price];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(24, 20, APPScreenWidth - 40, 20)];
        _label_title.font = __font(20);
        _label_title.textColor = __color_font_title;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 50;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(25, self.label_title.bottom + 20, APPScreenWidth - 50, 20)];
        _label_subtitle.preferredMaxLayoutWidth = APPScreenWidth - 40;
        _label_subtitle.font = __font(16);
        _label_subtitle.numberOfLines = 0;
        _label_subtitle.lineBreakMode = NSLineBreakByWordWrapping;
        _label_subtitle.textColor = __color_font_title;
    }
    return _label_subtitle;
}

- (UILabel *)label_price_title
{
    if (!_label_price_title) {
        _label_price_title = [[UILabel alloc] initWithFrame:CGRectMake(24, self.label_subtitle.bottom + 20, 120, 20)];
        _label_price_title.font = __font(18);
        _label_price_title.textColor = __color_font_title;
        _label_price_title.text = @"课程总价";
    }
    return _label_price_title;
}

- (UILabel *)label_price
{
    if (!_label_price) {
        _label_price = [[UILabel alloc] initWithFrame:CGRectMake(APPScreenWidth - 200 - 30, self.label_subtitle.bottom + 25, APPScreenWidth - 200, 20)];
        _label_price.preferredMaxLayoutWidth = APPScreenWidth - 40;
        _label_price.font = __fontthin(20);
        _label_price.textAlignment = NSTextAlignmentRight;
        _label_price.textColor = __color_font_subtitle;
    }
    return _label_price;
}

- (void)bindPaymentHeader:(NSDictionary *)data
{
    self.label_title.text = [data stringForKey:@"title"];
    self.label_subtitle.text = [data stringForKey:@"subtitle"];
    self.label_price.text = [NSString stringWithFormat:@"¥%@", [data stringForKey:@"price"]];
    
    self.label_title.text = @"钢琴课程一加一";
    self.label_subtitle.text = @"张天一 钢琴老师";
    self.label_price.text = [NSString stringWithFormat:@"¥%@", @"30000"];
}

@end
