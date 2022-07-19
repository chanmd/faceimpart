//
//  CategoryHeaderView.m
//  gwlx
//
//  Created by Kevin Chan on 25/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "CategoryHeaderView.h"
#import "UIColor+ColorExtension.h"
#import "UIView+BFExtension.h"

@implementation CategoryHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = __color_white;
        [self addSubview:self.imageview_cover];
        [self addSubview:self.view_shadow];
        [self addSubview:self.label_title];
    }
    return self;
}

- (UIImageView *)imageview_cover
{
    if (!_imageview_cover) {
        _imageview_cover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidth / 2)];
    }
    return _imageview_cover;
}

- (UIView *)view_shadow
{
    if (!_view_shadow) {
        _view_shadow = [[UIView alloc] initWithFrame:self.imageview_cover.frame];
        _view_shadow.layer.cornerRadius = CORNERRADIUS;
        _view_shadow.clipsToBounds = YES;
        _view_shadow.backgroundColor = [UIColor colorWithHEX:0x000000 Alpha:COVER_ALPHA_DARK];
    }
    return _view_shadow;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, APPScreenWidth / 4 - 15, APPScreenWidth, 30)];
        _label_title.font = __fontlight(20);
        _label_title.textColor = __color_white;
        _label_title.textAlignment = NSTextAlignmentCenter;
        _label_title.centerY = self.imageview_cover.centerY;
    }
    return _label_title;
}
- (void)bindData:(NSDictionary *)dic
{
    [self.imageview_cover sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url"]] placeholderImage:ImageNamed(@"city_placeholder")];
    self.label_title.width = APPScreenWidth;
    self.label_title.text = [dic objectForKey:@"name"];
}

@end
