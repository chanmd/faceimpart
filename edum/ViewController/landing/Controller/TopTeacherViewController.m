//
//  TopTeacherViewController.m
//  edum
//
//  Created by Kevin Chan on 5/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "TopTeacherViewController.h"
#import "LandingTeacherListCell.h"
#import "MJRefresh.h"
#import "TeacherViewController.h"

@interface TopTeacherViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;

@end

@implementation TopTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"老师推荐";
    [self ___fetch_teacher];
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
        _tableView.backgroundColor = __color_gray_background;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = __color_gray_separator;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___fetch_teacher)];
        
    }
    return _tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 0.1);
    return [[UIView alloc] initWithFrame:frame];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 15);
    return [[UIView alloc] initWithFrame:frame];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15.f;
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
    static NSString *cellIdentifier = @"cellIdentifier";
    LandingTeacherListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingTeacherListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *data = [self.array_data objectAtIndex:indexPath.row];
    [cell bindTeacherListWithData:data];
    [cell bindTeacherListFollowingStatus:0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = [self.array_data objectAtIndex:indexPath.row];
    TeacherViewController *teacher = [[TeacherViewController alloc] init];
    teacher.user_id = [data stringForKey:@"user_id"];
    [self.navigationController pushViewController:teacher animated:YES];
    
}

- (void)___fetch_teacher
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"category": [NSString stringWithFormat:@"%ld", self.category]}];
    NSString *request_url = REQUEST_SEGMENT_TEACHER;
    if (self.category == 0) {
        request_url = REQUEST_LANDING_TEACHER;
    } else {
        request_url = REQUEST_SEGMENT_TEACHER;
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
