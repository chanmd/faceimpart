//
//  CourseListController.m
//  edum
//
//  Created by Md Chen on 27/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "CourseListController.h"
#import "CourseRectangleCell.h"
#import "MJRefresh.h"

@interface CourseListController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CourseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    if (!self.category) {
        [self.tableview reloadData];
    } else {
        [self action_list];
    }
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___action_refresh)];
    }
    return _tableview;
}

- (void)___action_refresh
{
    if (self.category) {
        [self action_list];
    } else {
        [self.tableview.mj_header endRefreshing];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return COURSE_LIST_HEIGHT + 10;
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
    CourseRectangleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rowcell"];
    if (!cell) {
        cell = [[CourseRectangleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rowcell"];
    }
    NSDictionary *course = [self.array_data objectAtIndex:indexPath.row];
    [cell bindData:course];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)action_list
{
    NSDictionary *params = @{@"category": self.category};
    WeakSelf;
    [AFR requestWithUrl:REQUEST_SEGMENT_COURSE
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:params]
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        [weakSelf.tableview.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            [weakSelf.array_data removeAllObjects];
            NSArray *data = [tempDic arrayForKey:@"data"];
            weakSelf.array_data = [NSMutableArray arrayWithArray:data];
            [weakSelf.tableview reloadData];
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

@end
