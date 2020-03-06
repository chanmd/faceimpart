//
//  CoursesCell.m
//  edum
//
//  Created by Kevin Chan on 23/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CoursesCell.h"

#define CELL_PADDING 10

@implementation CoursesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageview_cover];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.label_add];
    }
    return self;
}

- (UIImageView *)imageview_cover
{
    if (!_imageview_cover) {
        _imageview_cover = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth - 20, (APPScreenWidth - 20) / 3 + 10)];
        _imageview_cover.clipsToBounds = YES;
        _imageview_cover.layer.cornerRadius = CORNERRADIUS;
    }
    return _imageview_cover;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, APPScreenWidth - 30, 26)];
        _label_title.font = __fontbold(24);
        _label_title.textColor = __color_white;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, APPScreenWidth - 30, 20)];
        _label_subtitle.font = __font(16);
        _label_subtitle.textColor = __color_white;
    }
    return _label_subtitle;
}

- (UILabel *)label_add
{
    if (!_label_add) {
        _label_add = [[UILabel alloc] initWithFrame:CGRectMake(APPScreenWidth - 40 - 20, 38, 40, 60)];
        _label_add.font = __font(48);
        _label_add.textAlignment = NSTextAlignmentLeft;
        _label_add.textColor = __color_white;
        _label_add.text = @"+";
    }
    return _label_add;
}

- (void)bindDict:(NSDictionary *)dic
{
    NSString *url = [dic stringForKey:@"url"];
    if (url.length > 0) {
//        [self.imageview_cover sd_setImageWithURL:[NSURL URLWithString:url]];
        self.imageview_cover.image = ImageNamed(url);
    }
    self.label_add.centerY = self.imageview_cover.centerY;
//    self.label_subtitle.top = self.imageview_cover.centerY;
    self.label_title.text = [dic stringForKey:@"title"];
    self.label_subtitle.text = [dic stringForKey:@"subtitle"];
}

@end
