//
//  SightOrderInputCell.m
//  gwlx
//
//  Created by Kevin Chan on 28/9/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "SightOrderInputCell.h"

@implementation SightOrderInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.contentView.backgroundColor = __color_clear;
        [self.contentView addSubview:self.textfield];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(15, 14, APPScreenWidth - 60, 18)];
        _textfield.font = __font(16);
        _textfield.textColor = __color_font_title;
        _textfield.returnKeyType = UIReturnKeyDone;
    }
    return _textfield;
}

@end
