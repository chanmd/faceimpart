//
//  FavoritesViewController.m
//  edum
//
//  Created by Kevin Chan on 3/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "FavoritesViewController.h"
#import "MJRefresh.h"
#import "NSDictionary+JSONExtern.h"
#import "UILabel+LineSpace.h"

@interface FavoritesViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) NSString *itineraries_cache_key;

@property (nonatomic, strong) UIView *view_empty;
@property (nonatomic, strong) UIImageView *imageview_empty;

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Trips";
    [self.view addSubview:self.tableView];
    WeakSelf;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf ___fetch_itineraries];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.button_d setBackgroundColor:[UIColor colorWithHEX:0x000000 Alpha:0.5]];
    [self.button_c setImage:ImageNamed(@"tab_trip_h") forState:UIControlStateNormal];
    [self.button_c setImage:ImageNamed(@"tab_trip_n") forState:UIControlStateHighlighted];
    [self ___fetch_itineraries];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y - 49 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_gray_background;
        _tableView.backgroundView = self.view_empty;
    }
    return _tableView;
}

- (UIView *)view_empty
{
    if (!_view_empty) {
        _view_empty = [[UIView alloc] initWithFrame:APPScreenFrame];
        [_view_empty addSubview:self.imageview_empty];
    }
    return _view_empty;
}

- (UIImageView *)imageview_empty
{
    if (!_imageview_empty) {
        _imageview_empty = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 100) / 2, 200, 100, 100)];
        _imageview_empty.image = ImageNamed(@"icon_empty");
    }
    return _imageview_empty;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.array_data objectAtIndex:indexPath.row];
    if (dict) {
        NSString *text = [dict stringForKey:@"package_title"];
        CGFloat label_height = [UILabel text:text font:__fontbold(20) width:APPScreenWidth - 70 lineSpacing:0];
        CGFloat height = label_height + 150;
        return height;
    } else {
        return 40;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    view.backgroundColor = __color_white;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    view.backgroundColor = __color_white;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
//    static NSString *cellIdentifier = @"cellIdentifier";
//    SightOrderCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
//        cell = [[SightOrderCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    NSDictionary *dict = [self.array_data objectAtIndex:indexPath.row];
//    [cell bindData:dict];
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//    NSDictionary *packageorder = [self.array_data objectAtIndex:indexPath.row];
//    SightOrderDetailViewController *itinerary = [[SightOrderDetailViewController alloc] init];
//    itinerary.package_order_id = [packageorder stringForKey:@"package_order_id"];
//    itinerary.package_id = [packageorder stringForKey:@"package_id"];
//    [self.navigationController pushViewController:itinerary animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *order = [self.array_data objectAtIndex:indexPath.row];
        [self remove_order:order];
        [self.array_data removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)___fetch_cache_itineraries
//{
//    WeakSelf;
//    [[TMCache sharedCache] objectForKey:self.itineraries_cache_key block:^(TMCache *cache, NSString *key, id object) {
//        NSArray *array = (NSArray *)object;
//        if ([array count] > 0) {
//            weakSelf.array_data = [NSMutableArray arrayWithArray:array];
//            [weakSelf.tableView reloadData];
//
//        }
//        [weakSelf ___fetch_itineraries];
//    }];
//}

- (void)___fetch_itineraries
{
    NSString *url = [NSString stringWithFormat:@"%@/packageorders", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    NSDictionary *dict = @{@"user_id": BASEUSER.user_id};
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"------itineraries----%@", tempDic);
        [weakSelf.tableView.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            [weakSelf.array_data removeAllObjects];
            NSArray *array = [tempDic arrayForKey:@"data"];
            if (array.count > 0) {
                weakSelf.view_empty.hidden = YES;
                weakSelf.array_data = [NSMutableArray arrayWithArray:array];
                [weakSelf.tableView reloadData];
            } else {
                weakSelf.view_empty.hidden = NO;
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
        weakSelf.view_empty.hidden = NO;
    }];
}

- (void)remove_order:(NSDictionary *)order
{
    NSString *url = [NSString stringWithFormat:@"%@/discardpackageorder", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    NSDictionary *dict = @{@"user_id": BASEUSER.user_id, @"package_order_id": [order stringForKey:@"package_order_id"]};
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"------itineraries----%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            //present something
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

@end
