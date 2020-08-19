//
//  ZhenViewController.m
//  gwlx
//
//  Created by Chan Kevin on 19/9/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "ZhenViewController.h"

#import "ProfileHeadCell.h"
#import "ProfileHeaderView.h"
#import "SettingViewController.h"
#import "BaseUser.h"
#import "BTKeychain.h"
#import "AboutViewController.h"
#import "AboutContentViewController.h"
#import "LoginViewController.h"
#import "AvatarView.h"
#import "GuideEditViewController.h"
#import "ZhenCell.h"
#import "UserNotificationViewController.h"
#import "ProfileViewController.h"
#import "FollowingViewController.h"
#import "AllCoursesViewController.h"


@interface ZhenViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array_data;
@property (nonatomic, strong) AvatarView *header;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UIButton *logout;

@end

@implementation ZhenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
    if ([BASEUSER isLogin]) {
        self.title = BASEUSER.nickname;
    }
//    [self setupSetting];
//    [self __initCubes];
//    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    [self.view addSubview:self.tableView];
//    [self.header bindData:@{@"nickname" :BASEUSER.nickname, @"headimgurl": BASEUSER.headimgurl}];
//    [self ___fetch_followinfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //    [self.button_e setBackgroundColor:[UIColor colorWithHEX:0x000000 Alpha:0.5]];
    [self.button_c setImage:ImageNamed(@"profile_highlight") forState:UIControlStateNormal];
    [self headview_status];
//    [MobClick beginLogPageView:@"profile"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [MobClick endLogPageView:@"profile"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -(AdaptNaviHeight + BASE_VIEW_Y), APPScreenWidth, APPScreenHeight - BASE_VIEW_Y - SafeAreaBottomHeight - 49) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.separatorColor = __color_gray_separator;
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (UIButton *)logout
{
    if (!_logout) {
        _logout = [[UIButton alloc] initWithFrame:CGRectMake(-0.5, 10, APPScreenWidth + 1, 44)];
        [_logout setTitle:NSLocalizedString(@"logout", nil) forState:UIControlStateNormal];
        [_logout setTitleColor:__color_font_title forState:UIControlStateNormal];
        _logout.titleLabel.font = __font(16);
        _logout.backgroundColor = __color_white;
        _logout.layer.borderWidth = 1;
        _logout.layer.borderColor = [__color_gray_separator CGColor];
        _logout.clipsToBounds = YES;
        [_logout addTarget:self action:@selector(action_logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logout;
}

- (void)setupSetting
{
    UIButton *button_cal = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button_cal setImage:ImageNamed(@"icon_setting") forState:UIControlStateNormal];
    [button_cal addTarget:self action:@selector(action_setting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button_cal];
    self.navigationItem.rightBarButtonItem = barbutton;
}

- (AvatarView *)header
{
    if (!_header) {
        _header = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidth / 2)];
        [_header.button addTarget:self action:@selector(action_avatar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _header;
}

- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 20)];
    }
    return _footer;
}

#pragma mark - tableiview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array_data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.array_data objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 15);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 10);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = __color_white;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"main_cell";
    ZhenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ZhenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *array = [[self.array_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageview_cover.image = ImageNamed(array[0]);
    cell.label_title.text = [array objectAtIndex:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dispatch = [[[self.array_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:2];
    [self performSelector:NSSelectorFromString(dispatch) withObject:nil];
}

- (NSArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[@[
                               @[@"musicnote", @"我的课程", @"action_course"],
//                               @[@"study", @"我的关注", @"action_following"],
                               @[@"remainder", @"我的消息", @"action_message"],
//                               @[@"teacher", @"我是老师", @"action_teacher"],
//                               @[@"customer", @"客服中心", @"action_customer"],
                               @[@"setting", @"设置", @"action_setting"]
                             ]];
        _array_data = [[NSArray alloc] initWithArray:array];
    }
    return _array_data;
}

#pragma mark - actions

- (void)action_message
{
    UserNotificationViewController *notification = [[UserNotificationViewController alloc] init];
    [self.navigationController pushViewController:notification animated:YES];
}

- (void)action_course
{
    AllCoursesViewController *allcoursers = [[AllCoursesViewController alloc] init];
    [self.navigationController pushViewController:allcoursers animated:YES];
}

- (void)action_teacher
{
    
}

- (void)action_following
{
    FollowingViewController *following = [[FollowingViewController alloc] init];
    [self.navigationController pushViewController:following animated:YES];
}

- (void)action_customer
{
    
}

- (void)action_setting
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)action_avatar
{
    if ([BASEUSER isLogin]) {
        [self action_profile];
    } else {
        [self action_login];
    }
}

- (void)action_profile
{
    GuideEditViewController *guide = [[GuideEditViewController alloc] init];
    [self.navigationController pushViewController:guide animated:YES];
}

- (void)action_login
{
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)action_logout
{
    [self alertShowWithConfirm:NSLocalizedString(@"confirm", nil)];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[BaseUser instance] destory_all];
        [[NSNotificationCenter defaultCenter] postNotificationName:__LOGOUT object:nil];
    }
}

#pragma mark - network

- (void)___fetch_followinfo
{
    NSString *url = [NSString stringWithFormat:@"%@/followinfo", SERVER_DOMAIN];
    NSDictionary *dic = @{@"user_id": BASEUSER.user_id};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"-------userinfo---%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            if ([data.allKeys count] > 0) {
                [weakSelf.header bindData:data];
//                [weakSelf headview_status];
            } else {
//                [weakSelf.header bindNumber:@{@"follower": @"0", @"following": @"0"}];
            }
        } else {
//            [weakSelf.header bindNumber:@{@"follower": @"0", @"following": @"0"}];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)headview_status
{
    if ([BASEUSER isLogin]) {
        
        NSString *avatar_url = BASEUSER.headimgurl;
        WeakSelf;
        [self.header.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:avatar_url] placeholderImage:ImageNamed(@"logo_launch") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                weakSelf.header.imageview_avatar.image = ImageNamed(@"logo_launch");
            } else {
                weakSelf.header.imageview_avatar.image = image;
            }
            weakSelf.tableView.tableHeaderView = weakSelf.header;
            [weakSelf.tableView reloadData];
        }];
        self.header.imageview_avatar.hidden = NO;
        self.header.view_avatar.hidden = NO;
        if (BASEUSER.nickname) {
            self.header.label_name.text = BASEUSER.nickname;
        } else {
            self.header.label_name.text = @"昵称";
        }
        
        self.header.label_name.hidden = NO;
    } else {
        
        self.header.imageview_avatar.hidden = NO;
        self.header.view_avatar.hidden = NO;
        self.header.imageview_avatar.image = ImageNamed(@"logo_launch");
        self.header.label_name.hidden = NO;
        self.header.label_name.text = @"请登陆";
        self.tableView.tableHeaderView = self.header;
        [self.tableView reloadData];
    }
}

@end

