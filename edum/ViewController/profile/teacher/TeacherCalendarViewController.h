//
//  TeacherCalendarViewController.h
//  edum
//
//  Created by Md Chen on 26/8/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseViewController.h"
#import "LunarFormatter.h"
#import <FSCalendar.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherCalendarViewController : BaseViewController

@property (nonatomic, strong) NSString *teacher_id;
@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIPanGestureRecognizer *scopeGesture;
@property (nonatomic, strong) NSMutableDictionary *dictionary_data;
@property (nonatomic, strong) NSString *current_date;

@end

NS_ASSUME_NONNULL_END
