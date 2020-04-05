//
//  WeeklyScheduleViewController.h
//  edum
//
//  Created by Kevin Chan on 3/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "LunarFormatter.h"
#import "HMSegmentedControl.h"
#import <FSCalendar.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeeklyScheduleViewController : BaseTabbarViewController

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (nonatomic, strong) NSMutableArray *array_data;

@end

NS_ASSUME_NONNULL_END
