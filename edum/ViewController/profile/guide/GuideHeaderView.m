//
//  GuideHeaderView.m
//  gwlx
//
//  Created by Kevin Chan on 25/10/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "GuideHeaderView.h"
#import "UIColor+ColorExtension.h"
#import "NSDictionary+JSONExtern.h"
#import "UIView+BFExtension.h"

@implementation GuideHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageview_avatar];
        [self addSubview:self.label_name];
        [self addSubview:self.view_border];
    }
    return self;
}

- (UIImageView *)imageview_feature
{
    if (!_imageview_feature) {
        _imageview_feature = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 39, 15, 24, 24)];
        _imageview_feature.image = ImageNamed(@"medal");
        _imageview_feature.hidden = YES;
    }
    return _imageview_feature;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 20 - 100, 21, 100, 100)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 4.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, APPScreenWidth - 105, 30)];
        _label_name.font = __fontlight(24);
        _label_name.textColor = __color_font_subtitle;
    }
    return _label_name;
}

- (UILabel *)label_category
{
    if (!_label_category) {
        _label_category = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, APPScreenWidth - 105, 20)];
        _label_category.font = __font(16);
        _label_category.textColor = __color_font_subtitle;
    }
    return _label_category;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(10, 139.5, APPScreenWidth - 20, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (void)bindDict:(NSDictionary *)dic
{
    self.label_name.text = [dic stringForKey:@"nickname"];
    self.label_category.text = [NSString stringWithFormat:@"%@ %@", [dic stringForKey:@"province"], [dic stringForKey:@"city"]];
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[dic stringForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"logo_avatar"]];
    
    //    self.view_border.top = self.label_category.bottom + 14 + 68;
}


@end
