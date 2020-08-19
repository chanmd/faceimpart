//
//  ZhenCell.m
//  edum
//
//  Created by Kevin Chan on 11/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "ZhenCell.h"

@implementation ZhenCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageview_cover];
        [self.contentView addSubview:self.label_title];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (UIImageView *)imageview_cover
{
    if (!_imageview_cover) {
        _imageview_cover = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
    }
    return _imageview_cover;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(59, 15, 200, 20)];
        _label_title.font = __fontthin(18);
        _label_title.textColor = __color_font_subtitle;
        _label_title.textAlignment = NSTextAlignmentLeft;
    }
    return _label_title;
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
