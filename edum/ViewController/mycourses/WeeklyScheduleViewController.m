//
//  WeeklyScheduleViewController.m
//  edum
//
//  Created by Kevin Chan on 3/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "WeeklyScheduleViewController.h"
#import "DailyScheduleCell.h"
#import "WeeklyScheduleHeaderView.h"

@interface WeeklyScheduleViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>
{
    void * _KVOContext;
}

@property (nonatomic, strong) WeeklyScheduleHeaderView *header;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIButton *button_login;
@property (nonatomic, strong) UIView *view_empty_data;


@end

@implementation WeeklyScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的课程表";
    [self.view insertSubview:self.header atIndex:998];
    [self.header addSubview:self.calendar];
    [self.view insertSubview:self.tableView atIndex:1000];
    [self.view insertSubview:self.emptyView atIndex:999];
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
    [self.button_b setImage:ImageNamed(@"calendar_highlight") forState:UIControlStateNormal];
    
    self.current_date = [self.dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"today---------%@--------------", self.current_date);
    
    [self fetch_weekly_calendar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [MobClick endLogPageView:@"mainview"];
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

- (WeeklyScheduleHeaderView *)header
{
    if (!_header) {
        _header = [[WeeklyScheduleHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidthHalf + 200)];
    }
    return _header;
}


- (FSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, APPScreenWidthHalf, APPScreenWidth, 200)];
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
        _view_empty_data = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _view_empty_data;
}

-(UIView *)emptyView
{
    if (!_emptyView)
    {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y - SafeAreaBottomHeight - 49)];
        _emptyView.backgroundColor = self.view.backgroundColor;
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, self.view.width - 30, 22)];
        tips.backgroundColor = self.view.backgroundColor;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = __font(18);
        tips.textColor = __color_font_placeholder;
        tips.text = @"登录后查看课程";
        [_emptyView addSubview:tips];
        self.button_login.top = tips.bottom + 40;
        [_emptyView addSubview:self.button_login];
        
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (UIButton *)button_login
{
    if (!_button_login) {
        _button_login = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_login.frame = CGRectMake((APPScreenWidth - 150) / 2, 60, 150, 44);
        _button_login.layer.cornerRadius = 22;
        _button_login.layer.masksToBounds = YES;
        [_button_login setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [_button_login addTarget:self action:@selector(action_login) forControlEvents:UIControlEventTouchUpInside];
        [_button_login setTitleColor:__color_white forState:UIControlStateNormal];
        _button_login.layer.backgroundColor = [__color_main CGColor];
    }
    return _button_login;
}

- (void)action_login
{
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPScreenWidthHalf + 90, APPScreenWidth, APPScreenHeight - 64 - APPScreenWidthHalf - 90 - BASE_VIEW_Y) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundColor = __color_gray_background;
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
    return WEEKLY_CELL_HEIGHT + 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView _articleCellForRowAtIndexPath:indexPath];
}

- (DailyScheduleCell *)tableView:(UITableView *)tableView _articleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"daily_cell";
    DailyScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DailyScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSLog(@"cell---------------%@------------", self.current_date);
    NSArray *array = [self.dictionary_data arrayForKey:self.current_date];
    if (array) {
        NSDictionary *daily = [array objectAtIndex:indexPath.row];
        [cell bindDailyData:daily];
    }
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
    NSDictionary *parms = @{@"token": @"", @"user_id": @"user_id"};
    WeakSelf;
    [AFR requestWithUrl:REQUEST_CALENDAR_LIST
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:parms]
          finishedBlock:^(id responseObject){
            NSDictionary *tempDic = (NSDictionary *)responseObject;
            if (![[tempDic objectForKey:@"error"] boolValue]) {
                NSDictionary *data = [tempDic dictionaryForKey:@"data"];
                weakSelf.dictionary_data = [NSMutableDictionary dictionaryWithDictionary:data];
                [weakSelf.tableView reloadData];
            }
        }
            failedBlock:^(NSError *errorInfo){
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

@end
