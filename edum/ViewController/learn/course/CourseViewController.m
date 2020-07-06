//
//  CourseViewController.m
//  edum
//
//  Created by Kevin Chan on 26/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseViewController.h"
#import "LoginViewController.h"

#pragma utils
#import "NSDictionary+JSONExtern.h"
#import "UILabel+LineSpace.h"
#import "UIImageEffects.h"
#import "HMSegmentedControl.h"

#pragma cells
#import "CourseHeaderView.h"
#import "CourseBriefCell.h"
#import "CourseSectionTopHeader.h"
#import "CourseSectionHeaderView.h"
#import "CourseContentCell.h"
#import "CourseSectionCell.h"
#import "CourseBriefDetailViewController.h"
#import "PaymentViewController.h"
#import "AppointmentViewController.h"
#import <WebKit/WebKit.h>

#define NAVBAR_CHANGE_POINT 50
#define PADDING_OFFSET_X -50


@interface CourseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dict_course;
@property (nonatomic, strong) NSMutableArray *array_data_content;
@property (nonatomic, assign) CGFloat content_height;

@property (nonatomic, strong) CourseHeaderView *header;
@property (nonatomic, strong) UIView *briefview;
@property (nonatomic, strong) UILabel *label_brief;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIView *view_border;
@property (nonatomic, strong) UIView *view_buy;
@property (nonatomic, strong) UILabel *label_price;
@property (nonatomic, strong) UILabel *label_price_fake;
@property (nonatomic, strong) UIButton *button_buy;
@property (nonatomic, strong) UIView *view_arrange;
@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UIButton *button_arrangement;

@end

@implementation CourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"课程";
    [self.view addSubview:self.tableView];
    self.content_height = 200;//内容来自html，默认给200的高度
    self.selectedIndex = 0;
    [self.tableView reloadData];
    [self.header.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.view_border];
    [self.view addSubview:self.view_buy];
    [self.view addSubview:self.view_arrange];
    [self action_course_detail];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight - 49 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_clear;
    }
    return _tableView;
}

- (CourseHeaderView *)header
{
    if (!_header) {
        _header = [[CourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 184 + 44)];
    }
    return _header;
}

- (UIView *)briefview
{
    if (!_briefview) {
        _briefview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 44)];
        [_briefview addSubview:self.label_brief];
    }
    return _briefview;
}

- (UILabel *)label_brief
{
    if (!_label_brief) {
        _label_brief = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, APPScreenWidth - 30, 20)];
        _label_brief.font = __fontthin(16);
        _label_brief.textColor = __color_font_title;
    }
    return _label_brief;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 49 - SafeAreaBottomHeight - 0.5, APPScreenWidth, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}

- (UIView *)view_buy
{
    if (!_view_buy) {
        _view_buy = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 55 - SafeAreaBottomHeight, APPScreenWidth, 55 + SafeAreaBottomHeight)];
        _view_buy.backgroundColor = __color_white;
        [_view_buy addSubview:self.label_price];
        [_view_buy addSubview:self.label_price_fake];
        [_view_buy addSubview:self.button_buy];
    }
    return _view_buy;
}

- (UILabel *)label_price
{
    if (!_label_price) {
        _label_price = [[UILabel alloc] initWithFrame:CGRectMake(30, 16, 120, 36)];
        _label_price.textColor = __color_main;
        _label_price.font = __font(24);
    }
    return _label_price;
}


- (UILabel *)label_price_fake
{
    if (!_label_price_fake) {
        _label_price_fake = [[UILabel alloc] initWithFrame:CGRectMake(30, 16, 120, 36)];
        _label_price_fake.textColor = __color_font_subtitle;
        _label_price_fake.font = __font(18);
    }
    return _label_price_fake;
}


- (UIButton *)button_buy
{
    if (!_button_buy) {
        _button_buy = [[UIButton alloc] initWithFrame:CGRectMake(APPScreenWidth - 15 - 120, 16, 120, 36)];
        [_button_buy setTitle:@"购买" forState:UIControlStateNormal];
        _button_buy.layer.masksToBounds = YES;
        _button_buy.layer.backgroundColor = [__color_main CGColor];
        _button_buy.layer.cornerRadius = 18.f;
        [_button_buy setTitleColor:__color_white forState:UIControlStateNormal];
        [_button_buy addTarget:self action:@selector(action_buy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_buy;
}

- (UIView *)view_arrange
{
    if (!_view_arrange) {
        _view_arrange = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 55 - SafeAreaBottomHeight, APPScreenWidth, 55 + SafeAreaBottomHeight)];
        _view_arrange.backgroundColor = __color_white;
        [_view_arrange addSubview:self.label_status];
        [_view_arrange addSubview:self.button_arrangement];
        _view_arrange.hidden = YES;
    }
    return _view_arrange;
}

- (UILabel *)label_status
{
    if (!_label_status) {
        _label_status = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, APPScreenWidth - 15 - 120, 36)];
        _label_status.textColor = __color_font_subtitle;
        _label_status.font = __font(18);
        _label_status.textAlignment = NSTextAlignmentCenter;
        _label_status.text = @"已购买";
    }
    return _label_status;
}

- (UIButton *)button_arrangement
{
    if (!_button_arrangement) {
        _button_arrangement = [[UIButton alloc] initWithFrame:CGRectMake(APPScreenWidth - 15 - 120, 16, 120, 36)];
        [_button_arrangement setTitle:@"约课" forState:UIControlStateNormal];
        _button_arrangement.layer.masksToBounds = YES;
        _button_arrangement.layer.backgroundColor = [__color_main CGColor];
        _button_arrangement.layer.cornerRadius = 18.f;
        [_button_arrangement setTitleColor:__color_white forState:UIControlStateNormal];
        [_button_arrangement addTarget:self action:@selector(action_arrangement) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_arrangement;
}

- (void)action_arrangement
{
    AppointmentViewController *appointment = [[AppointmentViewController alloc] init];
    [self.navigationController pushViewController:appointment animated:YES];
}


- (void)action_goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    //    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    [MobClick beginLogPageView:@"sight"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    [self.navigationController.navigationBar lt_reset];
    
    
    //    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:__color_gray_separator]];
    //    [MobClick endLogPageView:@"sight"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)dict_course
{
    if (!_dict_course) {
        _dict_course = [NSMutableDictionary dictionary];
    }
    return _dict_course;
}

- (NSMutableArray *)array_data_content
{
    if (!_array_data_content) {
        _array_data_content = [NSMutableArray array];
    }
    return _array_data_content;
}

#pragma mark - scrolling view

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
//        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//        self.view_navigationbar.alpha = alpha;
    } else {
//        self.view_navigationbar.alpha = 0;
    }
}

- (void)segmentedControlChangedValue
{
    self.selectedIndex = self.header.segmentedControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

#pragma mark - tableiview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.selectedIndex == 1) {
        
        return [self.array_data_content count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.selectedIndex == 1) {
//
//        return 1;
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        return [self __cell_category:tableView cellForRowAtIndexPath:indexPath];
        
    } else {
        return [self __cell_brief:tableView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        return [self __calculate_height_content:indexPath];
    } else {
        
        NSString *ori_text = [self.dict_course stringForKey:@"desc"];
        NSString *text = [ori_text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        return [self __calculate_height_brief:text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.selectedIndex == 0) {
        return 0.01;
    } else {
        if (section == 0) {
            return 94.f;
        }
        return 44.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 15)];
    view.backgroundColor = __color_white;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.selectedIndex == 0) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    } else {
        
        if (section == 0) {
            static NSString *reuseIdentifier = @"top_header";
            CourseSectionTopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
            if (!header) {
                header = [[CourseSectionTopHeader alloc] initWithReuseIdentifier:reuseIdentifier];
            }
            NSString *chapter_name = [[self.array_data_content objectAtIndex:section] stringForKey:@"title"];
            header.label_subtitle.width = APPScreenWidth - 40;
            header.label_subtitle.text = chapter_name;
            header.label_title.text = [NSString stringWithFormat:@"共%ld节课程", [self.array_data_content count]];
            
            return header;
        }
        
        static NSString *reuseIdentifier = @"header";
        CourseSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
        if (!header) {
            header = [[CourseSectionHeaderView alloc] initWithReuseIdentifier:reuseIdentifier];
        }
        NSString *chapter_name = [[self.array_data_content objectAtIndex:section] stringForKey:@"title"];
        header.label_title.width = APPScreenWidth - 40;
        header.label_title.text = chapter_name;
        return header;
    }
}

#pragma mark heights

- (CGFloat)__calculate_height_brief:(NSString *)brief
{
    CGFloat height = [UILabel text:brief font:__fontlight(16) width:APPScreenWidth - 40 lineSpacing:5];
    return height + 70;
}

- (CGFloat)__calculate_height_content:(NSIndexPath *)indexPath
{
    NSDictionary *data = [self.array_data_content objectAtIndex:indexPath.section];
    NSString *ori_text = [data stringForKey:@"subtitle"];
    NSString *text = [ori_text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    CGFloat label_height = [UILabel text:text font:__fontthin(16) width:APPScreenWidth - 30 lineSpacing:5];
    CGFloat height = label_height + 21;
    return height;
}

#pragma mark cells

- (UITableViewCell *)__cell_brief:(UITableView *)tableView
{
    static NSString *detailcell = @"briefcell";
    CourseBriefCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseBriefCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    [cell bindCourseBrief:self.dict_course];
    return cell;
}

- (UITableViewCell *)__cell_category:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailcell = @"detailcell";
    CourseSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    NSDictionary *data = [self.array_data_content objectAtIndex:indexPath.row];
    [cell bindCourseSection:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - webview delegates

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.content_height = webView.scrollView.contentSize.height;
    [self.tableView reloadData];
    
}

#pragma mark - actions


- (void)action_buy
{
    if (![BASEUSER loginstatus]) {
        PaymentViewController *payment = [[PaymentViewController alloc] init];
        payment.course_id = self.course_id;
        [self.navigationController pushViewController:payment animated:YES];
        
    } else {
        [self action_login];
    }
}

- (void)action_login
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

- (UIImage *)takeSnapshotOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(CGSizeMake(APPFullScreenWidth, APPFullScreenHeight));
    [view drawViewHierarchyInRect:CGRectMake(0, 0, APPFullScreenWidth, APPFullScreenHeight) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - network

- (void)action_course_detail
{
    NSDictionary *parms = @{
        @"course_id": self.course_id,
    };
    WeakSelf;
    [AFR requestWithUrl:REQUEST_COURSE
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionaryWithDictionary:parms]
          finishedBlock:^(id responseObject){
        NSLog(@"-------------------");
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSLog(@"%@", responseObject);
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            
            weakSelf.dict_course = [NSMutableDictionary dictionaryWithDictionary:data];
            weakSelf.array_data_content = [NSMutableArray arrayWithArray:[data arrayForKey:@"catlog"]];
            
            weakSelf.label_brief.text = [NSString stringWithFormat:@"共%ld节课程", [weakSelf.array_data_content count]];
            
            weakSelf.tableView.tableHeaderView = nil;
            weakSelf.tableView.tableHeaderView = weakSelf.header;
            [weakSelf.header bindCourseHeader:weakSelf.dict_course];
            
            weakSelf.label_price.text = [NSString stringWithFormat:@"¥%@", [weakSelf.dict_course stringIntForKey:@"price"]];
            [weakSelf.label_price sizeToFit];
            weakSelf.label_price_fake.centerY = weakSelf.label_price.centerY;
            
            NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
            NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@", [weakSelf.dict_course stringIntForKey:@"oprice"]] attributes:attribtDic];
            weakSelf.label_price_fake.attributedText = attribtStr;
            weakSelf.label_price_fake.left = self.label_price.right + 5;
            weakSelf.view_buy.hidden = NO;
            weakSelf.view_arrange.hidden = YES;
            
            [weakSelf.tableView reloadData];
        }
        
                }
            failedBlock:^(NSError *errorInfo){
        NSLog(@"~~~~~~~~~~");
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}

@end
