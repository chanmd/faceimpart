//
//  ExploreCourseCell.m
//  edum
//
//  Created by Md Chen on 6/12/22.
//  Copyright © 2022 MD Chen. All rights reserved.
//

#import "ExploreCourseCell.h"

@implementation ExploreCourseCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_teachername];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 180)];
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 2.f;
        _imageView.backgroundColor = __color_gray_background;
//        [_imageView addSubview:self.label_intensity];
//        [_imageView addSubview:self.label_duration];
    }
    return _imageView;
}

- (UILabel *)label_title {
    if (!_label_title) {
        _label_title = [[UILabel alloc] init];
        _label_title.frame = CGRectMake(1, self.imageView.bottom + 10, 180, 16);
        _label_title.font = __font(16);
        _label_title.textColor = __color_font_title;
        _label_title.textAlignment = NSTextAlignmentLeft;
    }
    return _label_title;
}

- (UILabel *)label_teachername {
    if (!_label_teachername) {
        _label_teachername = [[UILabel alloc] init];
        _label_teachername.frame = CGRectMake(1, self.label_title.bottom + 5, 180, 16);
        _label_teachername.font = __font(14);
        _label_teachername.textColor = __color_font_subtitle;
        _label_teachername.textAlignment = NSTextAlignmentLeft;
    }
    return _label_teachername;
}

- (UILabel *)label_intensity {
    if (!_label_intensity) {
        _label_intensity = [[UILabel alloc] init];
        _label_intensity.frame = CGRectMake(10, self.imageView.bottom - 33, 50, 13);
        _label_intensity.font = __font(12);
        _label_intensity.textColor = __color_white;
        _label_intensity.backgroundColor = [UIColor colorWithHEX:0x000000 Alpha:0.2];
        _label_intensity.clipsToBounds = YES;
        _label_intensity.layer.cornerRadius = 2.f;
        _label_intensity.textAlignment = NSTextAlignmentCenter;
        _label_intensity.numberOfLines = 0;
    }
    return _label_intensity;
}

- (UILabel *)label_duration {
    if (!_label_duration) {
        _label_duration = [[UILabel alloc] init];
        _label_duration.font = __font(12);
        _label_duration.textColor = __color_white;
        _label_duration.backgroundColor = [UIColor colorWithHEX:0x000000 Alpha:0.2];
        _label_duration.clipsToBounds = YES;
        _label_duration.layer.cornerRadius = 2.f;
        _label_duration.textAlignment = NSTextAlignmentCenter;
        _label_duration.numberOfLines = 0;
    }
    return _label_duration;
}

- (UILabel *)label_type {
    if (!_label_type) {
        _label_type = [[UILabel alloc] init];
        _label_type.font = __font(12);
        _label_type.textColor = __color_font_title;
        _label_type.textAlignment = NSTextAlignmentLeft;
    }
    return _label_type;
}

- (void)setDictionaryData:(NSDictionary *)dictionaryData {
    _dictionaryData = dictionaryData;
    NSString *urlString = @"";//[dictionaryData stringForKey:@"cover_image"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil];
    
    self.label_title.text = @"Cello Price Course";
    self.label_teachername.text = @"YoYo Ma";
    
    self.label_intensity.text = @"Easy";
    [self.label_intensity sizeToFit];
    self.label_intensity.width = self.label_intensity.width + 10;
    
    self.label_duration.text = @"30 min";
    [self.label_duration sizeToFit];
    self.label_duration.width = self.label_duration.width + 10;
    
}

@end
