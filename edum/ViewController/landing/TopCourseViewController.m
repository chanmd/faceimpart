//
//  TopCourseViewController.m
//  edum
//
//  Created by Kevin Chan on 5/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "TopCourseViewController.h"
#import "LandingCourseCell.h"

@interface TopCourseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;

@end

@implementation TopCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"关注的老师";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
            @{},
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
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.separatorColor = __color_gray_separator;
    }
    return _tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 10);
    return [[UIView alloc] initWithFrame:frame];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 15);
    return [[UIView alloc] initWithFrame:frame];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

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
    static NSString *cellIdentifier = @"cellIdentifier";
    LandingCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dictionary = [self.array_data objectAtIndex:indexPath.row];
    dictionary = @{@"name": @"非常棒的课程", @"url": @"https://faceimpart-test.oss-cn-beijing.aliyuncs.com/image/banner_1.png"};
    [cell bindElementWithData:dictionary];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LANDING_COURSE_HEIGHT + 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *data = [self.array_data objectAtIndex:indexPath.row];
    
}


@end
