//
//  TransferTTTTViewController.m
//  edum
//
//  Created by Md Chen on 22/6/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "TransferTTTTViewController.h"
#import "BaseUser.h"
#import "AboutViewController.h"
#import "AboutContentViewController.h"
#import "SettingCell.h"

@interface TransferTTTTViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIImageView *imageview_back;
@property (nonatomic, strong) UIImageView *imageview_callcenter;
@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) UIImageView *imageview_output;
@property (nonatomic, strong) UILabel *label_output;
@property (nonatomic, strong) UILabel *label_amount;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UIButton *logout;

@end

@implementation TransferTTTTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_gray_background;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[
                           @[
                               @[@"对方账户", @"安徽宜博项目数据分析师事务所有", @"action_about", @"1"],
                               @[@"", @"限公司", @"action_about", @"1"],
                               @[@"", @"中国工商银行", @"action_about", @"1"],
                               @[@"", @"1302010909200137730", @"action_about", @"1"],
                               @[@"摘要", @"合同尾款", @"action_about", @"1"],
                               @[@"交易账户", @"6217 **** **** 2678", @"action_about", @"1"],
                               @[@"币种", @"人民币", @"action_about", @"1"],
                               @[@"余额", @"141900.22", @"action_about", @"1"],
                               @[@"交易时间", @"2021-05-06 19:11:54", @"action_about", @"1"],
                               @[@"交易流水", @"PWAP9697028735457001473", @"action_about", @"1"],
//                               @[@"", @"510101000", @"action_about", @"1"],
                               @[@"交易报文号", @"--", @"action_about", @"1"],
                            ]
  ];
        _array_data = [[NSMutableArray alloc] initWithArray:array];
    }
    return _array_data;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -48, APPScreenWidth, APPFullScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_gray_background;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.separatorColor = [UIColor colorWithHEX:0xe5e5e5];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.header;
        
    }
    return _tableView;
}

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 210)];
        _header.backgroundColor = __color_white;
        [_header addSubview:self.imageview_back];
        [_header addSubview:self.label_title];
        [_header addSubview:self.imageview_callcenter];
        [_header addSubview:self.imageview_output];
        [_header addSubview:self.label_output];
        [_header addSubview:self.label_amount];
    }
    return _header;
}

- (UIImageView *)imageview_back
{
    if (!_imageview_back) {
        _imageview_back = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12 + 44, 22, 22)];
        _imageview_back.image = ImageNamed(@"t_back");
        _imageview_back.clipsToBounds = YES;
    }
    return _imageview_back;
}


- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 7 + 44, APPScreenWidth, 30)];
        _label_title.font = __fontbold(18);
        _label_title.textAlignment = NSTextAlignmentCenter;
        _label_title.text = @"交易详情";
    }
    return _label_title;
}

- (UIImageView *)imageview_callcenter
{
    if (!_imageview_callcenter) {
        _imageview_callcenter = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 30 - 15, 10 + 44, 26, 26)];
        _imageview_callcenter.image = ImageNamed(@"t_callcenter");
    }
    return _imageview_callcenter;
}
    
- (UILabel *)label_output
{
    if (!_label_output) {
        _label_output = [[UILabel alloc] initWithFrame:CGRectMake(45, 13 + 44 + 40, 200, 22)];
        _label_output.font = __font(14);
        _label_output.text = @"支出";
    }
    return _label_output;
}

- (UIImageView *)imageview_output
{
    if (!_imageview_output) {
        _imageview_output = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13 + 44 + 40, 22, 22)];
        _imageview_output.image = ImageNamed(@"t_output");
    }
    return _imageview_output;
}

- (UILabel *)label_amount
{
    if (!_label_amount) {
        _label_amount = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + 44 + 40 + 40 + 10, APPScreenWidth, 36)];
        _label_amount.font = __font(34);
        _label_amount.textAlignment = NSTextAlignmentCenter;
        _label_amount.text = @"¥ 20300.00";
    }
    return _label_amount;
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
    if (indexPath.row == 1) {
        cell.label_middle.hidden = NO;
        cell.label_left.hidden = YES;
        cell.label_right.hidden = YES;
        cell.label_middle.text = [array objectAtIndex:1];
    } else {
        cell.label_middle.hidden = YES;
        cell.label_left.hidden = NO;
        cell.label_right.hidden = NO;
        cell.label_left.text = [array objectAtIndex:0];
        cell.label_right.text = [array objectAtIndex:1];
    }
    if (indexPath.row == 4) {
        cell.view_line.hidden = NO;
    } else {
        cell.view_line.hidden = YES;
    }
    if (indexPath.row == 5) {
        cell.imageview_bank.hidden = NO;
    } else {
        cell.imageview_bank.hidden = YES;
    }
    
//    cell.label_right.width = APPScreenWidth - 30;
//    [cell.label_right sizeToFit];
//    cell.label_right.textAlignment = NSTextAlignmentRight;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 20;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *distribution = [[self.array_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][2];
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
