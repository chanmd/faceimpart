//
//  CourseSectionCell.h
//  edum
//
//  Created by Kevin Chan on 27/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseSectionCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;

- (void)bindCourseSection:(NSDictionary *)data;
- (void)bindCourseSectionBackground:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
