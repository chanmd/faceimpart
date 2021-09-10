//
//  SettingCell.m
//  edum
//
//  Created by Kevin Chan on 11/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_title];
//        [self.contentView addSubview:self.label_left];
//        [self.contentView addSubview:self.label_right];
        [self.contentView addSubview:self.view_line];
//        [self.contentView addSubview:self.imageview_bank];
//        [self.contentView addSubview:self.label_middle];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, 200, 26)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_font_title;
        _label_title.textAlignment = NSTextAlignmentLeft;
    }
    return _label_title;
}



- (UIView *)view_line
{
    if (!_view_line) {
        _view_line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, APPScreenWidth, 0.5)];
        _view_line.backgroundColor = __color_gray_background;
        _view_line.hidden = YES;
    }
    return _view_line;
}

- (UILabel *)label_left
{
    if (!_label_left) {
        _label_left = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        _label_left.font = __font(16);
        _label_left.textColor = __color_font_title;
        _label_left.textAlignment = NSTextAlignmentLeft;
    }
    return _label_left;
}

- (UILabel *)label_right
{
    if (!_label_right) {
        _label_right = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, APPScreenWidth - 30, 20)];
        _label_right.font = __font(16);
        _label_right.textColor = __color_font_placeholder;
        _label_right.textAlignment = NSTextAlignmentRight;
        _label_right.numberOfLines = 0;
    }
    return _label_right;
}

- (UILabel *)label_middle
{
    if (!_label_middle) {
        _label_middle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APPScreenWidth - 30, 20)];
        _label_middle.font = __font(16);
        _label_middle.textColor = __color_font_placeholder;
        _label_middle.textAlignment = NSTextAlignmentRight;
    }
    return _label_middle;
}

- (UIImageView *)imageview_bank
{
    if (!_imageview_bank) {
        _imageview_bank = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 180, 11, 18, 18)];
        _imageview_bank.image = ImageNamed(@"t_citi");
        _imageview_bank.hidden = YES;
    }
    return _imageview_bank;
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
