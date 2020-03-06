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

@end

@implementation WeeklyScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self simulate_data];
//    self.emptyView.hidden = NO;
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
    self.navigationController.navigationBar.hidden = YES;
    [self.button_b setImage:ImageNamed(@"calendar_highlight") forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [MobClick endLogPageView:@"mainview"];
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

-(UIView *)emptyView
{
    if (!_emptyView)
    {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenWidthHalf + 222, self.tableView.width, 150)];
        _emptyView.backgroundColor = self.view.backgroundColor;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((_emptyView.width - 155) / 2.0, 0, 155, 109)];
        img.image = ImageNamed(@"empty");
        [_emptyView addSubview:img];
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(15, img.bottom + 10, self.view.width - 30, 18)];
        tips.backgroundColor = self.view.backgroundColor;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = __font(16);
        tips.textColor = __color_gray_separator;
        tips.text = @"没有课程";
        [_emptyView addSubview:tips];
        _emptyView.hidden = YES;
    }
    return _emptyView;
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

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
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
    NSDictionary *daily = [self.array_data objectAtIndex:indexPath.row];
    [cell bindDailyData:daily];
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

- (void)___fetch_category
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
                @"status": @"3",
              },
            @{
              @"id": @"13",
              @"title": @"大提琴基础练习大提琴基础练习",
              @"time": @"12:00 - 13:00",
              @"status": @"2",
            },
            @{
              @"id": @"13",
              @"title": @"大提琴基础练习大提琴基础练习",
              @"time": @"15:00 - 16:00",
              @"status": @"1",
            },
    ];
    
    self.array_data = [[NSMutableArray alloc] initWithArray:array];
}

@end
