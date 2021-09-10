//
//  CourseRectangleCell.h
//  edum
//
//  Created by Md Chen on 26/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseRectangleCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_photo;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIImageView *imageview_shadow;
@property (nonatomic, strong) UIImageView *imageview_feature;

@property (nonatomic, strong) UIView *view_white;
@property (nonatomic, strong) UILabel *label_rates;
@property (nonatomic, strong) UIButton *button_heart;
@property (nonatomic, strong) UILabel *label_content;
@property (nonatomic, strong) UIButton *button;

- (void)bindData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
