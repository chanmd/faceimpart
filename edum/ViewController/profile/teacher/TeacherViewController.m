//
//  TeacherViewController.m
//  edum
//
//  Created by Kevin Chan on 27/5/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "TeacherViewController.h"

#import "ProfileHeadCell.h"
#import "ProfileHeaderView.h"
#import "BaseUser.h"
#import "BTKeychain.h"
#import "LoginOverseaViewController.h"
#import "TeacherCalendarViewController.h"
#import "AvatarView.h"
#import "LandingSectionHeaderView.h"
#import "PlainTextCell.h"
#import "UILabel+LineSpace.h"

#define SECTION_HEIGHT 60

@interface TeacherViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) NSMutableDictionary *dictionary_teacher;
@property (nonatomic, strong) AvatarView *header;
@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UIButton *button_dismiss;
@property (nonatomic, strong) UIButton *button_calendar;


@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
    [self.view insertSubview:self.tableView atIndex:99];
    [self.view insertSubview:self.button_calendar atIndex:100];
    [self fetch_user];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    [MobClick beginLogPageView:@"profile"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [MobClick endLogPageView:@"profile"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -50, APPScreenWidth, APPScreenHeight - BASE_VIEW_Y - AdaptNaviHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.separatorColor = __color_gray_separator;
        _tableView.tableFooterView = self.footer;
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}

//- (UIButton *)button_calendar
//{
//    if (!_button_calendar) {
//        _button_calendar = [UIButton buttonWithType:UIButtonTypeCustom];
//        _button_calendar.frame = CGRectMake((APPScreenWidth - 150) / 2, APPScreenHeight - 65, 150, 44);
//        _button_calendar.layer.cornerRadius = 22;
//        _button_calendar.layer.masksToBounds = YES;
//        [_button_calendar setTitle:@"预约上课" forState:UIControlStateNormal];
//        [_button_calendar addTarget:self action:@selector(action_calendar) forControlEvents:UIControlEventTouchUpInside];
//        [_button_calendar setTitleColor:__color_white forState:UIControlStateNormal];
//        _button_calendar.layer.backgroundColor = [__color_main CGColor];
//    }
//    return _button_calendar;
//}

- (AvatarView *)header
{
    if (!_header) {
        _header = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidth / 2)];
        [_header.button addTarget:self action:@selector(action_avatar) forControlEvents:UIControlEventTouchUpInside];
        [_header addSubview:self.button_dismiss];
    }
    return _header;
}

- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 60)];
    }
    return _footer;
}


#pragma mark - tableiview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array_data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = [self.array_data objectAtIndex:indexPath.section];
    NSString *ori_text = [data stringForKey:@"subtitle"];
    NSString *text = [ori_text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    return [UILabel text:text font:__font(16) width:APPScreenWidth - 30 lineSpacing:5] + 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 44)];
    view.backgroundColor = __color_white;
    
    NSDictionary *data = [self.array_data objectAtIndex:section];
    NSString *string = [data stringForKey:@"title"];
    
    UILabel *title_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, APPScreenWidth - 30, 44)];
    title_label.font = __fontmedium(16);
    title_label.textColor = __color_font_title;
    title_label.text = string;
    [view addSubview:title_label];
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 0.1);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = __color_white;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"main_cell";
    PlainTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PlainTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *data = [self.array_data objectAtIndex:indexPath.section];
    cell.label_text.width = APPScreenWidth - 30;
    NSString *ori_text = [data stringForKey:@"subtitle"];
    NSString *text = [ori_text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    [cell.label_text setText:text lineSpacing:5];
    [cell.label_text sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSMutableArray array];
    }
    return _array_data;
}

- (UIButton *)button_dismiss
{
    if (!_button_dismiss) {
        _button_dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_dismiss.frame = CGRectMake(20, BASE_VIEW_Y + 20, 24, 24);
        [_button_dismiss setImage:ImageNamed(@"back_arrow") forState:UIControlStateNormal];
        [_button_dismiss addTarget:self action:@selector(action_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_dismiss;
}

#pragma mark - actions

- (void)action_dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)action_avatar
{
    
}

- (void)action_calendar
{
    TeacherCalendarViewController *calendar = [[TeacherCalendarViewController alloc] init];
    [self.navigationController pushViewController:calendar animated:YES];
}

- (void)action_login
{
    LoginOverseaViewController *login = [[LoginOverseaViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
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

#pragma mark - network

- (void)fetch_user
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"user_id": self.user_id}];
    WeakSelf;
    [AFR requestWithUrl:REQUEST_TEACHER
             httpmethod:@"POST"
                 params:params
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
//        [weakSelf.tableView.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            
            NSDictionary *user = [data dictionaryForKey:@"user"];
            [weakSelf bindHeadview:user];
            
            if ([data stringForKey:@"brief"]) {
                NSDictionary *brief = @{@"title": @"简介", @"subtitle": [data stringForKey:@"brief"]};
                [weakSelf.array_data addObject:brief];
            }
            if ([data stringForKey:@"education"]) {
                NSDictionary *brief = @{@"title": @"教育背景", @"subtitle": [data stringForKey:@"education"]};
                [weakSelf.array_data addObject:brief];
            }
            if ([data stringForKey:@"experience"]) {
                NSDictionary *brief = @{@"title": @"经历", @"subtitle": [data stringForKey:@"experience"]};
                [weakSelf.array_data addObject:brief];
            }
            if ([weakSelf.array_data count] == 0) {
                NSString *bio = [user stringForKey:@"bio"];
                if (bio.length == 0) {
                    bio = @"什么也没有~";
                }
                NSDictionary *brief = @{@"title": @"简介", @"subtitle": bio};
                [weakSelf.array_data addObject:brief];
            }
            [weakSelf.tableView reloadData];
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}

- (void)bindHeadview:(NSDictionary *)user
{
    NSString *avatar_url = [user stringForKey:@"avatar"];
    WeakSelf;
    [self.header.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:avatar_url] placeholderImage:ImageNamed(@"logo_launch") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            weakSelf.header.imageview_avatar.image = ImageNamed(@"logo_launch");
        } else {
            weakSelf.header.imageview_avatar.image = image;
        }
        weakSelf.tableView.tableHeaderView = weakSelf.header;
        [weakSelf.tableView reloadData];
    }];
    self.header.imageview_avatar.hidden = NO;
    self.header.view_avatar.hidden = NO;
    if ([user stringForKey:@"name"]) {
        self.header.label_name.text = [user stringForKey:@"name"];
    } else {
        self.header.label_name.text = @"名字";
    }
    
    self.header.label_name.hidden = NO;
    self.tableView.tableHeaderView = self.header;
    [self.tableView reloadData];
    
}

@end
