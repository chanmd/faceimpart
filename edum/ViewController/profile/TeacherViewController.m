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
#import "LoginViewController.h"
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

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
    [self.view addSubview:self.tableView];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -(AdaptNaviHeight + BASE_VIEW_Y), APPScreenWidth, APPScreenHeight - BASE_VIEW_Y - SafeAreaBottomHeight - 49) style:UITableViewStyleGrouped];
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

- (void)setupSetting
{
    UIButton *button_cal = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button_cal setImage:ImageNamed(@"icon_setting") forState:UIControlStateNormal];
//    [button_cal addTarget:self action:@selector(action_setting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button_cal];
    self.navigationItem.rightBarButtonItem = barbutton;
}

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
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 20)];
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
    return [UILabel text:[data stringForKey:@"subtitle"] font:__font(18) width:APPScreenWidth - 30 lineSpacing:5] + 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headviewIdentifier";
    LandingSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!view) {
        view = [[LandingSectionHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        view.frame = CGRectMake(0, 0, APPScreenWidth, SECTION_HEIGHT);
    }
    NSDictionary *data = [self.array_data objectAtIndex:section];
    NSString *string = [data stringForKey:@"title"];
    view.label.text = [NSString stringWithFormat:@"%@", string];
    view.button.hidden = YES;
    view.image_accessory.hidden = YES;
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 0, 10);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = __color_white;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
    [cell.label_text setText:[data stringForKey:@"subtitle"] lineSpacing:5];
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

- (void)action_login
{
    LoginViewController *login = [[LoginViewController alloc] init];
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
                NSDictionary *brief = @{@"title": @"教育背景", @"subtitle": [data stringForKey:@"brief"]};
                [weakSelf.array_data addObject:brief];
            }
            if ([data stringForKey:@"experience"]) {
                NSDictionary *brief = @{@"title": @"经历", @"subtitle": [data stringForKey:@"brief"]};
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
//        [weakSelf.tableView.mj_header endRefreshing];
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
