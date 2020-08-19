//
//  SettingViewController.m
//  gwlx
//
//  Created by Chan Kevin on 30/7/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "SettingViewController.h"
#import "BaseUser.h"
#import "AboutViewController.h"
#import "AboutContentViewController.h"
#import "SettingCell.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIImageView *imageview_logo;
@property (nonatomic, strong) UILabel *label_version;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UIButton *logout;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[
                           @[
                               @[@"关于我们", @"action_about", @"1"],
                               @[@"隐私政策", @"action_privacy", @"1"],
                               @[@"评分", @"action_review", @"1"],
                            ],
                           
                           @[@[@"v1.0", @"", @"0"]]
  ];
        _array_data = [[NSMutableArray alloc] initWithArray:array];
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
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = [UIColor colorWithHEX:0xe5e5e5];
//        _tableView.tableHeaderView = self.header;
        if ([BASEUSER isLogin]) {
            _tableView.tableFooterView = self.footer;
        }
    }
    return _tableView;
}

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 170)];
        [_header addSubview:self.imageview_logo];
//        [_header addSubview:self.label_version];
    }
    return _header;
}

- (UIImageView *)imageview_logo
{
    if (!_imageview_logo) {
        _imageview_logo = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 70) / 2, 50, 70, 70)];
        _imageview_logo.image = ImageNamed(@"logo_courier");
        _imageview_logo.clipsToBounds = YES;
        _imageview_logo.layer.cornerRadius = 8.f;
    }
    return _imageview_logo;
}

- (UILabel *)label_version
{
    if (!_label_version) {
        _label_version = [[UILabel alloc] initWithFrame:CGRectMake(0, 186, APPScreenWidth, 20)];
        _label_version.font = __font(14);
        _label_version.textAlignment = NSTextAlignmentCenter;
        _label_version.text = @"音湃 © 2020 1.0";
    }
    return _label_version;
}

- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 52)];
        [_footer addSubview:self.logout];
    }
    return _footer;
}

- (UIButton *)logout
{
    if (!_logout) {
        _logout = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth - 20, 48)];
        [_logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logout setTitleColor:__color_white forState:UIControlStateNormal];
        _logout.titleLabel.font = __font(18);
        _logout.layer.backgroundColor = [__color_main CGColor];
        _logout.clipsToBounds = YES;
        _logout.layer.cornerRadius = 24;
        [_logout addTarget:self action:@selector(action_logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logout;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 0.1);
    return [[UIView alloc] initWithFrame:frame];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 10);
    return [[UIView alloc] initWithFrame:frame];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array_data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.array_data objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *array = [[self.array_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([array[2] isEqualToString:@"0"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.label_title.text = [array objectAtIndex:0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *distribution = [[self.array_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][1];
    if (distribution.length > 0) {
        [self performSelector:NSSelectorFromString(distribution) withObject:nil];
    }
}

- (void)action_about
{
    AboutContentViewController *about = [[AboutContentViewController alloc] init];
    about.content_type = @"about";
    about.title = @"关于我们";
    [self.navigationController pushViewController:about animated:YES];
}

- (void)action_privacy
{
    AboutContentViewController *about = [[AboutContentViewController alloc] init];
    about.content_type = @"privacy";
    about.title = @"隐私政策";
    [self.navigationController pushViewController:about animated:YES];
}

- (void)action_support
{
    AboutContentViewController *about = [[AboutContentViewController alloc] init];
    about.content_type = @"support";
    about.title = @"Support";
    [self.navigationController pushViewController:about animated:YES];
}

- (void)action_review
{
    NSString *ITUNES_APP_URL_IOS7 = @"itms-apps://itunes.apple.com/app/id1230104586";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ITUNES_APP_URL_IOS7]];
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

@end
