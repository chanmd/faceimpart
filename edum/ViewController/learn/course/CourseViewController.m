//
//  CourseViewController.m
//  edum
//
//  Created by Kevin Chan on 26/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseViewController.h"
#import "LoginOverseaViewController.h"

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
#import "CourseVideoCell.h"
#import "CourseRectangleCell.h"
#import "CourseBriefDetailViewController.h"
#import "PaymentViewController.h"
#import "AppointmentViewController.h"
#import "TeacherViewController.h"
#import "VideoPlayerViewController.h"
#import "CourseVideoListViewController.h"

#define NAVBAR_CHANGE_POINT 50
#define PADDING_OFFSET_X -50


@interface CourseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_course_catlog;
@property (nonatomic, strong) NSMutableDictionary *dict_course;
@property (nonatomic, strong) NSMutableArray *array_recommend;
@property (nonatomic, strong) NSMutableDictionary *dictionary_catlogs;
@property (nonatomic, assign) CGFloat content_height;

@property (nonatomic, strong) CourseHeaderView *header;
@property (nonatomic, strong) UIView *briefview;
@property (nonatomic, strong) UILabel *label_brief;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIView *view_ceil;
@property (nonatomic, strong) UIView *view_border;
@property (nonatomic, strong) UIView *view_buy;
@property (nonatomic, strong) UIButton *button_calendar;
@property (nonatomic, strong) UIImageView *imageview_calendar;
@property (nonatomic, strong) UILabel *label_calendar;
@property (nonatomic, strong) UIButton *button_buy;
@property (nonatomic, strong) UIView *view_arrange;
@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UIButton *button_arrangement;

@property (nonatomic, strong) UIButton *button_more_video;

 
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
    [self.view addSubview:self.view_border];
    [self.view addSubview:self.view_buy];
    [self.view addSubview:self.view_arrange];
    [self action_course_detail];
    
//    NSDictionary *video = [self.array_course_catlog objectAtIndex:indexPath.row];
    VideoPlayerViewController *player = [[VideoPlayerViewController alloc] init];
    player.data = @{};//video;
    [self.navigationController pushViewController:player animated:YES];
    
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight - 55 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];
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
        WeakSelf;
        _header = [[CourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 300)];
        _header.block = ^(NSString *teacher_id) {
            [weakSelf action_teacher:teacher_id];
        };
        _header.readmore_block  = ^(void) {
            [weakSelf action_readmore];
        };
    }
    return _header;
}

- (void)action_teacher:(NSString *)teacher_id
{
    TeacherViewController *teacher = [[TeacherViewController alloc] init];
    teacher.user_id = teacher_id;
    [self.navigationController pushViewController:teacher animated:YES];
}

- (void)action_readmore
{
    CourseBriefDetailViewController *detail = [[CourseBriefDetailViewController alloc] init];
    [detail bindData:[self.dict_course stringForKey:@"desc"]];
    [self presentViewController:detail animated:YES completion:nil];
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

- (UIView *)view_ceil
{
    if (!_view_ceil) {
        _view_ceil = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.5)];
        _view_ceil.backgroundColor = __color_gray_background;
    }
    return _view_ceil;
}


- (UIView *)view_buy
{
    if (!_view_buy) {
        _view_buy = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 55 - SafeAreaBottomHeight, APPScreenWidth, 55 + SafeAreaBottomHeight)];
        _view_buy.backgroundColor = __color_white;
//        [_view_buy addSubview:self.view_ceil];
//        [_view_buy addSubview:self.imageview_calendar];
//        [_view_buy addSubview:self.label_calendar];
//        [_view_buy addSubview:self.button_calendar];
        [_view_buy addSubview:self.button_buy];
    }
    return _view_buy;
}


- (UIButton *)button_buy
{
    if (!_button_buy) {
        _button_buy = [[UIButton alloc] initWithFrame:CGRectMake(15, 7, APPScreenWidth - 30, 40)];
        [_button_buy setTitle:@"开始练习" forState:UIControlStateNormal];
        _button_buy.layer.masksToBounds = YES;
        _button_buy.layer.backgroundColor = [__color_main CGColor];
        _button_buy.layer.cornerRadius = CORNERRADIUS;
        [_button_buy setTitleColor:__color_white forState:UIControlStateNormal];
        _button_buy.titleLabel.font = __font(16);
        [_button_buy addTarget:self action:@selector(action_buy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_buy;
}

- (UIImageView *)imageview_calendar
{
    if (!_imageview_calendar) {
        _imageview_calendar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13, 24, 24)];
        [_imageview_calendar setImage:ImageNamed(@"course_calendar_button")];
    }
    return _imageview_calendar;
}

- (UIButton *)button_calendar
{
    if (!_button_calendar) {
        _button_calendar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 55)];
        _button_calendar.layer.masksToBounds = YES;
        [_button_calendar addTarget:self action:@selector(action_calendar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_calendar;
}

- (UILabel *)label_calendar
{
    if (!_label_calendar) {
        _label_calendar = [[UILabel alloc] initWithFrame:CGRectMake(48, 18, 60, 14)];
        _label_calendar.font = __font(12);
        _label_calendar.textColor = __color_font_title;
        _label_calendar.text = @"加入日历";
    }
    return _label_calendar;
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
        _label_status = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, APPScreenWidth - 15 - 120, 36)];
        _label_status.textColor = __color_font_subtitle;
        _label_status.font = __font(16);
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


- (UIButton *)button_more_video
{
    if (!_button_more_video) {
        _button_more_video = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, APPScreenWidth, 44)];
        _button_more_video.titleLabel.font = __font(14);
        [_button_more_video setTitleColor:__color_font_subtitle forState:UIControlStateNormal];
        [_button_more_video addTarget:self action:@selector(action_all_video) forControlEvents:UIControlEventTouchUpInside];
        _button_more_video.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _button_more_video;
}

- (void)action_calendar
{
    
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
//        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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

- (NSMutableArray *)array_recommend
{
    if (!_array_recommend) {
        _array_recommend = [NSMutableArray array];
    }
    return _array_recommend;
}

- (NSMutableArray *)array_course_catlog
{
    if (!_array_course_catlog) {
        _array_course_catlog = [NSMutableArray array];
    }
    return _array_course_catlog;
}

- (NSMutableDictionary *)dictionary_catlogs
{
    if (!_dictionary_catlogs) {
        _dictionary_catlogs = [NSMutableDictionary dictionary];
    }
    return _dictionary_catlogs;
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
    [self.tableView reloadData];
}

#pragma mark - tableiview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.array_course_catlog count] + 1;
    } else if (section == 1) {
        return [self.array_recommend count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == [self.array_course_catlog count]) {
            return [self __cell_more:tableView cellForRowAtIndexPath:indexPath];
        }
        return [self __cell_category:tableView cellForRowAtIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        return [self __cell_recommend:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == [self.array_course_catlog count]) {
            return 44;
        }
        return 70;
        
    } else if (indexPath.section == 1) {
        
        return COURSE_LIST_HEIGHT + 10;
    }
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
    header.label_title.width = APPScreenWidth - 40;
    [header.button_more addTarget:self action:@selector(action_all_video) forControlEvents:UIControlEventTouchUpInside];
    if (section == 0) {
        if ([self.array_course_catlog count] > 0) {
            header.label_title.text = @"课程内容";
            header.button_more.hidden = NO;
        }
    } else if (section == 1) {
        if ([self.array_recommend count] > 0) {
            header.label_title.text = @"推荐课程";
            header.button_more.hidden = YES;
        }
    }
    
//    NSString *chapter_name = [[self.array_data_content objectAtIndex:section] stringForKey:@"title"];
    return header;
    
    
    
//    if (self.selectedIndex == 0) {
//        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
//    } else {
//
//        if (section == 0) {
//            static NSString *reuseIdentifier = @"top_header";
//            CourseSectionTopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
//            if (!header) {
//                header = [[CourseSectionTopHeader alloc] initWithReuseIdentifier:reuseIdentifier];
//            }
//            NSString *chapter_name = [[self.array_data_content objectAtIndex:section] stringForKey:@"title"];
//            header.label_subtitle.width = APPScreenWidth - 40;
//            header.label_subtitle.text = chapter_name;
//            header.label_title.text = [NSString stringWithFormat:@"共%ld节课程", [self.array_data_content count]];
//
//            return header;
//        }
//    }
}

#pragma mark heights

//- (CGFloat)__calculate_height_brief:(NSString *)brief
//{
//    CGFloat height = [UILabel text:brief font:__fontlight(16) width:APPScreenWidth - 40 lineSpacing:5];
//    return height + 70;
//}

//- (CGFloat)__calculate_height_content:(NSIndexPath *)indexPath
//{
//    NSDictionary *data = [self.array_data_content objectAtIndex:indexPath.section];
//    NSString *ori_text = [data stringForKey:@"subtitle"];
//    NSString *text = [ori_text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
//    CGFloat label_height = [UILabel text:text font:__fontthin(16) width:APPScreenWidth - 30 lineSpacing:5];
//    CGFloat height = label_height + 21;
//    return height;
//}

#pragma mark cells

- (UITableViewCell *)__cell_more:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *more_cell = @"all_video";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:more_cell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:more_cell];
    }
    [cell.contentView addSubview:self.button_more_video];
    return cell;
}

- (CourseRectangleCell *)__cell_recommend:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailcell = @"recommend";
    CourseRectangleCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseRectangleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    [cell bindData:[self.array_recommend objectAtIndex:indexPath.row]];
    return cell;
}

- (UITableViewCell *)__cell_category:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailcell = @"detailcell";
    CourseVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    NSDictionary *data = [self.array_course_catlog objectAtIndex:indexPath.row];
    [cell bindVideoData:data];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        NSDictionary *video = [self.array_course_catlog objectAtIndex:indexPath.row];
        VideoPlayerViewController *player = [[VideoPlayerViewController alloc] init];
        player.data = video;
        [self.navigationController pushViewController:player animated:YES];
        
    }
    if (indexPath.section == 1) {
        NSDictionary *course = [self.array_recommend objectAtIndex:indexPath.row];
        CourseViewController *courseview = [[CourseViewController alloc] init];
        courseview.course_id = [course objectForKey:@"course_id"];
        [self.navigationController pushViewController:courseview animated:YES];
    }
}




#pragma mark - actions

- (void)action_buy
{
    if ([BASEUSER isLogin]) {
        PaymentViewController *payment = [[PaymentViewController alloc] init];
        payment.course_id = self.course_id;
        [self.navigationController pushViewController:payment animated:YES];
        
    } else {
        [self action_login];
    }
}

- (void)action_login
{
    LoginOverseaViewController *login = [[LoginOverseaViewController alloc] init];
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

- (void)action_all_video
{
    CourseVideoListViewController *list = [[CourseVideoListViewController alloc] init];
    list.array_data = [NSMutableArray arrayWithArray:[self.dictionary_catlogs allValues]];
    list.array_data_titles = [NSMutableArray arrayWithArray:[self.dictionary_catlogs allKeys]];
    [self.navigationController pushViewController:list animated:YES];
}

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
            
            NSMutableDictionary *catlog = [NSMutableDictionary dictionaryWithDictionary:[data dictionaryForKey:@"catlog"]];
            self.dictionary_catlogs = catlog;
            
            NSArray *catlog_keys = [catlog allKeys];
            if ([catlog_keys count] > 0) {
                weakSelf.array_course_catlog = [NSMutableArray arrayWithArray:[catlog arrayForKey:catlog_keys[0]]];
            }
            weakSelf.array_recommend = [NSMutableArray arrayWithArray:[data arrayForKey:@"recommend"]];
            NSString *video_count = [data stringForKey:@"video_count"];
            [weakSelf.button_more_video setTitle:video_count forState:UIControlStateNormal];
            
            weakSelf.tableView.tableHeaderView = nil;
            weakSelf.tableView.tableHeaderView = weakSelf.header;
            [weakSelf.header bindCourseHeader:weakSelf.dict_course];
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
