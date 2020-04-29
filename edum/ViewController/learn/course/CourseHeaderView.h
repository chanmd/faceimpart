//
//  CourseHeaderView.h
//  edum
//
//  Created by Kevin Chan on 24/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseHeaderView : UIView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_price;
@property (nonatomic, strong) UILabel *label_price_fake;
@property (nonatomic, strong) UILabel *label_appiontment;

@property (nonatomic, strong) UIView *view_contact;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *view_border;

- (void)bindCourseHeader:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
