//
//  SearchCourseViewController.m
//  edum
//
//  Created by Md Chen on 28/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "SearchCourseViewController.h"
#import "CourseRectangleCell.h"

@interface SearchCourseViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *button_cancel;

@property (nonatomic, strong) UIView *view_empty;
@property (nonatomic, strong) UILabel *label_empty;
@property (nonatomic, strong) UILabel *label_count;

@end

@implementation SearchCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self search_view]];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.view_empty];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange) name: UITextFieldTextDidChangeNotification object:nil];
}

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:
                           CGRectMake(30, 0, APPScreenWidth - 40 - 60, 29)];
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"搜索股票/组合/主题" attributes:@{NSForegroundColorAttributeName : [[TKHqSkin instance]getSkinColor:@"PRICE_TOP_SEARCH_PLACEHOLDER"], NSFontAttributeName : [UIFont systemFontOfSize:14.0f ]}];
//        _searchTextField.attributedPlaceholder = placeholderString;
        _searchTextField.placeholder = @"想学什么乐器，一搜即可！";
        _searchTextField.font = __font(14);
        _searchTextField.textColor = __color_font_title;
        _searchTextField.userInteractionEnabled = YES;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.delegate = self;
        [_searchTextField setTintColor:[UIColor colorWithHEX:0x007dff]];
        [_searchTextField becomeFirstResponder];
    }
    return _searchTextField;
}

- (UIButton *)button_cancel
{
    if (!_button_cancel) {
        _button_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_cancel.frame = CGRectMake(APPScreenWidth - 60, 0, 60, 30);
        [_button_cancel setTitle:@"取消" forState:UIControlStateNormal];
        _button_cancel.titleLabel.font = __font(14);
        [_button_cancel setTitleColor:__color_main forState:UIControlStateNormal];
        [_button_cancel addTarget:self action:@selector(action_cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_cancel;
}

- (UIView *)view_empty
{
    if (!_view_empty) {
        _view_empty = [[UIView alloc] initWithFrame:CGRectMake(0, 95, APPScreenWidth, 100)];
        [_view_empty addSubview:self.label_empty];
        _view_empty.hidden = YES;
    }
    return _view_empty;
}

- (UILabel *)label_empty
{
    if (!_label_empty) {
        _label_empty = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, APPScreenWidth - 20, 30)];
        _label_empty.text = @"未搜到任何课程，换个词试试？";
        _label_empty.textColor = __color_font_placeholder;
        _label_empty.textAlignment = NSTextAlignmentLeft;
        _label_empty.font = __font(16);
    }
    return _label_empty;
}

- (UILabel *)label_count
{
    if (!_label_count) {
        _label_count = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth - 20, 24)];
        _label_count.textColor = __color_font_subtitle;
        _label_count.textAlignment = NSTextAlignmentLeft;
        _label_count.font = __font(14);
    }
    return _label_count;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)action_cancel
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (UIView *)search_view
{
    UIView *topSearchContain = [[UIView alloc] initWithFrame:CGRectMake(0, 50, APPScreenWidth, 30)];
    
    //顶部搜索框容器
    UIView *topSearch = [[UIView alloc] initWithFrame:CGRectMake(10, 0, APPScreenWidth - 70, 30)];
    topSearch.backgroundColor = [UIColor colorWithHEX:0xf1f1f1];
    topSearch.clipsToBounds = YES;
    topSearch.layer.cornerRadius = CORNERRADIUS;
    
    //搜索图片
    UIImageView *searchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_search"]];
    searchView.frame = CGRectMake(10, 8, 15, 15);
    [topSearch addSubview:searchView];
    searchView.userInteractionEnabled = YES;
    
    //添加输入框
    [topSearch addSubview:self.searchTextField];
    [topSearchContain addSubview:self.button_cancel];
    [topSearchContain addSubview:topSearch];
    return topSearchContain;
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, APPScreenWidth, APPScreenHeight - 65) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
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
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return COURSE_LIST_HEIGHT + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view_head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 34)];
    [view_head addSubview:self.label_count];
    return view_head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseRectangleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rowcell"];
    if (!cell) {
        cell = [[CourseRectangleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rowcell"];
    }
    NSDictionary *course = [self.array_data objectAtIndex:indexPath.row];
    [cell bindData:course];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)textFieldChange
{
    if (self.searchTextField.text.length == 0) {
        self.view_empty.hidden = YES;
        [self.array_data removeAllObjects];
        [self.tableview reloadData];
        return;
    }
    NSDictionary *params = @{@"keyword": self.searchTextField.text};
    WeakSelf;
    [AFR requestWithUrl:REQUEST_COURSE_SEARCH
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:params]
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        [weakSelf.array_data removeAllObjects];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSArray *data = [tempDic arrayForKey:@"data"];
            weakSelf.array_data = [NSMutableArray arrayWithArray:data];
            [weakSelf.tableview reloadData];
            weakSelf.view_empty.hidden = YES;
            weakSelf.label_count.text = [NSString stringWithFormat:@"共查到 %ld 条结果", weakSelf.array_data.count];
            
        } else {
            [weakSelf.tableview reloadData];
            weakSelf.view_empty.hidden = NO;
            weakSelf.label_count.text = @"";
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}


@end
