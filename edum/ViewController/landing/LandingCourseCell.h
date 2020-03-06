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

@property (nonatomic, strong) UIImageView *imageview_cover;
@property (nonatomic, strong) UIView *view_shadow;
@property (nonatomic, strong) UILabel *label_title;

- (void)bindElementWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
