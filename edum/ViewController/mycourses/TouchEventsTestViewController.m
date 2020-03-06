//
//  TouchEventsTestViewController.m
//  edum
//
//  Created by Kevin Chan on 26/5/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "TouchEventsTestViewController.h"
#import "CalHeader.h"
#import "CalCell.h"
#import "NSObject+YYAdditions.h"
#import "NSDictionary+JSONExtern.h"

#define LABEL_WIDTH APPScreenWidth / 7
#define LABEL_Y 100
#define LABLE_HEIGHT 40
#define HEADER_HEIGHT 40
#define CELL_HEIGHT 44

@interface TouchEventsTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, assign) BOOL select_all_flag;

@end

@implementation TouchEventsTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    UIBarButtonItem *eventItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(action_select_all)];
    [eventItem setTitleTextAttributes:@{NSForegroundColorAttributeName:__color_main} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[eventItem];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 8; i <= 20; i ++) {
            NSDictionary *dict = @{@"clock": [NSString stringWithFormat:@"%d:00", i], @"available": @[@"0", @"0", @"0", @"0", @"0", @"0", @"0"]};
            [array addObject:dict];
        }
        _array_data = [NSMutableArray arrayWithArray:array];
    }
    return _array_data;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundColor = __color_white;
    }
    return _tableView;
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
    return HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CalHeader *header = [[CalHeader alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, HEADER_HEIGHT)];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.5)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"rowcell";
    CalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    NSDictionary *dict = [self.array_data objectAtIndex:indexPath.row];
    cell.label_time.text = [dict stringForKey:@"clock"];
    NSArray *array = [dict arrayForKey:@"available"];
    cell.button_a.tag = [array[0] integerValue];
    cell.button_b.tag = [array[1] integerValue];
    cell.button_c.tag = [array[2] integerValue];
    cell.button_d.tag = [array[3] integerValue];
    cell.button_e.tag = [array[4] integerValue];
    cell.button_f.tag = [array[5] integerValue];
    cell.button_g.tag = [array[6] integerValue];
    
    [self init_button_style:cell.button_a];
    [self init_button_style:cell.button_b];
    [self init_button_style:cell.button_c];
    [self init_button_style:cell.button_d];
    [self init_button_style:cell.button_e];
    [self init_button_style:cell.button_f];
    [self init_button_style:cell.button_g];
    
    NSArray *array_a = @[@(indexPath.row), @(0), array[0]];
    NSArray *array_b = @[@(indexPath.row), @(1), array[1]];
    NSArray *array_c = @[@(indexPath.row), @(2), array[2]];
    NSArray *array_d = @[@(indexPath.row), @(3), array[3]];
    NSArray *array_e = @[@(indexPath.row), @(4), array[4]];
    NSArray *array_f = @[@(indexPath.row), @(5), array[5]];
    NSArray *array_g = @[@(indexPath.row), @(6), array[6]];
    DYY_setYYUserInfo(cell.button_a, array_a);
    DYY_setYYUserInfo(cell.button_b, array_b);
    DYY_setYYUserInfo(cell.button_c, array_c);
    DYY_setYYUserInfo(cell.button_d, array_d);
    DYY_setYYUserInfo(cell.button_e, array_e);
    DYY_setYYUserInfo(cell.button_f, array_f);
    DYY_setYYUserInfo(cell.button_g, array_g);
    [cell.button_a addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button_b addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button_c addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button_d addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button_e addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button_f addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [cell.button_g addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)action_button:(UIButton *)button
{
    NSArray *array = DYY_getYYUserInfo(button);
    NSInteger row = [array[0] integerValue];
    NSInteger index = [array[1] integerValue];
    NSInteger selectedStatus = [array[2] integerValue];
    if (selectedStatus == 0) {
        selectedStatus = 1;
        button.layer.backgroundColor = [__color_main CGColor];
        [button setTitle:@"已选" forState:UIControlStateNormal];
        [button setTitleColor:__color_white forState:UIControlStateNormal];
    } else {
        
        button.layer.backgroundColor = [__color_clear CGColor];
        [button setTitle:@"+" forState:UIControlStateNormal];
        [button setTitleColor:__color_gray_background forState:UIControlStateNormal];
        selectedStatus = 0;
    }
    NSMutableDictionary *data_dict = [NSMutableDictionary dictionaryWithDictionary:[self.array_data objectAtIndex:row]];
    NSMutableArray *available_array = [NSMutableArray arrayWithArray:(NSArray *)[data_dict arrayForKey:@"available"]];
    [available_array replaceObjectAtIndex:index withObject:@(selectedStatus)];
    [data_dict setObject:available_array forKey:@"available"];
    [self.array_data replaceObjectAtIndex:row withObject:data_dict];
    
    NSArray *array_new = @[array[0], array[1], @(selectedStatus)];
    DYY_setYYUserInfo(button, array_new);
}

- (void)init_button_style:(UIButton *)button
{
    NSInteger selectedStatus = button.tag;
    if (selectedStatus == 1) {
        button.layer.backgroundColor = [__color_main CGColor];
        [button setTitle:@"已选" forState:UIControlStateNormal];
        [button setTitleColor:__color_white forState:UIControlStateNormal];
    } else {
        
        button.layer.backgroundColor = [__color_clear CGColor];
        [button setTitle:@"+" forState:UIControlStateNormal];
        [button setTitleColor:__color_gray_background forState:UIControlStateNormal];
    }
}

- (void)action_select_all
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 8, j = 0; i <= 20; i ++, j ++) {
        NSDictionary *dict = @{@"index": @(j), @"clock": [NSString stringWithFormat:@"%d:00", i], @"available": @[@"1", @"1", @"1", @"1", @"1", @"1", @"1"]};
        [array addObject:dict];
    }
    self.array_data = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    
    UIBarButtonItem *eventItem = [[UIBarButtonItem alloc] initWithTitle:@"全不选" style:UIBarButtonItemStylePlain target:self action:@selector(action_select_none)];
    [eventItem setTitleTextAttributes:@{NSForegroundColorAttributeName:__color_main} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[eventItem];
    
}

- (void)action_select_none
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 8, j = 0; i <= 20; i ++, j ++) {
        NSDictionary *dict = @{@"index": @(j), @"clock": [NSString stringWithFormat:@"%d:00", i], @"available": @[@"0", @"0", @"0", @"0", @"0", @"0", @"0"]};
        [array addObject:dict];
    }
    self.array_data = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    
    UIBarButtonItem *eventItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(action_select_all)];
    [eventItem setTitleTextAttributes:@{NSForegroundColorAttributeName:__color_main} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[eventItem];
}

@end
