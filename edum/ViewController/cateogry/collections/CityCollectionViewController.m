//
//  CityCollectionViewController.m
//  gwlx
//
//  Created by Chan Kevin on 8/5/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "CityCollectionViewController.h"
#import "SightListCell.h"
#import "SightViewController.h"
#import "CategoryHeaderView.h"
#import "MJRefresh.h"
#import "NSDictionary+JSONExtern.h"

@interface CityCollectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CategoryHeaderView *header;

@end

@implementation CityCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___fetch_things)];
    self.tableView.mj_header = header;
    [self ___fetch_things];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSMutableArray array];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (CategoryHeaderView *)header
{
    if (!_header) {
        _header = [[CategoryHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidth / 2)];
        [_header.imageview_cover sd_setImageWithURL:HTURL([self.dict_info stringForKey:@"url"])];
    }
    return _header;
}

#pragma mark - tableiview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return GENERAL_PADDING;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, GENERAL_PADDING)];
    view.backgroundColor = __color_white;
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (APPScreenWidth - (GENERAL_PADDING * 2)) * 0.75 + GENERAL_CUBE_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    SightListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SightListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [self.array_data objectAtIndex:indexPath.row];
    [cell bindData:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SightViewController *sight = [[SightViewController alloc] init];
    NSDictionary *dict = [self.array_data objectAtIndex:indexPath.row];
    sight.package_id = [dict stringForKey:@"package_id"];
    sight.dic_preview = dict;
    [self.navigationController pushViewController:sight animated:YES];
}

#pragma mark - network

- (void)___fetch_things
{
    NSString *url = [NSString stringWithFormat:@"%@/category/%@", SERVER_DOMAIN, self.collection_id];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        [weakSelf.tableView.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSArray *array = [tempDic arrayForKey:@"data"];
            if (array.count > 0) {
                weakSelf.array_data = [NSMutableArray arrayWithArray:array];
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hud_textonly:__error_message];
    }];
}

- (void)___fetch_cache_things
{
    WeakSelf;
    [[TMCache sharedCache] objectForKey:self.collection_id block:^(TMCache *cache, NSString *key, id object) {
        NSArray *array = (NSArray *)object;
        if ([array count] > 0) {
            weakSelf.array_data = [NSMutableArray arrayWithArray:array];
            [weakSelf.tableView reloadData];
        }
    }];
}

@end
