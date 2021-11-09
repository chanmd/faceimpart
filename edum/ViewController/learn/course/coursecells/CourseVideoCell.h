//
//  CourseVideoCell.h
//  edum
//
//  Created by Md Chen on 30/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseVideoCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_video;
@property (nonatomic, strong) UIImageView *imageview_photo;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;

- (void)bindVideoData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
