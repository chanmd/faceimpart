//
//  CourseSectionCell.m
//  edum
//
//  Created by Kevin Chan on 27/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "CourseSectionCell.h"
#import "UILabel+LineSpace.h"

@implementation CourseSectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_title];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, APPScreenWidth - 40, 20)];
        _label_title.font = __fontthin(16);
        _label_title.textColor = __color_font_title;
        _label_title.preferredMaxLayoutWidth = APPScreenWidth - 20;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (void)bindCourseSection:(NSDictionary *)data
{
    self.label_title.width = APPScreenWidth - 40;
    NSString *ori_text = [data stringForKey:@"subtitle"];
    NSString *text = [ori_text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    [self.label_title setText:text lineSpacing:5];
    [self.label_title sizeToFit];
}

- (void)bindCourseSectionBackground:(NSInteger)index
{
    if (index % 2 == 0) {
        self.contentView.backgroundColor = __color_white;
    } else {
        self.contentView.backgroundColor = __color_gray_background;
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
