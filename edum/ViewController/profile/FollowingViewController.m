//
//  FollowingViewController.m
//  edum
//
//  Created by Kevin Chan on 27/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "FollowingViewController.h"
#import "FollowingCell.h"

@interface FollowingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;

@end

@implementation FollowingViewController

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
        _tableView.backgroundColor = __color_gray_background;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = __color_gray_separator;
    }
    return _tableView;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
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
    FollowingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[FollowingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    NSArray *array = [self.array_data objectAtIndex:indexPath.row];
    cell.imageview_avatar.image = ImageNamed(@"logo_launch");
    cell.label_name.text = @"张天一";
    cell.label_bio.text = @"小提琴 钢琴 乐理";
    BOOL status = YES;
    if (status) {
        [cell.button_follow setTitle:@"已关注" forState:UIControlStateNormal];
        cell.button_follow.layer.backgroundColor = [__color_gray_background CGColor];
        [cell.button_follow setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
    } else {
        [cell.button_follow setTitle:@"关注" forState:UIControlStateNormal];
        cell.button_follow.layer.backgroundColor = [__color_main CGColor];
        [cell.button_follow setTitleColor:__color_white forState:UIControlStateNormal];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *data = [self.array_data objectAtIndex:indexPath.row];
    
}

@end
