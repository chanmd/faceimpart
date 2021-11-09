//
//  AppointmentViewController.m
//  edum
//
//  Created by Kevin Chan on 4/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentCell.h"
#import "NSObject+YYAdditions.h"

#define CALENDAR_HEIGHT 200
#define TITLE_HEIGHT 50
#define CALENDAR_HEIGHT_HALF 90

@interface AppointmentViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>
{
    void * _KVOContext;
}

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约课程";
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.button_commit];
    self.selectedCourse = @"";
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.scope = FSCalendarScopeWeek;
    self.calendar.appearance.weekdayTextColor = __color_font_subtitle;
    self.calendar.appearance.headerTitleColor = __color_main;
    self.calendar.appearance.selectionColor = __color_main;
//    self.calendar = [NSDate dateWithTimeIntervalSinceNow:-(7 * 24 * 60 * 60)];
//    self.calendar.maximumDate = [NSDate dateWithTimeIntervalSinceNow:(7 * 24 * 60 * 60)];
    
    
    self.calendar.appearance.todayColor = __color_main_alpha;
    self.calendar.appearance.titleTodayColor = __color_white;
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    
    // For UITest
    self.calendar.accessibilityIdentifier = @"calendar";
    
    [self simulate_data];
//    self.emptyView.hidden = NO;
    
//    self.tableView.hidden = YES;
//    self.header.hidden = YES;
//    self.calendar.hidden = YES;
    
    [self.tableView reloadData];
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [MobClick endLogPageView:@"mainview"];
}

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, TITLE_HEIGHT + CALENDAR_HEIGHT)];
        [_header addSubview:self.label_title];
        [_header addSubview:self.calendar];
    }
    return _header;
}


- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 80, 15)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_font_title;
        _label_title.text = @"大提琴";
    }
    return _label_title;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy/MM/dd";
    }
    return _dateFormatter;
}

- (UIPanGestureRecognizer *)scopeGesture
{
    if (!_scopeGesture) {
        _scopeGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
        _scopeGesture.delegate = self;
        _scopeGesture.minimumNumberOfTouches = 1;
        _scopeGesture.maximumNumberOfTouches = 2;
    }
    return _scopeGesture;
}

- (FSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, APPScreenWidth, CALENDAR_HEIGHT)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.tintColor = __color_red_main;
        _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
        _calendar.backgroundColor = [UIColor whiteColor];
    }
    return _calendar;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y + TITLE_HEIGHT + CALENDAR_HEIGHT_HALF, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y - TITLE_HEIGHT - CALENDAR_HEIGHT_HALF - SafeAreaBottomHeight - 44 - 10) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundColor = __color_white;
    }
    return _tableView;
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (UIButton *)button_commit
{
    if (!_button_commit) {
        _button_commit = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_commit.frame = CGRectMake(30, APPScreenHeight - 82 - SafeAreaBottomHeight, APPScreenWidth - 54, 44);
        _button_commit.layer.cornerRadius = 22;
        _button_commit.layer.masksToBounds = YES;
        [_button_commit setTitle:@"确定" forState:UIControlStateNormal];
        [_button_commit setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        _button_commit.layer.backgroundColor = [__color_gray_background CGColor];
        [_button_commit addTarget:self action:@selector(action_commit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_commit;
}

- (void)action_commit
{
    if (self.selectedCourse.length == 0) {
        NSLog(@"");
    } else {
        NSLog(@"%@", self.selectedCourse);
    }
    
}

- (void)setbutton_status:(BOOL)status
{
    if (status) {
        [self.button_commit setTitleColor:__color_white forState:UIControlStateNormal];
        self.button_commit.layer.backgroundColor = [__color_main CGColor];
        self.button_commit.userInteractionEnabled = YES;
    } else {
        [self.button_commit setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        self.button_commit.layer.backgroundColor = [__color_gray_background CGColor];
        self.button_commit.userInteractionEnabled = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == _KVOContext) {
        FSCalendarScope oldScope = [change[NSKeyValueChangeOldKey] unsignedIntegerValue];
        FSCalendarScope newScope = [change[NSKeyValueChangeNewKey] unsignedIntegerValue];
        NSLog(@"From %@ to %@",(oldScope==FSCalendarScopeWeek?@"week":@"month"),(newScope==FSCalendarScopeWeek?@"week":@"month"));
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

// Whether scope gesture should begin
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top;
    if (shouldBegin) {
        CGPoint velocity = [self.scopeGesture velocityInView:self.view];
        switch (self.calendar.scope) {
            case FSCalendarScopeMonth:
                return velocity.y < 0;
            case FSCalendarScopeWeek:
                return velocity.y > 0;
        }
    }
    return shouldBegin;
}

#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
}

#pragma mark calendar appearance

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date
{
    if ([[self.dateFormatter stringFromDate:date] isEqualToString:[self.dateFormatter stringFromDate:[NSDate date]]]) {
        return __color_white;
    }
    return __color_font_title;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date
{
    return __color_white;
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40 + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"date_cell";
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[AppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *appintment = [self.array_data objectAtIndex:indexPath.row];
    
    [cell bindAppointment:appintment];
    if ([[appintment stringForKey:@"id"] isEqualToString:self.selectedCourse]) {
        [cell.button_date setTitleColor:__color_main forState:UIControlStateNormal];
        cell.button_date.layer.borderColor = [__color_main CGColor];
        cell.button_date.layer.backgroundColor = [__color_white CGColor];
        cell.button_date.userInteractionEnabled = YES;
    } else {
        [cell bindAppointmentButton:[[appintment stringIntForKey:@"status"] integerValue] ];
    }
    [cell.button_date addTarget:self action:@selector(button_action:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)button_action:(UIButton *)button
{
    NSString *courseid = (NSString *)DYY_getYYUserInfo(button);
    if (courseid) {
        self.selectedCourse = courseid;
    }
    [self setbutton_status:YES];
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 20)];
}

- (void)fetch_data
{
    
//    WeakSelf;
//    [AFR requestWithUrl:REQUEST_LANDING_LIST
//             httpmethod:@"POST"
//                 params:[NSMutableDictionary dictionary]
//          finishedBlock:^(id responseObject){
//        NSLog(@"");
//        NSDictionary *tempDic = (NSDictionary *)responseObject;
//        [tempDic dictionaryForKey:@"data"];
//        [weakSelf.tableview_right.mj_header endRefreshing];
//        if ([[tempDic objectForKey:@"code"] integerValue] == 0) {
//
//            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
//            [weakSelf.bannerview bindData:data];
//            weakSelf.tableview_right.tableHeaderView = nil;
//            weakSelf.tableview_right.tableHeaderView = weakSelf.bannerview;
//            weakSelf.array_filter = [data arrayForKey:@"titles"];
//            weakSelf.array_data_right = [data arrayForKey:@"contents"];
//            [weakSelf.tableview_right reloadData];
//        }
//        [weakSelf.tableview_right reloadData];
//    }
//            failedBlock:^(NSError *errorInfo){
//        NSLog(@"");
//        [weakSelf.tableview_right.mj_header endRefreshing];
//        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
//    }];
    
}

- (void)simulate_data
{
    NSArray * array  = @[
            @{
                @"id": @"13",
                @"title": @"大提琴基础练习大提琴基础练习",
                @"time": @"10:00 - 11:00",
                @"status": @"1",
              },
            @{
              @"id": @"14",
              @"title": @"大提琴基础练习大提琴基础练习",
              @"time": @"12:00 - 13:00",
              @"status": @"1",
            },
            @{
              @"id": @"15",
              @"title": @"大提琴基础练习大提琴基础练习",
              @"time": @"15:00 - 16:00",
              @"status": @"2",
            },
    ];
    
    self.array_data = [[NSMutableArray alloc] initWithArray:array];
}

@end
