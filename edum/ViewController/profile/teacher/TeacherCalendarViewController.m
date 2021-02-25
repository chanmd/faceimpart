//
//  TeacherCalendarViewController.m
//  edum
//
//  Created by Md Chen on 26/8/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "TeacherCalendarViewController.h"
#import "TeacherCalendarCell.h"

@interface TeacherCalendarViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>
{
    void * _KVOContext;
}

@property (nonatomic, strong) UIView *view_empty_data;
@property (nonatomic, strong) UILabel *label_empty;

@end

@implementation TeacherCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约";
    [self.view addSubview:self.calendar];
    [self.view insertSubview:self.tableView atIndex:999];
    self.teacher_id = @"user_id_4";
    
//    [self.view addGestureRecognizer:self.scopeGesture];
//    [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:self.scopeGesture];
    
    [self.calendar addObserver:self forKeyPath:@"scope" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:_KVOContext];
    self.calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendar.scope = FSCalendarScopeWeek;
    self.calendar.appearance.weekdayTextColor = __color_font_subtitle;
    self.calendar.appearance.headerTitleColor = __color_main;
    self.calendar.appearance.selectionColor = __color_main;
    
    self.calendar.appearance.todayColor = __color_main_alpha;
    self.calendar.appearance.titleTodayColor = __color_white;
    
    [self.calendar selectDate:[NSDate date] scrollToDate:YES];
    
    // For UITest
    self.calendar.accessibilityIdentifier = @"calendar";
    
//    self.emptyView.hidden = NO;
    
//    self.tableView.hidden = YES;
//    self.header.hidden = YES;
//    self.calendar.hidden = YES;
    self.current_date = [self.dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"today---------%@--------------", self.current_date);
    
}

- (void)dealloc
{
    [self.calendar removeObserver:self forKeyPath:@"scope" context:_KVOContext];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self fetch_weekly_calendar];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
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
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, NAVIHEIGHT, APPScreenWidth, 200)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.tintColor = __color_red_main;
        _calendar.scrollDirection = FSCalendarScrollDirectionVertical;
        _calendar.backgroundColor = [UIColor whiteColor];
    }
    return _calendar;
}

- (UIView *)view_empty_data
{
    if (!_view_empty_data) {
        _view_empty_data = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, self.tableView.height)];
        [_view_empty_data addSubview:self.label_empty];
        _view_empty_data.hidden = YES;
    }
    return _view_empty_data;
}

- (UILabel *)label_empty
{
    if (!_label_empty) {
        _label_empty = [[UILabel alloc] initWithFrame:self.view_empty_data.frame];
        _label_empty.text = @"今天不上课";
        _label_empty.font = __fontthin(16);
        _label_empty.textColor = __color_font_subtitle;
        _label_empty.textAlignment = NSTextAlignmentCenter;
    }
    return _label_empty;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIHEIGHT + 80, APPScreenWidth, APPScreenHeight - NAVIHEIGHT - 80 - SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundColor = __color_gray_background;
        _tableView.backgroundView = self.view_empty_data;
    }
    return _tableView;
}

- (NSMutableDictionary *)dictionary_data
{
    if (!_dictionary_data) {
        _dictionary_data = [[NSMutableDictionary alloc] init];
    }
    return _dictionary_data;
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
    self.current_date = [self.dateFormatter stringFromDate:date];
    [self.tableView reloadData];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
//    NSLog(@"============did select date============= %@",[self.dateFormatter stringFromDate:date]);
//    self.current_date = [self.dateFormatter stringFromDate:date];
//    [self.tableView reloadData];
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
    return [[self.dictionary_data arrayForKey:self.current_date] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView _articleCellForRowAtIndexPath:indexPath];
}

- (TeacherCalendarCell *)tableView:(UITableView *)tableView _articleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"daily_cell";
    TeacherCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TeacherCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *array = [self.dictionary_data arrayForKey:self.current_date];
    [cell bindTeacherCalendar:[array objectAtIndex:indexPath.row]];
    return cell;
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
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
}

- (void)fetch_weekly_calendar
{
    NSDictionary *params = @{@"teacher_id": self.teacher_id};
    WeakSelf;
    [AFR requestWithUrl:REQUEST_TEACHER_CALENDAR
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:params]
          finishedBlock:^(id responseObject){
            NSDictionary *tempDic = (NSDictionary *)responseObject;
            if (![[tempDic objectForKey:@"code"] boolValue]) {
                NSDictionary *data = [tempDic dictionaryForKey:@"data"];
                weakSelf.dictionary_data = [NSMutableDictionary dictionaryWithDictionary:data];
                NSArray *array = [weakSelf.dictionary_data arrayForKey:weakSelf.current_date];
                if (!array) {
                    self.view_empty_data.hidden = NO;
                } else {
                    self.view_empty_data.hidden = YES;
                }
                [weakSelf.tableView reloadData];
            }
        }
            failedBlock:^(NSError *errorInfo){
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}


@end
