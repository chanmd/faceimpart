//
//  CourseVideoCell.m
//  edum
//
//  Created by Md Chen on 30/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "CourseVideoCell.h"

@implementation CourseVideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = __color_white;
        [self.contentView addSubview:self.imageview_photo];
        [self.contentView addSubview:self.imageview_video];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_subtitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)imageview_photo
{
    if (!_imageview_photo) {
        _imageview_photo = [[UIImageView alloc] initWithFrame:CGRectMake(GENERAL_PADDING, GENERAL_PADDING, COURSE_VIDEO_WIDTH, COURSE_VIDEO_HEIGHT)];
        _imageview_photo.clipsToBounds = YES;
        _imageview_photo.layer.cornerRadius = CORNERRADIUS;
        _imageview_photo.contentMode = UIViewContentModeScaleAspectFill;
        _imageview_photo.image = ImageNamed(@"course_video_demo");
    }
    return _imageview_photo;
}

- (UIImageView *)imageview_video
{
    if (!_imageview_video) {
        _imageview_video = [[UIImageView alloc] initWithFrame:CGRectMake(GENERAL_PADDING, GENERAL_PADDING, 30, 30)];
        _imageview_video.clipsToBounds = YES;
        _imageview_video.image = ImageNamed(@"video_play");
        _imageview_video.left = 35;
        _imageview_video.top = 25;
    }
    return _imageview_video;
}



- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_photo.right + 10, LABEL_PADDING, 200, 20)];
        _label_title.font = __font(14);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
        _label_title.text = @"一弓一拍";
    }
    return _label_title;
}

- (UILabel *)label_subtitle
{
    if (!_label_subtitle) {
        _label_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imageview_photo.right + 10, self.label_title.bottom + 2, 200, 16)];
        _label_subtitle.font = __font(12);
        _label_subtitle.textColor = __color_font_subtitle;
        _label_subtitle.numberOfLines = 0;
        _label_subtitle.text = @"时长 01:20";
        
    }
    return _label_subtitle;
}



- (void)bindData:(NSDictionary *)dic
{
//    [self.imageview_photo sd_setImageWithURL:[NSURL URLWithString:[dic stringForKey:@"url"]] placeholderImage:ImageNamed(@"city_placeholder") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
//        if (image && cacheType != SDImageCacheTypeDisk) {
//            self.imageview_photo.alpha = 0.0;
//            [UIView animateWithDuration:0.618
//                             animations:^{
//                                 self.imageview_photo.alpha = 1.0;
//                             }];
//        }
//    }];
    [self.imageview_photo sd_setImageWithURL:[NSURL URLWithString:[dic stringForKey:@"cover_image"]] placeholderImage:ImageNamed(@"city_placeholder") completed:nil];
    
    self.label_title.text = [dic stringForKey:@"title"];
}

@end
