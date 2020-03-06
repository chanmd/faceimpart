//
//  GuideViewController.m
//  gwlx
//
//  Created by Kevin Chan on 25/10/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "GuideViewController.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "BaseUser.h"
#import "GuideHeaderView.h"
#import "GuideGeneralCell.h"
#import "GuideEditViewController.h"

@interface GuideViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) GuideHeaderView *header;

@end

@implementation GuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self ___fetch_user_info];
//    [self setup_right_button];
}

- (void)setup_right_button
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitle:@"Edit" forState:UIControlStateNormal];
    [button setTitleColor:__color_main forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action_edit) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSString *)getDateString
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970]];
    return curTime;
}

- (void)action_edit
{
    GuideEditViewController *guideedit = [[GuideEditViewController alloc] init];
    
    [self.navigationController pushViewController:guideedit animated:YES];
}

- (GuideHeaderView *)header
{
    if (!_header) {
        _header = [[GuideHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 140)];
    }
    return _header;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight - 44)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_white;
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    GuideGeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GuideGeneralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *array = [self.array_data objectAtIndex:indexPath.row];
    cell.label_title.text = array[0];
    cell.label_subtitle.width = APPScreenWidth;
    cell.label_subtitle.text = array[1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)___fetch_user_info
{
    NSString *url = [NSString stringWithFormat:@"%@/user/userinfo?id=%@", SERVER_DOMAIN, self.string_user_id];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parms = @{@"user_id": self.string_user_id};
    WeakSelf;
    [manager POST:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *user_infomation = [tempDic dictionaryForKey:@"data"];
            if ([user_infomation allKeys] > 0) {
                NSArray *languages = @[@"地区", [NSString stringWithFormat:@"%@ %@ %@", [user_infomation stringForKey:@"country"], [user_infomation stringForKey:@"province"], [user_infomation stringForKey:@"city"]]];
                NSString *since_string = [user_infomation stringForKey:@"create_time"];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *date = [dateFormat dateFromString:since_string];
                [dateFormat setDateFormat:@"YYYY年MM月d日"];
                NSString *dateStr = [dateFormat stringFromDate:date];
                NSArray *membersince = @[@"加入时间", dateStr];
                weakSelf.array_data = [NSMutableArray arrayWithArray:@[languages, membersince]];
                if ([[user_infomation stringForKey:@"verified"] length] > 0) {
                    NSArray *verifiedinfo = @[@"认证", [user_infomation stringForKey:@"verified"]];
                    [weakSelf.array_data addObject:verifiedinfo];
                }
                if ([user_infomation stringForKey:@"desc"]) {
                    NSArray *bio = @[@"简介", [user_infomation stringForKey:@"desc"]];
                    [weakSelf.array_data addObject:bio];
                }
                [weakSelf.header bindDict:user_infomation];
                [weakSelf.tableView reloadData];
            } else {
                weakSelf.tableView.tableHeaderView = nil;
                NSArray *bio = @[@"提示", @"没有查到任何信息"];
                weakSelf.array_data = [NSMutableArray arrayWithArray:@[bio]];
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}



@end
