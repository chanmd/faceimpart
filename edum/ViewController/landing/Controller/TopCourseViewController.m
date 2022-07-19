//
//  TopCourseViewController.m
//  edum
//
//  Created by Kevin Chan on 5/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "TopCourseViewController.h"
#import "LandingCourseCell.h"
#import "CourseViewController.h"
#import "MJRefresh.h"

@interface TopCourseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;

@end

@implementation TopCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"精选课程";
    [self ___fetch_course];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSMutableArray array];
    }
    return _array_data;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___fetch_course)];
    }
    return _tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 10);
    return [[UIView alloc] initWithFrame:frame];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 15);
    return [[UIView alloc] initWithFrame:frame];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LANDING_COURSE_HEIGHT + 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = [self.array_data objectAtIndex:indexPath.row];
    CourseViewController *courseview = [[CourseViewController alloc] init];
    courseview.course_id = [course stringForKey:@"course_id"];
    [self.navigationController pushViewController:courseview animated:YES];
    
}

- (void)___fetch_course
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"category": [NSString stringWithFormat:@"%ld", self.category]}];
    NSString *request_url = REQUEST_SEGMENT_COURSE;
    if (self.category == 0) {
        request_url = REQUEST_LANDING_COURSE;
    } else {
        request_url = REQUEST_SEGMENT_COURSE;
    }
    WeakSelf;
    [AFR requestWithUrl:request_url
             httpmethod:@"POST"
                 params:params
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        [weakSelf.tableView.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            
            NSArray *data = [tempDic arrayForKey:@"data"];
            weakSelf.array_data = [NSMutableArray arrayWithArray:data];
            [weakSelf.tableView reloadData];
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}



@end
