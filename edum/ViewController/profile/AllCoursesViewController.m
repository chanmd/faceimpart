//
//  AllCoursesViewController.m
//  edum
//
//  Created by Kevin Chan on 3/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "AllCoursesViewController.h"
#import "LandingCourseCell.h"
#import "MJRefresh.h"
#import "CourseViewController.h"

@interface AllCoursesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UILabel *label_nomore;
@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) NSInteger page_number;
@property (nonatomic, assign) NSInteger total;

@end

@implementation AllCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部课程";
    
    self.page_size = 2;
    self.page_number = 1;
    self.total = 0;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetch_all_course];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(UIView *)emptyView
{
    if (!_emptyView) {
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y - SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_white;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull_down)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pull_up)];
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

- (UILabel *)label_nomore
{
    if (!_label_nomore) {
        _label_nomore = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, APPScreenWidth, 20)];
        _label_nomore.textAlignment = NSTextAlignmentCenter;
        _label_nomore.text = @"没有更多了";
        _label_nomore.font = __fontthin(16);
        _label_nomore.textColor = __color_font_placeholder;
        _label_nomore.hidden = YES;
    }
    return _label_nomore;
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
    return LANDING_COURSE_HEIGHT + 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView _courseCellForRowAtIndexPath:indexPath];
}

- (LandingCourseCell *)tableView:(UITableView *)tableView _courseCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"course_cell";
    LandingCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dictionary = [self.array_data objectAtIndex:indexPath.row];
    [cell bindCourseWithData:dictionary];
    return cell;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CourseViewController *courseview = [[CourseViewController alloc] init];
    NSDictionary * course = [self.array_data objectAtIndex:indexPath.row];
    NSString *course_id = [course stringForKey:@"course_id"];
    courseview.course_id = course_id;
    [self.navigationController pushViewController:courseview animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 20)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 40)];
    [view addSubview:self.label_nomore];
    return view;
}

#pragma mark <actions>

- (void)fetch_all_course
{
    NSDictionary *params = @{@"page_size": @(self.page_size), @"page_number": @(self.page_number)};
    WeakSelf;
    [AFR requestWithUrl:REQUEST_ALL_COURESE
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:params]
          finishedBlock:^(id responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSDictionary *tempDic = (NSDictionary *)responseObject;
            
        NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            
        if ([[tempDic objectForKey:@"code"] integerValue] == 0) {
            weakSelf.total = [[data stringIntForKey:@"total"] integerValue];
            weakSelf.page_number = [[data stringIntForKey:@"page_number"] integerValue];
            weakSelf.page_size = [[data stringIntForKey:@"page_size"] integerValue];
            if ((weakSelf.page_size * weakSelf.page_number) >= weakSelf.total) {
                weakSelf.label_nomore.hidden = NO;
            } else {
                weakSelf.label_nomore.hidden = YES;
            }
                
            if (weakSelf.page_number == 1) {
                [weakSelf.array_data removeAllObjects];
                weakSelf.array_data = nil;
                weakSelf.array_data = [NSMutableArray arrayWithArray:[data arrayForKey:@"data"]];
            } else {
                [weakSelf.array_data addObjectsFromArray:[data arrayForKey:@"data"]];
            }
            [weakSelf.tableView reloadData];
    }
        
    }
    failedBlock:^(NSError *errorInfo) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

- (void)pull_up
{
    if ((self.page_size * self.page_number) < self.total) {
        self.page_number ++;
        [self fetch_all_course];
        self.label_nomore.hidden = YES;
    } else {
        [self.tableView.mj_footer endRefreshing];
        self.label_nomore.hidden = NO;
    }
}

- (void)pull_down
{
    self.page_number = 1;
    [self fetch_all_course];
}

@end
