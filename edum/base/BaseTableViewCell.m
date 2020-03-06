//
//  BaseTableViewCell.m
//  gwlx
//
//  Created by Chan Kevin on 11/12/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.contentView.backgroundColor = __color_clear;
//        self.backgroundColor = __color_clear;
//        self.backgroundView = nil;
    }
    return self;
}

@end
