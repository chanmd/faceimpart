//
//  SightCubeView.m
//  gwlx
//
//  Created by Kevin Chan on 11/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "SightCubeView.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ColorExtension.h"
#import "UIView+BFExtension.h"
#import "UIlabel+LineSpace.h"
#import "NSDictionary+JSONExtern.h"

@implementation SightCubeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = __color_gray_background;
        self.backgroundColor = __color_white;
        [self addSubview:self.imageview_photo];
//        [self addSubview:self.imageview_feature];
//        [self addSubview:self.imageview_shadow];
        [self addSubview:self.view_white];
        [self addSubview:self.button];
    }
    return self;
}

- (UIImageView *)imageview_photo
{
    if (!_imageview_photo) {
        _imageview_photo = [[UIImageView alloc] initWithFrame:CGRectMake(GENERAL_PADDING, 0, LANDING_SIGHT_WIDTH, LANDING_SIGHT_HEIGHT)];
        _imageview_photo.clipsToBounds = YES;
        _imageview_photo.layer.cornerRadius = CORNERRADIUS;
        _imageview_photo.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageview_photo;
}

- (UIImageView *)imageview_feature
{
    if (!_imageview_feature) {
        _imageview_feature = [[UIImageView alloc] initWithFrame:CGRectMake(LANDING_SIGHT_WIDTH - 60, 10, 60, 27)];
        _imageview_feature.image = ImageNamed(@"boat_wheat");
        _imageview_feature.hidden = YES;
    }
    return _imageview_feature;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.frame = CGRectMake(0, 0, LANDING_SIGHT_WIDTH, LANDING_SIGHT_HEIGHT + 70);
    }
    return _button;
}

- (UIImageView *)imageview_shadow
{
    if (!_imageview_shadow) {
        _imageview_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(GENERAL_PADDING, GENERAL_PADDING, LANDING_SIGHT_WIDTH, LANDING_SIGHT_HEIGHT)];
        _imageview_shadow.image = ImageNamed(@"sight_shadow");
    }
    return _imageview_shadow;
}

- (UIView *)view_white
{
    if (!_view_white) {
        _view_white = [[UIView alloc] initWithFrame:CGRectMake(LABEL_PADDING, LANDING_SIGHT_HEIGHT, LANDING_SIGHT_WIDTH, 60)];
        _view_white.backgroundColor = __color_white;
        [_view_white addSubview:self.label_title];
        [_view_white addSubview:self.label_subtitle];
//        [_view_white addSubview:self.label_rates];
//        [_view_white addSubview:self.button_heart];
    }
    return _view_white;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, LABEL_PADDING, LANDING_SIGHT_WIDTH, 20)];
        _label_title.font = __font(14);
        _label_title.textColor = __color_font_title;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, LANDING_SIGHT_WIDTH, 18)];
        _label_subtitle.font = __font(12);
        _label_subtitle.textColor = __color_font_subtitle;
    }
    return _label_subtitle;
}

- (UILabel *)label_content
{
    if (!_label_content) {
        _label_content = [[UILabel alloc] initWithFrame:CGRectMake(0, LABEL_PADDING + 42, LANDING_SIGHT_WIDTH, 20)];
        _label_content.numberOfLines = 0;
        _label_content.textColor = __color_font_placeholder;
        _label_content.font = __fontlight(14);
    }
    return _label_content;
}

- (UILabel *)label_rates
{
    if (!_label_rates) {
        _label_rates = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 80, 15)];
        _label_rates.font = __font(14);
        _label_rates.textColor = __color_red_main;
    }
    return _label_rates;
}

- (UIButton *)button_heart
{
    if (!_button_heart) {
        _button_heart = [[UIButton alloc] initWithFrame:CGRectMake(LANDING_SIGHT_WIDTH - LABEL_PADDING - 18 - 5, 17, 18, 18)];
        [_button_heart setImage:ImageNamed(@"icon_heart_n") forState:UIControlStateNormal];
        [_button_heart setImage:ImageNamed(@"icon_heart_h") forState:UIControlStateHighlighted];
    }
    return _button_heart;
}

- (void)bindData:(NSDictionary *)dic
{
//    [self.imageview_photo sd_setImageWithURL:[NSURL URLWithString:[dic stringForKey:@"url"]] placeholderImage:ImageNamed(@"city_placeholder") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
//        if (image && cacheType != SDImageCacheTypeDisk) {
//            self.imageview_photo.alpha = 0.0;
//            [UIView animateWithDuration:0.618
//                             animations:^{
//                                 self.imageview_photo.alpha = 1.0;
//                             }];
//        }
//    }];
    [self.imageview_photo sd_setImageWithURL:[NSURL URLWithString:[dic stringForKey:@"cover_image"]] placeholderImage:ImageNamed(@"city_placeholder") completed:nil];
    
//    if ([[dic stringForKey:@"feature"] isEqualToString:@"1"]) {
//        self.imageview_feature.hidden = NO;
//    } else {
//        self.imageview_feature.hidden = YES;
//    }
    
    self.label_title.text = [dic stringForKey:@"title"];
    [self.label_title sizeToFit];
    self.label_subtitle.text = [dic stringForKey:@"desc"];
    NSInteger rate = [[dic stringIntForKey:@"rate"] integerValue];
    self.label_rates.text = [self star_rate:rate];
}

- (NSString *)star_rate:(NSInteger)rate
{
    switch (rate) {
        case 1:
            return @"★";
            break;
        case 2:
            return @"★★";
            break;
        case 3:
            return @"★★★";
            break;
        case 4:
            return @"★★★★";
            break;
        case 5:
            return @"★★★★★";
            break;
        default:
            return @"★★★★";
            break;
    }
}

@end
