//
//  MyCoursesViewController.m
//  edum
//
//  Created by Kevin Chan on 15/4/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "MyCoursesViewController.h"
#import <EventKit/EventKit.h>
#import "LunarFormatter.h"
#import "FSCalendar.h"
#import "NSDictionary+JSONEXtern.h"
#import "TouchEventsTestViewController.h"

#define DAILY_Y 80
#define DAILY_HEIGHT (APPScreenHeight - BASE_TABLEVIEW_Y - SafeAreaBottomHeight - DAILY_Y)

NS_ASSUME_NONNULL_BEGIN

@interface MyCoursesViewController () <FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) FSCalendar *calendar;

@property (assign, nonatomic) BOOL showsLunar;
@property (assign, nonatomic) BOOL showsEvents;

- (void)eventItemClicked:(id)sender;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;

@property (strong, nonatomic) NSMutableDictionary *dictionary_data;

@property (strong, nonatomic) UIView *daily_bg;
@property (strong, nonatomic) UIView *daily_bar;
@property (strong, nonatomic) UILabel *daily_title;
@property (strong, nonatomic) UIButton *daily_cancel;
@property (strong, nonatomic) UITableView *daily_tableview;
@property (strong, nonatomic) NSMutableArray *daily_array_data;

@end

NS_ASSUME_NONNULL_END

@implementation MyCoursesViewController

#pragma mark - Life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"课程表";
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.view = view;
    
#define FULL_SCREEN 1
    
#if FULL_SCREEN
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height)];
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO; // important
    calendar.allowsMultipleSelection = YES;
    calendar.firstWeekday = 2;
    calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
#else
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.bounds.size.width, 300)];
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = YES;
    calendar.firstWeekday = 2;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
#endif
    
    [self.view addSubview:self.daily_bg];
    
//    UIBarButtonItem *eventItem = [[UIBarButtonItem alloc] initWithTitle:@"Event" style:UIBarButtonItemStylePlain target:self action:@selector(eventItemClicked:)];
//    [eventItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]} forState:UIControlStateNormal];
//
//    self.navigationItem.rightBarButtonItems = @[eventItem];
    
}

- (UIView *)daily_bg
{
    if (!_daily_bg) {
        _daily_bg = [[UIView alloc] initWithFrame:CGRectMake(0, DAILY_Y + DAILY_HEIGHT, APPScreenWidth, DAILY_HEIGHT)];
        _daily_bg.backgroundColor = __color_white;
        [_daily_bg addSubview:self.daily_bar];
        [_daily_bg addSubview:self.daily_title];
        [_daily_bg addSubview:self.daily_cancel];
        [_daily_bg addSubview:self.daily_tableview];
    }
    return _daily_bg;
}

- (UILabel *)daily_title
{
    if (!_daily_title) {
        _daily_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, APPScreenWidth, 20)];
        _daily_title.font = __font(18);
        _daily_title.textColor = __color_font_title;
        _daily_title.textAlignment = NSTextAlignmentCenter;
    }
    return _daily_title;
}

- (UIView *)daily_bar
{
    if (!_daily_bar) {
        _daily_bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 44)];
        _daily_bar.backgroundColor = __color_gray_background;
    }
    return _daily_bar;
}

- (UIButton *)daily_cancel
{
    if (!_daily_cancel) {
        _daily_cancel = [[UIButton alloc] initWithFrame:CGRectMake(APPScreenWidth - 18 - 10, 13, 18, 18)];
        [_daily_cancel setImage:[UIImage imageNamed:@"view_cancel"] forState:UIControlStateNormal];
        [_daily_cancel addTarget:self action:@selector(eventItemDissmiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _daily_cancel;
}

- (NSMutableArray *)daily_array_data
{
    if (!_daily_array_data) {
        _daily_array_data = [NSMutableArray array];
    }
    return _daily_array_data;
}

- (UITableView *)daily_tableview
{
    if (!_daily_tableview) {
        _daily_tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, APPScreenWidth, DAILY_HEIGHT - 44) style:UITableViewStylePlain];
        _daily_tableview.dataSource = self;
        _daily_tableview.delegate = self;
        _daily_tableview.separatorColor = __color_gray_separator;
        _daily_tableview.backgroundColor = __color_white;
    }
    return _daily_tableview;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.minimumDate = [self.dateFormatter dateFromString:@"2016-02-03"];
    self.maximumDate = [self.dateFormatter dateFromString:@"2021-04-10"];
    
    self.calendar.accessibilityIdentifier = @"calendar";
    
    [self fetch_course_calendar];
    
    TouchEventsTestViewController *test = [[TouchEventsTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:NO];
    
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     self.minimumDate = [self.dateFormatter dateFromString:@"2015-02-01"];
     self.maximumDate = [self.dateFormatter dateFromString:@"2015-06-10"];
     [self.calendar reloadData];
     });
     */
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.hidden = YES;
    [self.button_b setImage:ImageNamed(@"calendar_highlight") forState:UIControlStateNormal];
    //    [MobClick beginLogPageView:@"mainview"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
#if FULL_SCREEN
    self.calendar.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.navigationController.navigationBar.frame));
#else
    self.calendar.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.bounds.size.width, 300);
#endif
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (NSMutableDictionary *)dictionary_data
{
    if (!_dictionary_data) {
        _dictionary_data = [NSMutableDictionary dictionary];
    }
    return _dictionary_data;
}

#pragma mark - Target actions

- (void)eventItemClicked:(id)sender
{
    NSArray *array = [self.dictionary_data arrayForKey:sender];
    self.daily_array_data = [NSMutableArray arrayWithArray:array];
    [self.daily_tableview reloadData];
    self.daily_title.text = sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.05];
    self.daily_bg.centerY = APPScreenHeight - DAILY_HEIGHT / 2;
//    if (!self.showsEvents) {
//        self.daily_bg.centerY = APPScreenHeight - DAILY_HEIGHT / 2;
//    } else {
//        self.daily_bg.centerY = APPScreenHeight + DAILY_HEIGHT / 2;
//    }
//    self.showsEvents = !self.showsEvents;
    [UIView commitAnimations];
}

- (void)eventItemDissmiss
{
    self.daily_bg.centerY = APPScreenHeight + DAILY_HEIGHT / 2;
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return self.maximumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    NSString *date_string = [self.dateFormatter stringFromDate:date];
    NSArray *array = [self.dictionary_data objectForKey:date_string];
    if (array) {
        return [NSString stringWithFormat:@"%ld节课", [array count]];
    }
    return nil;
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.daily_array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rowcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rowcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *daily_detail = [self.daily_array_data objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [daily_detail stringForKey:@"start_time"], [daily_detail stringForKey:@"end_time"]];
    cell.detailTextLabel.text = [daily_detail stringForKey:@"student"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);
    [self eventItemClicked:[self.dateFormatter stringFromDate:date]];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSString *date_string = [self.dateFormatter stringFromDate:date];
    NSArray *array = [self.dictionary_data objectForKey:date_string];
    if (array) {
        return 1;
    }
    return 0;
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    NSString *date_string = [self.dateFormatter stringFromDate:date];
    NSArray *array = [self.dictionary_data objectForKey:date_string];
    if (array) {
        NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:0];
        [colors addObject:__color_main];
        return colors.copy;
    } else {
        return nil;
    }
}

- (void)fetch_course_calendar
{
    NSString *url = [NSString stringWithFormat:@"%@/course/coursecalendar", SERVER_DOMAIN];
    //    NSDictionary *dic = @{@"user_id": [BaseUser instance].user_id};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if ([[tempDic objectForKey:@"code"] integerValue] == 0) {
            NSDictionary *dictionary_data = [tempDic dictionaryForKey:@"data"];
            if ([[dictionary_data allKeys] count] > 0) {
                weakSelf.dictionary_data = [NSMutableDictionary dictionaryWithDictionary:dictionary_data];
                [weakSelf.calendar reloadData];
            } else {
                [weakSelf hud_textonly:RESPONSE_NONE];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}


@end
