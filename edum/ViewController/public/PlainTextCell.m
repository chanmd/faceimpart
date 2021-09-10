//
//  PlainTextCell.m
//  edum
//
//  Created by Kevin Chan on 26/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "PlainTextCell.h"

@implementation PlainTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = __color_white;
        [self.contentView addSubview:self.label_text];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)label_text
{
    if (!_label_text) {
        _label_text = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APPScreenWidth - 30, 20)];
        _label_text.font = __font(16);
        _label_text.textColor = __color_font_subtitle;
        _label_text.numberOfLines = 0;
        _label_text.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_text;
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
