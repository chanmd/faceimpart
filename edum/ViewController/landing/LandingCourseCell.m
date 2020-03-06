//
//  LandingCourseCell.m
//  edum
//
//  Created by Kevin Chan on 31/1/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "LandingCourseCell.h"

@implementation LandingCourseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageview_cover];
//        [self.contentView addSubview:self.view_shadow];
        [self.contentView addSubview:self.label_title];
    }
    return self;
}

- (UIImageView *)imageview_cover
{
    if (!_imageview_cover) {
        _imageview_cover = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, LANDING_COURSE_WIDTH, LANDING_COURSE_HEIGHT)];
        _imageview_cover.layer.masksToBounds = YES;
        _imageview_cover.layer.cornerRadius = CORNERRADIUS;
    }
    return _imageview_cover;
}

- (UIView *)view_shadow
{
    if (!_view_shadow) {
        _view_shadow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _view_shadow.layer.cornerRadius = CORNERRADIUS;
        _view_shadow.clipsToBounds = YES;
        _view_shadow.backgroundColor = [UIColor colorWithHEX:0x000000 Alpha:COVER_ALPHA_DARK];
    }
    return _view_shadow;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(30, LANDING_COURSE_HEIGHT - 40, LANDING_COURSE_WIDTH - 30, 30)];
        _label_title.font = __fontlight(20);
        _label_title.textColor = __color_white;
        _label_title.textAlignment = NSTextAlignmentLeft;
        _label_title.layer.masksToBounds = YES;
        _label_title.layer.cornerRadius = 15.f;
        _label_title.layer.backgroundColor = [[UIColor colorWithHEX:0x666666 Alpha:0.4f] CGColor];
    }
    return _label_title;
}

- (void)bindElementWithData:(NSDictionary *)data
{
    [self.imageview_cover sd_setImageWithURL:[NSURL URLWithString:[data stringForKey:@"url"]] placeholderImage:ImageNamed(@"placeholder_half")];
    self.label_title.text = [NSString stringWithFormat:@"  %@", [data stringForKey:@"name"]];
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
