//
//  UserNotificationViewController.m
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "UserNotificationViewController.h"
#import "UserNotificationCell.h"
#import "UILabel+LineSpace.h"
#import "UserNotificationDetailViewController.h"
#import "MJRefresh.h"

@interface UserNotificationViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSDateFormatter *df;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic,strong) UIView *noMessageView;
@property (nonatomic, strong) UILabel *label_nomore;
@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) NSInteger page_number;
@property (nonatomic, assign) NSInteger total;

@end

@implementation UserNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    // Do any additional setup after loading the view.
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    self.page_size = 2;
    self.page_number = 1;
    self.total = 0;
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = __color_gray_background;
    self.tableView.hidden = NO;
    [self.view addSubview:self.noMessageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetch_notification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull_down)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pull_up)];
    }
    return _tableView;
}

- (void)setupView
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.tableView.tableHeaderView = [[UIView alloc] init];
    
    for (UIGestureRecognizer *gesture in self.tableView.gestureRecognizers)
    {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]])
        {
            [self.tableView removeGestureRecognizer:gesture];
        }
    }
}

-(UIView *)noMessageView
{
    if (!_noMessageView)
    {
        _noMessageView = [[UIView alloc] initWithFrame:self.tableView.frame];
        
        UIImageView *empty = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 155) / 2.0, 120, 155, 109)];
        empty.image = ImageNamed(@"empty");
        [_noMessageView addSubview:empty];
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, empty.bottom + 15, APPScreenWidth, 30)];
        tips.backgroundColor = __color_clear;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = __font(18);
        tips.textColor = __color_font_subtitle;
        tips.text = @"还没有消息";
        [_noMessageView addSubview:tips];
        _noMessageView.hidden = YES;
    }
    return _noMessageView;
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
    return 1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 1.f)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 40)];
    [view addSubview:self.label_nomore];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = [self.array_data objectAtIndex:indexPath.row];
    CGFloat height = [UILabel text:[message stringForKey:@"content"] font:__fontthin(16) width:APPScreenWidth - 40 lineSpacing:5];
    return 62 + 50 + height + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TKSystemChatCell";
    UserNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UserNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.view.backgroundColor;
    }
    
    NSDictionary *message = [self.array_data objectAtIndex:indexPath.row];
    [cell bindUserNotification:message];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *data = [self.array_data objectAtIndex:indexPath.row];
    UserNotificationDetailViewController *detail = [[UserNotificationDetailViewController alloc] init];
    detail.data = data;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)fetch_notification
{
    NSDictionary *params = @{@"page_size": @(self.page_size), @"page_number": @(self.page_number)};
    WeakSelf;
    [AFR requestWithUrl:REQUEST_USER_NOTIFICATION
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:params]
          finishedBlock:^(id responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSDictionary *data = [tempDic dictionaryForKey:@"data"];
        if ([[tempDic objectForKey:@"code"] integerValue] == 0) {
            
            weakSelf.total = [[data stringIntForKey:@"total"] integerValue];
            if (weakSelf.total == 0) {
                weakSelf.noMessageView.hidden = NO;
            } else {
                weakSelf.noMessageView.hidden = YES;
            }
            
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
        [self fetch_notification];
        self.label_nomore.hidden = YES;
    } else {
        [self.tableView.mj_footer endRefreshing];
        self.label_nomore.hidden = NO;
    }
}

- (void)pull_down
{
    self.page_number = 1;
    [self fetch_notification];
}


@end
