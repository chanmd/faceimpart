//
//  AllCoursesViewController.m
//  edum
//
//  Created by Kevin Chan on 3/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "AllCoursesViewController.h"
#import "DailyScheduleCell.h"

@interface AllCoursesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation AllCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.emptyView];
}

-(UIView *)emptyView
{
    if (!_emptyView)
    {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenWidthHalf + 222, self.tableView.width, 150)];
        _emptyView.backgroundColor = self.view.backgroundColor;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((_emptyView.width - 155) / 2.0, 0, 155, 109)];
        img.image = ImageNamed(@"empty");
        [_emptyView addSubview:img];
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(15, img.bottom + 10, self.view.width - 30, 18)];
        tips.backgroundColor = self.view.backgroundColor;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = __font(16);
        tips.textColor = __color_gray_separator;
        tips.text = @"没有课程";
        [_emptyView addSubview:tips];
        _emptyView.hidden = YES;
    }
    return _emptyView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_gray_background;
    }
    return _tableView;
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WEEKLY_CELL_HEIGHT + 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView _articleCellForRowAtIndexPath:indexPath];
}

- (DailyScheduleCell *)tableView:(UITableView *)tableView _articleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"daily_cell";
    DailyScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DailyScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *daily = [self.array_data objectAtIndex:indexPath.row];
    [cell bindDailyData:daily];
    return cell;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
}

- (void)simulate_data
{
    NSArray * array  = @[
            @{
                @"id": @"13",
                @"title": @"大提琴基础练习大提琴基础练习",
                @"time": @"10:00 - 11:00",
                @"status": @"3",
              },
            @{
              @"id": @"13",
              @"title": @"大提琴基础练习大提琴基础练习",
              @"time": @"12:00 - 13:00",
              @"status": @"2",
            },
            @{
              @"id": @"13",
              @"title": @"大提琴基础练习大提琴基础练习",
              @"time": @"15:00 - 16:00",
              @"status": @"1",
            },
    ];
    
    self.array_data = [[NSMutableArray alloc] initWithArray:array];
}


@end
