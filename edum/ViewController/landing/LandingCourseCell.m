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
        [self.contentView addSubview:self.view_container];
        [self.contentView addSubview:self.imageview_avatar];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_name];
        [self.contentView addSubview:self.label_bio];
        [self.contentView addSubview:self.label_price];
        [self.contentView addSubview:self.label_price_fake];
    }
    return self;
}

- (UIView *)view_container
{
    if (!_view_container) {
        _view_container = [[UIView alloc] initWithFrame:CGRectMake(15, 0, APPScreenWidth - 30, LANDING_COURSE_HEIGHT)];
        _view_container.layer.masksToBounds = YES;
        _view_container.layer.cornerRadius = 3.f;
        _view_container.layer.borderColor = [__color_gray_separator CGColor];
        _view_container.layer.borderWidth = 1.f;
    }
    return _view_container;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, LANDING_COURSE_WIDTH - 65, 30)];
        _label_title.font = __font(22);
        _label_title.textColor = __color_font_title;
    }
    return _label_title;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(50, 53, 46, 46)];
        _imageview_avatar.layer.masksToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 23;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, 55, APPScreenWidth - 100, 18)];
        _label_name.font = __font(16);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, self.label_name.bottom + 5, APPScreenWidth - 100, 18)];
        _label_bio.font = __font(14);
        _label_bio.textColor = __color_font_subtitle;
    }
    return _label_bio;
}

- (UILabel *)label_price
{
    if (!_label_price) {
        _label_price = [[UILabel alloc] initWithFrame:CGRectMake(APPScreenWidth - 30 - 120, 39, 120, 30)];
        _label_price.textAlignment = NSTextAlignmentRight;
        _label_price.textColor = __color_main;
        _label_price.font = __font(20);
    }
    return _label_price;
}

- (UILabel *)label_price_fake
{
    if (!_label_price_fake) {
        _label_price_fake = [[UILabel alloc] initWithFrame:CGRectMake(APPScreenWidth - 30 - 120, 68, 120, 20)];
        _label_price_fake.textAlignment = NSTextAlignmentRight;
        _label_price_fake.textColor = __color_font_subtitle;
        _label_price_fake.font = __font(16);
    }
    return _label_price_fake;
}


- (void)bindElementWithData:(NSDictionary *)data
{
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[data stringForKey:@"url"]] placeholderImage:ImageNamed(@"logo_launch")];
    self.label_title.text = [NSString stringWithFormat:@"  %@", [data stringForKey:@"title"]];
    self.label_name.text = [data stringForKey:@"name"];
    self.label_bio.text = [data stringForKey:@"bio"];
    self.label_price.text = [data stringForKey:@"price"];
    self.label_price_fake.text = [data stringForKey:@"price_fake"];
    
    self.label_title.text = @"钢琴课基础指法练习";
    self.label_name.text = @"张天一";
    self.label_bio.text = @"钢琴家 教育家";
    self.label_price.text = @"¥20000";
    self.label_price_fake.text = [data stringForKey:@"price_fake"];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥39999" attributes:attribtDic];
    self.label_price_fake.attributedText = attribtStr;
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
