//
//  LandingArticleCell.m
//  edum
//
//  Created by Kevin Chan on 31/1/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "LandingArticleCell.h"

@implementation LandingArticleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
        [self.contentView addSubview:self.imageview_cover];
    }
    return self;
}

- (UIImageView *)imageview_cover
{
    if (!_imageview_cover) {
        _imageview_cover = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 15 - LANDING_ARTICLE_WIDTH, 0, LANDING_ARTICLE_WIDTH, LANDING_ARTICLE_HEIGHT)];
        _imageview_cover.layer.masksToBounds = YES;
        _imageview_cover.layer.cornerRadius = CORNERRADIUS;
    }
    return _imageview_cover;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APPScreenWidth - LANDING_ARTICLE_WIDTH - 45, 22)];
        _label_title.font = __fontlight(18);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, LANDING_ARTICLE_HEIGHT - 16, 100, 20)];
        _label_subtitle.font = __fontlight(14);
        _label_subtitle.textColor = __color_font_subtitle;
    }
    return _label_subtitle;
}

- (void)bindElementWithData:(NSDictionary *)data
{
    [self.imageview_cover sd_setImageWithURL:[NSURL URLWithString:[data stringForKey:@"url"]] placeholderImage:ImageNamed(@"placeholder_half")];
    self.label_title.text = [data stringForKey:@"title"];
    self.label_title.width = APPScreenWidth - LANDING_ARTICLE_WIDTH - 45;
    [self.label_title sizeToFit];
    self.label_subtitle.text = [data stringForKey:@"teacherName"];
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
