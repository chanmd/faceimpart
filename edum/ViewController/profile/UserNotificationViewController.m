//
//  UserNotificationViewController.m
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "UserNotificationViewController.h"
#import "UserNotificationCell.h"
#import "UILabel+LineSpace.h"

@interface UserNotificationViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSDateFormatter *df;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic,strong) UIView *noMessageView;

@end

@implementation UserNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    // Do any additional setup after loading the view.
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = __color_gray_background;
    [self sim_data];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    [self.view addSubview:self.noMessageView];
    self.noMessageView.hidden = YES;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPScreenHeight - BASE_TABLEVIEW_Y) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)setupView
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.tableView.tableHeaderView = [[UIView alloc] init];
    
    for (UIGestureRecognizer *gesture in self.tableView.gestureRecognizers)
    {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]])
        {
            [self.tableView removeGestureRecognizer:gesture];
        }
    }
}

-(UIView *)noMessageView
{
    if (!_noMessageView)
    {
        _noMessageView = [[UIView alloc] initWithFrame:self.tableView.frame];
        
        UIImageView *empty = [[UIImageView alloc] initWithFrame:CGRectMake((APPScreenWidth - 155) / 2.0, 120, 155, 109)];
        empty.image = ImageNamed(@"empty");
        [_noMessageView addSubview:empty];
        
        UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, empty.bottom + 15, APPScreenWidth, 30)];
        tips.backgroundColor = __color_clear;
        tips.textAlignment = NSTextAlignmentCenter;
        tips.font = __font(18);
        tips.textColor = __color_font_subtitle;
        tips.text = @"还没有消息";
        [_noMessageView addSubview:tips];
    }
    return _noMessageView;
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
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = [self.array_data objectAtIndex:indexPath.row];
    CGFloat height = [UILabel text:[message stringForKey:@"subtitle"] font:__fontthin(16) width:APPScreenWidth - 40 lineSpacing:5];
    return height + 70 + 10 + 30 + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TKSystemChatCell";
    UserNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UserNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = self.view.backgroundColor;
    }
    
    NSDictionary *message = [self.array_data objectAtIndex:indexPath.row];
    [cell bindUserNotification:message];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)sim_data
{
    NSArray *array = @[
        @{@"title": @"你的卡券即将过期",
          @"subtitle": @"你的听课券将在10天后到期，别忘记使用哦。",
          @"time": @"2020-12-20 11:20:21"
        },
        @{@"title": @"你的卡券即将过期",
          @"subtitle": @"你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。",
          @"time": @"2020-12-20 11:20:21"
        },
        @{@"title": @"你的卡券即将过期",
          @"subtitle": @"你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。",
          @"time": @"2020-12-20 11:20:21"
        },
        @{@"title": @"你的卡券即将过期",
          @"subtitle": @"你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。",
          @"time": @"2020-12-20 11:20:21"
        },
        @{@"title": @"你的卡券即将过期",
          @"subtitle": @"你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。你的听课券将在10天后到期，别忘记使用哦。",
          @"time": @"2020-12-20 11:20:21"
        },
        @{@"title": @"你的卡券即将过期",
          @"subtitle": @"你的听课券将在10天后到期，别忘记使用哦。",
          @"time": @"2020-12-20 11:20:21"
        }
    ];
    self.array_data = [NSMutableArray arrayWithArray:array];
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
