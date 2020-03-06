//
//  CalCell.m
//  edum
//
//  Created by Kevin Chan on 27/5/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "CalCell.h"

#define LABEL_TIME 40
#define LABEL_WIDTH (APPScreenWidth - LABEL_TIME) / 7
#define LABEL_Y 0
#define LABLE_HEIGHT 44

@implementation CalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_time];
        [self.contentView addSubview:self.border_a];
        [self.contentView addSubview:self.border_b];
        [self.contentView addSubview:self.border_c];
        [self.contentView addSubview:self.border_d];
        [self.contentView addSubview:self.border_e];
        [self.contentView addSubview:self.border_f];
        [self.contentView addSubview:self.border_g];
        
        [self.contentView addSubview:self.button_a];
        [self.contentView addSubview:self.button_b];
        [self.contentView addSubview:self.button_c];
        [self.contentView addSubview:self.button_d];
        [self.contentView addSubview:self.button_e];
        [self.contentView addSubview:self.button_f];
        [self.contentView addSubview:self.button_g];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)label_time
{
    if (!_label_time) {
        _label_time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LABEL_TIME, LABLE_HEIGHT)];
        _label_time.font = __font(12);
        _label_time.textColor = __color_font_placeholder;
        _label_time.textAlignment = NSTextAlignmentCenter;
    }
    return _label_time;
}

- (UIButton *)button_a
{
    if (!_button_a) {
        _button_a = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 0 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_a.layer.borderWidth = 0.5;
//        _button_a.clipsToBounds = YES;
//        _button_a.layer.cornerRadius = 3.f;
        _button_a.titleLabel.font = __font(12);
        [_button_a setTitle:@"+" forState:UIControlStateNormal];
        [_button_a setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_a;
}

- (UIButton *)button_b
{
    if (!_button_b) {
        _button_b = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 1 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_b.layer.borderWidth = 0.5;
//        _button_b.clipsToBounds = YES;
//        _button_b.layer.cornerRadius = 3.f;
        _button_b.titleLabel.font = __font(12);
        [_button_b setTitle:@"+" forState:UIControlStateNormal];
        [_button_b setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_b;
}

- (UIButton *)button_c
{
    if (!_button_c) {
        _button_c = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 2 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_c.layer.borderWidth = 0.5;
//        _button_c.clipsToBounds = YES;
//        _button_c.layer.cornerRadius = 3.f;
        _button_c.titleLabel.font = __font(12);
        [_button_c setTitle:@"+" forState:UIControlStateNormal];
        [_button_c setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_c;
}

- (UIButton *)button_d
{
    if (!_button_d) {
        _button_d = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 3 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_d.layer.borderWidth = 0.5;
//        _button_d.clipsToBounds = YES;
//        _button_d.layer.cornerRadius = 3.f;
        _button_d.titleLabel.font = __font(12);
        [_button_d setTitle:@"+" forState:UIControlStateNormal];
        [_button_d setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_d;
}

- (UIButton *)button_e
{
    if (!_button_e) {
        _button_e = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 4 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_e.layer.borderWidth = 0.5;
//        _button_e.clipsToBounds = YES;
//        _button_e.layer.cornerRadius = 3.f;
        _button_e.titleLabel.font = __font(12);
        [_button_e setTitle:@"+" forState:UIControlStateNormal];
        [_button_e setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_e;
}

- (UIButton *)button_f
{
    if (!_button_f) {
        _button_f = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 5 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_f.layer.borderWidth = 0.5;
//        _button_f.clipsToBounds = YES;
//        _button_f.layer.cornerRadius = 3.f;
        _button_f.titleLabel.font = __font(12);
        [_button_f setTitle:@"+" forState:UIControlStateNormal];
        [_button_f setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_f;
}

- (UIButton *)button_g
{
    if (!_button_g) {
        _button_g = [[UIButton alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 6 + 0.5, LABEL_Y, LABEL_WIDTH - 0.5, LABLE_HEIGHT)];
//        _button_g.layer.borderWidth = 0.5;
//        _button_g.clipsToBounds = YES;
//        _button_g.layer.cornerRadius = 3.f;
        _button_g.titleLabel.font = __font(12);
        [_button_g setTitle:@"+" forState:UIControlStateNormal];
        [_button_g setTitleColor:__color_gray_light forState:UIControlStateNormal];
    }
    return _button_g;
}

- (UIView *)border_a
{
    if (!_border_a) {
        _border_a = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 0, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_a.backgroundColor = __color_gray_background;
    }
    return _border_a;
}

- (UIView *)border_b
{
    if (!_border_b) {
        _border_b = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 1, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_b.backgroundColor = __color_gray_background;
    }
    return _border_b;
}

- (UIView *)border_c
{
    if (!_border_c) {
        _border_c = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 2, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_c.backgroundColor = __color_gray_background;
    }
    return _border_c;
}

- (UIView *)border_d
{
    if (!_border_d) {
        _border_d = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 3, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_d.backgroundColor = __color_gray_background;
    }
    return _border_d;
}

- (UIView *)border_e
{
    if (!_border_e) {
        _border_e = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 4, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_e.backgroundColor = __color_gray_background;
    }
    return _border_e;
}

- (UIView *)border_f
{
    if (!_border_f) {
        _border_f = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 5, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_f.backgroundColor = __color_gray_background;
    }
    return _border_f;
}

- (UIView *)border_g
{
    if (!_border_g) {
        _border_g = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 6, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_g.backgroundColor = __color_gray_background;
    }
    return _border_g;
}



@end
