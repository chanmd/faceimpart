//
//  LandingTeacherListCell.m
//  edum
//
//  Created by Kevin Chan on 27/5/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "LandingTeacherListCell.h"

@implementation LandingTeacherListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = __color_white;
        [self.contentView addSubview:self.imageview_avatar];
        [self.contentView addSubview:self.label_name];
        [self.contentView addSubview:self.label_bio];
        [self.contentView addSubview:self.button_follow];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 46, 46)];
        _imageview_avatar.layer.masksToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 23.f;
    }
    return _imageview_avatar;
}

- (UILabel *)label_name
{
    if (!_label_name) {
        _label_name = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, 18, APPScreenWidth - 100, 18)];
        _label_name.font = __fontthin(16);
        _label_name.textColor = __color_font_title;
    }
    return _label_name;
}

- (UILabel *)label_bio
{
    if (!_label_bio) {
        _label_bio = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_avatar.right + 10, self.label_name.bottom + 5, APPScreenWidth - 100, 18)];
        _label_bio.font = __fontthin(14);
        _label_bio.textColor = __color_font_placeholder;
    }
    return _label_bio;
}

- (UIButton *)button_follow
{
    if (!_button_follow) {
        _button_follow = [[UIButton alloc] initWithFrame:CGRectMake(APPScreenWidth - 70 - 15, 25, 70, 26)];
        _button_follow.layer.masksToBounds = YES;
        _button_follow.layer.cornerRadius = 13.f;
        _button_follow.titleLabel.font = __fontthin(14);
        [_button_follow setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        _button_follow.layer.backgroundColor = [__color_gray_background CGColor];
    }
    return _button_follow;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)bindTeacherListWithData:(NSDictionary *)data
{
    NSDictionary *user = [data dictionaryForKey:@"user"];
    self.label_name.text = [user stringForKey:@"name"];
    self.label_bio.text = [user stringForKey:@"bio"];
    [self.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:[user stringForKey:@"avatar"]] placeholderImage:ImageNamed(@"placeholder_half")];
}

- (void)bindTeacherListFollowingStatus:(NSInteger)status
{
    if (status == 1) {
        [self.button_follow setTitle:@"已关注" forState:UIControlStateNormal];
        self.button_follow.layer.backgroundColor = [__color_gray_background CGColor];
        [self.button_follow setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
    } else {
        [self.button_follow setTitle:@"关注" forState:UIControlStateNormal];
        self.button_follow.layer.backgroundColor = [__color_main CGColor];
        [self.button_follow setTitleColor:__color_white forState:UIControlStateNormal];
    }
}

@end
