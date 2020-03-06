//
//  CategoryView.m
//  gwlx
//
//  Created by Kevin Chan on 8/6/2018.
//  Copyright © 2018 Kevin. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (id)initWithFrame:(CGRect)frame
{
    self.frame = frame;
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageview_cover];
//        [self addSubview:self.view_shadow];
//        [self addSubview:self.label_title];
        [self addSubview:self.button];
    }
    return self;
}

- (UIImageView *)imageview_cover
{
    if (!_imageview_cover) {
        _imageview_cover = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height)];
        _imageview_cover.layer.cornerRadius = CORNERRADIUS;
        _imageview_cover.clipsToBounds = YES;
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
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.imageview_cover.width, 30)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_white;
        _label_title.centerY = self.imageview_cover.height - 20;
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    return _label_title;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:self.imageview_cover.frame];
    }
    return _button;
}

@end
