//
//  LandingTeacherCell.m
//  edum
//
//  Created by Kevin Chan on 30/1/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "LandingTeacherCell.h"

@implementation LandingTeacherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageview_left];
        [self.contentView addSubview:self.button_left];
        [self.contentView addSubview:self.imageview_right];
        [self.contentView addSubview:self.button_right];
    }
    return self;
}

- (UIImageView *)imageview_left
{
    if (!_imageview_left) {
        _imageview_left = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, LANDING_TEACHER_WIDTH, LANDING_TEACHER_HEIGHT)];
        _imageview_left.layer.cornerRadius = CORNERRADIUS;
        _imageview_left.clipsToBounds = YES;
    }
    return _imageview_left;
}

- (UIImageView *)imageview_right
{
    if (!_imageview_right) {
        _imageview_right = [[UIImageView alloc] initWithFrame:CGRectMake(LANDING_TEACHER_WIDTH + 30, 0, LANDING_TEACHER_WIDTH, LANDING_TEACHER_HEIGHT)];
        _imageview_right.layer.cornerRadius = CORNERRADIUS;
        _imageview_right.clipsToBounds = YES;
    }
    return _imageview_right;
}

- (UIButton *)button_left
{
    if (!_button_left) {
        _button_left = [[UIButton alloc] initWithFrame:self.imageview_left.frame];
    }
    return _button_left;
}

- (UIButton *)button_right
{
    if (!_button_right) {
        _button_right = [[UIButton alloc] initWithFrame:self.imageview_right.frame];
    }
    return _button_right;
}

- (void)bindTeacherWithData:(NSArray *)data
{
    if (data && [data count] >= 2) {
        NSDictionary *left = [data objectAtIndex:0];
        NSDictionary *right = [data objectAtIndex:1];
        [self.imageview_left sd_setImageWithURL:[NSURL URLWithString:[left stringForKey:@"cover_avatar"]] placeholderImage:ImageNamed(@"placeholder_half")];
        
        if ([[right allKeys] count] > 0) {
            self.imageview_right.hidden = NO;
            self.button_right.hidden = NO;
            [self.imageview_right sd_setImageWithURL:[NSURL URLWithString:[right stringForKey:@"cover_avatar"]] placeholderImage:ImageNamed(@"placeholder_half")];
        } else {
            self.imageview_right.hidden = YES;
            self.button_right.hidden = YES;
        }
        
    } else {
        
        self.imageview_left.hidden = YES;
        self.button_left.hidden = YES;
        self.imageview_right.hidden = YES;
        self.button_right.hidden = YES;
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
