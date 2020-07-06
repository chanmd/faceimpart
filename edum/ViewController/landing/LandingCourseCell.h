//
//  LandingCourseCell.h
//  edum
//
//  Created by Kevin Chan on 31/1/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LandingCourseCell : BaseTableViewCell

@property (nonatomic, strong) UIView *view_container;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;
@property (nonatomic, strong) UILabel *label_price;
@property (nonatomic, strong) UILabel *label_price_fake;

- (void)bindCourseWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
