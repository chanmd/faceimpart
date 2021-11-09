//
//  AppointmentCell.m
//  edum
//
//  Created by Kevin Chan on 9/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "AppointmentCell.h"
#import "NSObject+YYAdditions.h"

@implementation AppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.button_date];
    }
    return self;
}

- (UIButton *)button_date
{
    if (!_button_date) {
        _button_date = [[UIButton alloc] initWithFrame:CGRectMake(15, 19, APPScreenWidth  - 30, 40)];
        [_button_date setTitleColor:__color_font_subtitle forState:UIControlStateNormal];
        _button_date.layer.masksToBounds = YES;
        _button_date.layer.borderColor = [__color_font_subtitle CGColor];
        _button_date.layer.borderWidth = 1.f;
        _button_date.layer.cornerRadius = 3.f;
    }
    return _button_date;
}

- (void)bindAppointment:(NSDictionary *)data
{
    [self.button_date setTitle:[data stringForKey:@"time"] forState:UIControlStateNormal];
    DYY_setYYUserInfo(self.button_date, [data stringForKey:@"id"]);
    
}

- (void)bindAppointmentButton:(NSInteger)status
{
    if (status == 1) {
        [self.button_date setTitleColor:__color_font_subtitle forState:UIControlStateNormal];
        self.button_date.layer.borderColor = [__color_font_subtitle CGColor];
        self.button_date.layer.backgroundColor = [__color_white CGColor];
        self.button_date.userInteractionEnabled = YES;
    } else if (status == 2) {
        [self.button_date setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        self.button_date.layer.borderColor = [__color_gray_separator CGColor];
        self.button_date.layer.backgroundColor = [__color_gray_separator CGColor];
        self.button_date.userInteractionEnabled = NO;
    } else if (status == 3) {
        [self.button_date setTitleColor:__color_main forState:UIControlStateNormal];
        self.button_date.layer.borderColor = [__color_main CGColor];
        self.button_date.layer.backgroundColor = [__color_white CGColor];
        self.button_date.userInteractionEnabled = YES;
    } else {
        self.button_date.userInteractionEnabled = YES;
        [self.button_date setTitleColor:__color_gray_separator forState:UIControlStateNormal];
        self.button_date.layer.borderColor = [__color_gray_background CGColor];
        self.button_date.layer.backgroundColor = [__color_gray_background CGColor];
    }
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
