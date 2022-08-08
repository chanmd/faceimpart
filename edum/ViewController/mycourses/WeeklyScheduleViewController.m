//
//  WeeklyScheduleViewController.m
//  edum
//
//  Created by Kevin Chan on 3/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "WeeklyScheduleViewController.h"
#import "CourseRectangleCell.h"
#import "LoginViewController.h"
#import "CourseViewController.h"

@interface WeeklyScheduleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *label_logo;
@property (nonatomic, strong) NSMutableArray *array_date;
@property (nonatomic, strong) NSMutableArray *array_week;
@property (nonatomic, strong) NSMutableArray *array_day;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIButton *button_login;
@property (nonatomic, strong) UIView *view_empty_data;
@property (nonatomic, strong) UIButton *button_add;


@end

@implementation WeeklyScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label_logo];
    [self initSegments];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
    self.current_date = [self.dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"today---------%@--------------", self.current_date);
}

- (UILabel *)label_logo
{
    if (!_label_logo) {
        _label_logo = [[UILabel alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y - 30, APPScreenWidth, 20)];
        _label_logo.textColor = __color_font_title;
        _label_logo.textAlignment = NSTextAlignmentCenter;
        _label_logo.text = @"Calendar";
        _label_logo.font = __fontlight(20);
    }
    return _label_logo;
}

- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] init];
        _segmentedControl.sectionTitles = self.array_week;
        _segmentedControl.frame = CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, 40);
        [_segmentedControl addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.selectionIndicatorColor = __color_main;
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: __color_font_title, NSFontAttributeName: __font(18)};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: __color_font_title, NSFontAttributeName: __font(18)};
        _segmentedControl.selectionIndicatorHeight = 2.f;
        _segmentedControl.shouldAnimateUserSelection = YES;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    }
    return _segmentedControl;
}

- (HMSegmentedControl *)segmentedControlCalendar
{
    if (!_segmentedControlCalendar) {
        _segmentedControlCalendar = [[HMSegmentedControl alloc] init];
        _segmentedControlCalendar.sectionTitles = self.array_day;
        _segmentedControlCalendar.frame = CGRectMake(0, self.segmentedControl.bottom, APPScreenWidth, 40);
        [_segmentedControlCalendar addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
        _segmentedControlCalendar.backgroundColor = [UIColor whiteColor];
        _segmentedControlCalendar.titleTextAttributes = @{NSForegroundColorAttributeName: __color_font_title, NSFontAttributeName: __fontmedium(18)};
        _segmentedControlCalendar.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: __color_main, NSFontAttributeName: __fontmedium(18)};
        
        _segmentedControlCalendar.selectionIndicatorColor = __color_main;
        _segmentedControlCalendar.selectionIndicatorHeight = 2.f;
        _segmentedControlCalendar.shouldAnimateUserSelection = YES;
        _segmentedControlCalendar.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControlCalendar.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    }
    return _segmentedControlCalendar;
}

- (void)initSegments {
    [self initCalendarDate];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.segmentedControlCalendar];
}


- (void)segmentSelected {
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.segmentedControlCalendar.bottom, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y - 64 - 80 - 20) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundView = self.view_empty_data;
    }
    return _tableView;
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.button_b setImage:ImageNamed(@"calendar_highlight") forState:UIControlStateNormal];
    if (![BASEUSER isLogin]) {
        self.tableView.hidden = NO;
        self.emptyView.hidden = YES;
    } else {
        self.tableView.hidden = YES;
        self.emptyView.hidden = NO;
    }
    [self fetch_weekly_calendar];
    
}

- (void)initCalendarDate {
    for (int i = 0; i < 7; i ++) {
        NSDate *date = [self getDayOffset:i];
        [self.array_date addObject:date];
        
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        formate.dateFormat = @"d";
        NSString *day = [formate stringFromDate:date];
        [self.array_day addObject:day];
        
        formate.dateFormat = @"EEE";
        NSString *week = [formate stringFromDate:date];
        [self.array_week addObject:week];
    }
}

- (NSDate *)getDayOffset:(NSInteger)offset {
    NSDate *nowdate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *component = [[NSDateComponents alloc] init];
    [component setDay:offset];
    return [calendar dateByAddingComponents:component toDate:nowdate options:0];
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
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (NSMutableArray *)array_day {
    if (!_array_day) {
        _array_day = [NSMutableArray array];
    }
    return _array_day;
}

- (NSMutableArray *)array_week {
    if (!_array_week) {
        _array_week = [NSMutableArray array];
    }
    return _array_week;
}

- (NSMutableArray *)array_date {
    if (!_array_date) {
        _array_date = [NSMutableArray array];
    }
    return _array_date;
}


- (UIView *)view_empty_data
{
    if (!_view_empty_data) {
        _view_empty_data = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 300)];
        [_view_empty_data addSubview:self.button_add];
        _view_empty_data.hidden = YES;
    }
    return _view_empty_data;
}

- (UIButton *)button_add
{
    if (!_button_add) {
        _button_add = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button_add setTitle:@"Add Course" forState:UIControlStateNormal];
        _button_add.frame = CGRectMake((APPScreenWidth - 130) / 2, 90, 130, 40);
        _button_add.clipsToBounds = YES;
        _button_add.layer.cornerRadius = 20;
        _button_add.titleLabel.font = __fontmedium(16);
        _button_add.layer.backgroundColor = [__color_main CGColor];
        [_button_add setTitleColor:__color_white forState:UIControlStateNormal];
        [_button_add addTarget:self action:@selector(action_add) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_add;
}

- (void)action_add
{
    [self.tabBarController setSelectedIndex:0];
}

-(UIView *)emptyView
{
    if (!_emptyView)
    {
        _emptyView = [[UIView alloc] initWithFrame:self.tableView.frame];
        _emptyView.backgroundColor = self.view.backgroundColor;
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, self.view.width - 30, 22)];
        tips.backgroundColor = self.view.backgroundColor;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = __font(16);
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
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController presentViewController:login animated:YES completion:nil];
}

- (NSMutableDictionary *)dictionary_data
{
    if (!_dictionary_data) {
        _dictionary_data = [[NSMutableDictionary alloc] init];
    }
    return _dictionary_data;
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
    return COURSE_LIST_HEIGHT + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView _articleCellForRowAtIndexPath:indexPath];
}

- (CourseRectangleCell *)tableView:(UITableView *)tableView _articleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"daily_cell";
    CourseRectangleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CourseRectangleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *array = [self.dictionary_data arrayForKey:self.current_date];
    if (array) {
        NSDictionary *daily = [[array objectAtIndex:indexPath.row] dictionaryForKey:@"course"];
        [cell bindData:daily];
        cell.label_rates.hidden = YES;
    }
    return cell;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [self.dictionary_data arrayForKey:self.current_date];
    if (array) {
        NSDictionary *daily = [array objectAtIndex:indexPath.row];
        
        CourseViewController *course = [[CourseViewController alloc] init];
        course.course_id = [daily stringForKey:@"course_id"];
        [self.navigationController pushViewController:course animated:YES];
        
//        NSString *start_time_string = [daily stringForKey:@"start_time"];
//        NSString *end_time_string = [daily stringForKey:@"end_time"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSDate *start_time = [formatter dateFromString:start_time_string];
//        NSDate *end_time = [formatter dateFromString:end_time_string];
//        NSInteger status = 0;
//        NSDate *current_time = [NSDate date];
//        NSComparisonResult result_start = [start_time compare:current_time];
//        NSComparisonResult result_end = [end_time compare:current_time];
//        if (result_start == NSOrderedAscending && result_end == NSOrderedDescending) {
//                status = 2;
//        } else if (result_start == NSOrderedDescending) {
//                status = 1;
//        } else if (result_end == NSOrderedAscending) {
//                status = 3;
//        }
//        if (status < 3) {
//            VideoCallViewController *call = [[VideoCallViewController alloc] init];
//            call.course_data = daily;
//            self.navigationController.navigationBar.hidden = YES;
//            [self.navigationController pushViewController:call animated:NO];
//        }
    }
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
    WeakSelf;
    [AFR requestWithUrl:REQUEST_CALENDAR_LIST
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionary]
          finishedBlock:^(id responseObject){
            NSDictionary *tempDic = (NSDictionary *)responseObject;
            if ([[tempDic objectForKey:@"code"] integerValue] == 0) {
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
