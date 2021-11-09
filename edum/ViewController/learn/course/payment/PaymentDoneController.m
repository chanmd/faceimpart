//
//  PaymentDoneController.m
//  edum
//
//  Created by Kevin Chan on 3/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "PaymentDoneController.h"

@interface PaymentDoneController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIImageView *imageview_done;
@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UIButton *button_course;
@property (nonatomic, strong) UIButton *button_landing;


@end

@implementation PaymentDoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_clear;
        _tableView.tableHeaderView = self.header;
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 180)];
        [_header addSubview:self.imageview_done];
        [_header addSubview:self.label_title];
    }
    return _header;
}

- (UIImageView *)imageview_done
{
    if (!_imageview_done) {
        _imageview_done = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 55) / 2, 55, 55, 55)];
        _imageview_done.image = ImageNamed(@"done");
    }
    return _imageview_done;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, APPScreenWidth, 25)];
        _label_title.font = __fontbold(20);
        _label_title.textColor = __color_black;
        _label_title.text = @"课程支付成功";
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    return _label_title;
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSMutableArray array];
    }
    return _array_data;
}

- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 200)];
        [_footer addSubview:self.button_course];
        [_footer addSubview:self.button_landing];
    }
    return _footer;
}

- (UIButton *)button_landing
{
    if (!_button_landing) {
        _button_landing = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_landing.frame = CGRectMake(30, 50, APPScreenWidth - 60, 44);
        _button_landing.layer.cornerRadius = 22;
        _button_landing.layer.masksToBounds = YES;
        _button_landing.titleLabel.font = __font(18);
        [_button_landing setTitle:@"查看课程" forState:UIControlStateNormal];
        [_button_landing setTitleColor:__color_font_subtitle forState:UIControlStateNormal];
        _button_landing.layer.borderColor = [__color_gray_separator CGColor];
        _button_landing.layer.borderWidth = 1.f;
        [_button_landing addTarget:self action:@selector(action_course) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_landing;
}

- (UIButton *)button_course
{
    if (!_button_course) {
        _button_course = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_course.frame = CGRectMake(30, 140, APPScreenWidth - 60, 44);
        _button_course.layer.cornerRadius = 22;
        _button_course.layer.masksToBounds = YES;
        _button_course.titleLabel.font = __font(18);
        [_button_course setTitle:@"返回首页" forState:UIControlStateNormal];
        [_button_course setTitleColor:__color_font_subtitle forState:UIControlStateNormal];
        _button_course.layer.borderColor = [__color_gray_separator CGColor];
        _button_course.layer.borderWidth = 1.f;
        [_button_course addTarget:self action:@selector(action_landing) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_course;
}

- (void)action_landing
{
    NSLog(@"%@", @"back to lading page");
}

- (void)action_course
{
    NSLog(@"%@", @"course list");
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.1)];
    view.backgroundColor = __color_clear;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.1)];
    view.backgroundColor = __color_clear;
    return view;
}

@end
