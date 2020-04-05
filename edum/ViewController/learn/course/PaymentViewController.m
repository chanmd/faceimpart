//
//  PaymentViewController.m
//  edum
//
//  Created by Kevin Chan on 28/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentHeader.h"
#import "PaymentCell.h"

#import "TTTAttributedLabel.h"
#import "AboutContentViewController.h"

#import "PaymentDoneController.h"

@interface PaymentViewController () <UITableViewDelegate, UITableViewDataSource, TTTAttributedLabelDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) PaymentHeader *header;
@property (nonatomic, assign) NSInteger payment;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) TTTAttributedLabel *label_privacy;
@property (nonatomic, strong) UIButton *button_commit;


@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程报名";
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundColor = __color_clear;
        _tableView.tableHeaderView = self.header;
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (PaymentHeader *)header
{
    if (!_header) {
        _header = [[PaymentHeader alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 150)];
        [_header bindPaymentHeader:@{}];
    }
    return _header;
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[
            @{@"title":@"微信支付", @"icon":@"wechatpay", @"tag": @"0"},
            @{@"title":@"支付宝", @"icon":@"alipay", @"tag": @"1"}
        ];
        _array_data = [[NSMutableArray alloc] initWithArray:array];
    }
    return _array_data;
}

- (TTTAttributedLabel *)label_privacy
{
    if (!_label_privacy) {
        _label_privacy = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 25, APPScreenWidth, 20)];
        _label_privacy.font = __font(12);
        _label_privacy.textAlignment = NSTextAlignmentCenter;
        NSString *privacy = @"课程购买须知";
        NSString *strAll = [NSString stringWithFormat:@"购买课程即同意%@", privacy];
        NSMutableAttributedString *stringAll = [[NSMutableAttributedString alloc] initWithString:strAll];
        NSRange privacyRange = [strAll rangeOfString:privacy];
        [stringAll addAttribute:NSForegroundColorAttributeName value:__color_font_subtitle range:NSMakeRange(0, strAll.length)];
        [stringAll addAttribute:NSForegroundColorAttributeName value:__color_main range:privacyRange];
        
        NSMutableDictionary *dictAtt = [NSMutableDictionary dictionary];
        [dictAtt setValue:__color_main forKey:(NSString *)kCTForegroundColorAttributeName];
        _label_privacy.attributedText = stringAll;
        _label_privacy.delegate = self;
        [_label_privacy setLinkAttributes:dictAtt];
        [_label_privacy setActiveLinkAttributes:dictAtt];
        [_label_privacy addLinkToURL:[NSURL URLWithString:@"webPrivacy"] withRange:privacyRange];
    }
    return _label_privacy;
}

#pragma mark TTTAttributedLabelDelegate
- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    if ([url.absoluteString isEqualToString:@"webPrivacy"]) {
        [self gotoPrivacy];
    }
}

- (void)gotoPrivacy
{
    AboutContentViewController *privacy = [[AboutContentViewController alloc] init];
    privacy.content_type = @"privacy";
    [self.navigationController pushViewController:privacy animated:YES];
}

- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 138)];
        [_footer addSubview:self.label_privacy];
        [_footer addSubview:self.button_commit];
    }
    return _footer;
}

- (UIButton *)button_commit
{
    if (!_button_commit) {
        _button_commit = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_commit.frame = CGRectMake(30, 85, APPScreenWidth - 60, 44);
        _button_commit.layer.cornerRadius = 22;
        _button_commit.layer.masksToBounds = YES;
        [_button_commit setTitle:@"确认支付" forState:UIControlStateNormal];
        [_button_commit setTitleColor:__color_white forState:UIControlStateNormal];
        _button_commit.layer.backgroundColor = [__color_main CGColor];
        [_button_commit addTarget:self action:@selector(action_commit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_commit;
}

- (void)action_commit
{
    PaymentDoneController *done = [[PaymentDoneController alloc] init];
    NSLog(@"%@", self.course_id);
    [self.navigationController pushViewController:done animated:YES];
}

#pragma mark - tableiview delegate

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
    static NSString *cellIdentifier = @"payment_cell";
    PaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dic = [self.array_data objectAtIndex:indexPath.row];
    [cell bindPaymentCell:dic];
    if (self.payment == indexPath.row) {
        [cell bindPaymentCellButton:1];
    } else {
        [cell bindPaymentCellButton:2];
    }
    [cell.button_select addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)action_button:(UIButton *)button
{
    [button setImage:ImageNamed(@"selectbutton") forState:UIControlStateNormal];
    [button setImage:ImageNamed(@"unselectbutton") forState:UIControlStateHighlighted];
    self.payment = button.tag;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.1)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 15)];
    view.backgroundColor = __color_gray_background;
    return view;
}


@end
