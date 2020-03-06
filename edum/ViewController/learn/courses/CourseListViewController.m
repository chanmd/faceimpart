//
//  CourseListViewController.m
//  edum
//
//  Created by Kevin Chan on 26/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//


#import "CourseListViewController.h"
#import "CoursesCell.h"

@interface CourseListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    //    [self ___fetch_things];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[
                           @{@"title": @"钢琴", @"subtitle": @"20万", @"url": @"piano_list"},
                           @{@"title": @"小提琴", @"subtitle": @"20万", @"url": @"piano_list"},
                           @{@"title": @"大提琴", @"subtitle": @"2万", @"url": @"piano_list"},
                           @{@"title": @"长笛", @"subtitle": @"1万", @"url": @"piano_list"},
                           @{@"title": @"黑管", @"subtitle": @"5千", @"url": @"piano_list"},
                           ];
        _array_data = [NSMutableArray arrayWithArray:array];
    }
    return _array_data;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - tableiview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.01)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat footer_height = 0.01f;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, footer_height)];
    return view;
}

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
    if (indexPath.row == [self.array_data count] - 1) {
        return (APPScreenWidth - 20) / 3 + 10 + 20;
    }
    return (APPScreenWidth - 20) / 3 + 10 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    CoursesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CoursesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *course = [self.array_data objectAtIndex:indexPath.row];
    [cell bindDict:course];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
}

#pragma mark - network

- (void)___fetch_things
{
    NSString *url = [NSString stringWithFormat:@"%@/category", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSArray *array = [tempDic arrayForKey:@"data"];
            if (array.count > 0) {
                weakSelf.array_data = [NSMutableArray arrayWithArray:array];
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

//- (void)___fetch_cache_things
//{
//    WeakSelf;
//    [[TMCache sharedCache] objectForKey:self.collection_id block:^(TMCache *cache, NSString *key, id object) {
//        NSArray *array = (NSArray *)object;
//        if ([array count] > 0) {
//            weakSelf.array_data = [NSMutableArray arrayWithArray:array];
//            [weakSelf.tableView reloadData];
//        }
//    }];
//}

@end

