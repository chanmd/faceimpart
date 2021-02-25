//
//  TeacherCalendarCell.h
//  edum
//
//  Created by Md Chen on 27/8/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeacherCalendarCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *button_time;

- (void)bindTeacherCalendar:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
