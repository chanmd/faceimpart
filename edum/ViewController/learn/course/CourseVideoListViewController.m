//
//  CourseVideoListViewController.m
//  edum
//
//  Created by Md Chen on 24/10/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "CourseVideoListViewController.h"
#import "CourseSectionHeaderView.h"
#import "CourseVideoCell.h"
#import "NSDictionary+JSONExtern.h"

@interface CourseVideoListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CourseVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    

    NSString *url = @"https://faceimpart-test.oss-cn-beijing.aliyuncs.com/video/000XxUifgx07P7wnREej01041200iG3E0E010.mp4";//[self.data stringForKey:@"video_url"];
    [self.view addSubview:self.canvas];
    [self.view addSubview:self.tableView];
    [self simData];
    [self.tableView reloadData];
    
}

- (void)simData {
    NSArray *array = @[@{@"cover_image": @"", @"title": @"Hello", @"subtitle": @"jfdslfjdakslfasd"},
                        @{@"cover_image": @"", @"title": @"Hello", @"subtitle": @"jfdslfjdakslfasd"},
                        @{@"cover_image": @"", @"title": @"Hello", @"subtitle": @"jfdslfjdakslfasd"}];
    self.array_data = [NSMutableArray arrayWithArray:array];
    
    NSArray *array_titles = @[@"1", @"2", @"3"];
    self.array_data_titles = [NSMutableArray arrayWithArray:array_titles];
}

- (void)back_action
{
//    [self.playerview addObserver:self forKeyPath:@"isLockScreen" options:(NSKeyValueObservingOptionOld) context:nil];
}

- (void)dealloc
{
    
}

- (UIView *)canvas
{
    if (!_canvas) {
        _canvas = [[UIView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y + 50, APPScreenWidth, APPScreenWidth * 0.75)];
        _canvas.backgroundColor = __color_clear;
    }
    return _canvas;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.canvas.bottom, APPScreenWidth, APPScreenHeight - 55 - SafeAreaBottomHeight - self.canvas.bottom) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_clear;
    }
    return _tableView;
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSMutableArray array];
    }
    return _array_data;
}

- (NSMutableArray *)array_data_titles
{
    if (!_array_data_titles) {
        _array_data_titles = [NSMutableArray array];
    }
    return _array_data_titles;
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array_data_titles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.array_data objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 15)];
    view.backgroundColor = __color_white;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *reuseIdentifier = @"header";
    CourseSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!header) {
        header = [[CourseSectionHeaderView alloc] initWithReuseIdentifier:reuseIdentifier];
    }
    header.button_more.hidden = YES;
    header.label_title.width = APPScreenWidth - 40;
    header.label_title.text = [self.array_data_titles objectAtIndex:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailcell = @"detailcell";
    CourseVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    NSDictionary *data = [[self.array_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell bindVideoData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
