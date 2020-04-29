//
//  AppointmentViewController.h
//  edum
//
//  Created by Kevin Chan on 4/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseViewController.h"
#import <FSCalendar.h>
#import "LunarFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentViewController : BaseViewController

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;
@property (nonatomic, strong) NSMutableArray *array_data;

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) NSString *selectedCourse;

@property (nonatomic, strong) UIButton *button_commit;

@end

NS_ASSUME_NONNULL_END
