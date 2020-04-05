//
//  PaymentCell.m
//  edum
//
//  Created by Kevin Chan on 31/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "PaymentCell.h"

@implementation PaymentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageview_icon];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.button_select];
    }
    return self;
}

- (UIImageView *)imageview_icon
{
    if (!_imageview_icon) {
        _imageview_icon = [[UIImageView alloc] initWithFrame:CGRectMake(28, 11, 23, 23)];
    }
    return _imageview_icon;
}


- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(63, 10, 80, 25)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_font_title;
    }
    return _label_title;
}

- (UIButton *)button_select
{
    if (!_button_select) {
        _button_select = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_select.frame = CGRectMake(APPScreenWidth - 20 - 30, 12.5, 20, 20);
    }
    return _button_select;
}

- (void)bindPaymentCell:(NSDictionary *)data
{
    self.label_title.text = [data stringForKey:@"title"];
    self.imageview_icon.image = [UIImage imageNamed:[data stringForKey:@"icon"]];
    self.button_select.tag = [[data stringIntForKey:@"tag"] integerValue];
}

- (void)bindPaymentCellButton:(NSInteger)payment
{
    if (payment == 1) {
        [self.button_select setImage:ImageNamed(@"selectbutton") forState:UIControlStateNormal];
        [self.button_select setImage:ImageNamed(@"unselectbutton") forState:UIControlStateHighlighted];
    } else {
        [self.button_select setImage:ImageNamed(@"unselectbutton") forState:UIControlStateNormal];
        [self.button_select setImage:ImageNamed(@"selectbutton") forState:UIControlStateHighlighted];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
