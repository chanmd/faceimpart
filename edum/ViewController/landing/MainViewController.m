//
//  MainViewController.m
//  gwlx
//
//  Created by Kevin Chan on 4/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "MainViewController.h"
#import "HMSegmentedControl.h"
#import "MJRefresh.h"
#import "LandingSectionHeaderView.h"
#import "CategoryCell.h"
#import "LandingTeacherCell.h"
#import "LandingCourseCell.h"
#import "LandingArticleCell.h"

#import "StudyBoardViewController.h"
#import "GuideViewController.h"
#import "TopTeacherViewController.h"
#import "TopCourseViewController.h"

#define SECTION_HEIGHT 60

#define SECTION_TYPE_BANNER 1
#define SECTION_TYPE_INSTREAMNT 4
#define SECTION_TYPE_TEACHER 0
#define SECTION_TYPE_COURSE 1
#define SECTION_TYPE_ARTICLE 2

#define SECTION_KEY_BANNER @"banners"
#define SECTION_KEY_INSTRUMENT @"instruments"
#define SECTION_KEY_TEACHER @"teachers"
#define SECTION_KEY_COURSE @"courses"
#define SECTION_KEY_ARTICLE @"article"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
//    self.title = @"首页推荐";
    [self.view addSubview:self.tableview_right];
    self.array_header_titles = [NSMutableArray arrayWithArray:@[@"乐器", @"教师风采", @"课程推荐", @"文章推荐"]];
    [self ___action_refresh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [MobClick endLogPageView:@"mainview"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.button_a setImage:ImageNamed(@"landing_highlight") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)dictionary_data
{
    if (!_dictionary_data) {
        _dictionary_data = [[NSMutableDictionary alloc] init];
    }
    return _dictionary_data;
}

- (BannerView *)bannerview
{
    if (!_bannerview) {
        _bannerview = [[BannerView alloc] initWithFrame:CGRectMake(0, APPScreenHeight, BANNER_WIDTH, BANNER_HEIGHT + 60)];
//        WeakSelf;
        _bannerview.block = ^(NSInteger selectCategory){
//            CityCollectionViewController *collectionvc = [[CityCollectionViewController alloc] init];
//            NSDictionary *dict = [weakSelf.array_data_left objectAtIndex:selectCategory];
//            collectionvc.title = [dict stringForKey:@"name"];
//            collectionvc.dict_info = dict;
//            collectionvc.collection_id = [dict stringForKey:@"category_id"];
//            [weakSelf.navigationController pushViewController:collectionvc animated:YES];
        };
    }
    return _bannerview;
}

- (UIButton *)button_refresh
{
    if (!_button_refresh) {
        _button_refresh = [[UIButton alloc] initWithFrame:CGRectMake((APPScreenWidth - 100) / 2, 90, 100, 100)];
        [_button_refresh setImage:ImageNamed(@"refresh") forState:UIControlStateNormal];
        [_button_refresh setTitleColor:[UIColor colorWithHEX:0xdcdcdc] forState:UIControlStateNormal];
        [_button_refresh setTitle:@"Refresh" forState:UIControlStateNormal];
        [_button_refresh addTarget:self action:@selector(___action_refresh) forControlEvents:UIControlEventTouchUpInside];
        
        _button_refresh.imageView.size = CGSizeMake(40, 40);
        CGFloat spacing = 6.0;
        
        // lower the text and push it left so it appears centered
        //  below the image
        CGSize imageSize = _button_refresh.imageView.image.size;
        _button_refresh.titleEdgeInsets = UIEdgeInsetsMake(
                                                  0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        //  above the text
        CGSize titleSize = [_button_refresh.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: _button_refresh.titleLabel.font}];
        _button_refresh.imageEdgeInsets = UIEdgeInsetsMake(
                                                  - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
        // increase the content height to avoid clipping
        CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
        _button_refresh.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
        
    }
    return _button_refresh;
}

- (UIButton *)button_refresh_right
{
    if (!_button_refresh_right) {
        _button_refresh_right = [[UIButton alloc] initWithFrame:CGRectMake((APPScreenWidth - 100) / 2, 90, 100, 100)];
        [_button_refresh_right setImage:ImageNamed(@"refresh") forState:UIControlStateNormal];
        [_button_refresh_right setTitleColor:[UIColor colorWithHEX:0xdcdcdc] forState:UIControlStateNormal];
        [_button_refresh_right setTitle:@"点击刷新" forState:UIControlStateNormal];
        [_button_refresh_right addTarget:self action:@selector(___action_refresh) forControlEvents:UIControlEventTouchUpInside];
        
        _button_refresh_right.imageView.size = CGSizeMake(40, 40);
        CGFloat spacing = 6.0;
        
        // lower the text and push it left so it appears centered
        //  below the image
        CGSize imageSize = _button_refresh_right.imageView.image.size;
        _button_refresh_right.titleEdgeInsets = UIEdgeInsetsMake(
                                                           0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        //  above the text
        CGSize titleSize = [_button_refresh_right.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: _button_refresh_right.titleLabel.font}];
        _button_refresh_right.imageEdgeInsets = UIEdgeInsetsMake(
                                                           - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
        // increase the content height to avoid clipping
        CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
        _button_refresh_right.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
        
    }
    return _button_refresh_right;
}


- (UILabel *)label_logo
{
    if (!_label_logo) {
        _label_logo = [[UILabel alloc] initWithFrame:CGRectMake(0, -150, APPScreenWidth, 80)];
        _label_logo.textColor = [UIColor colorWithHEX:0xeb5c4a Alpha:0.3];
        _label_logo.textAlignment = NSTextAlignmentCenter;
        _label_logo.text = @"FACEIMPART\n音湃";
        _label_logo.numberOfLines = 2;
        _label_logo.font = __fontlight(22);
    }
    return _label_logo;
}

#pragma -mark Properties

- (UITableView *)tableview_right
{
    if (!_tableview_right) {
        _tableview_right = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_VIEW_Y + 20, APPFullScreenWidth, APPFullScreenHeight - BASE_VIEW_Y - 49 - SafeAreaBottomHeight - 20) style:UITableViewStyleGrouped];
        _tableview_right.delegate = self;
        _tableview_right.dataSource = self;
        _tableview_right.separatorColor = [UIColor clearColor];
        _tableview_right.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview_right.backgroundColor = __color_clear;
        _tableview_right.backgroundView = self.button_refresh_right;
//        [_tableview_right addSubview:self.label_logo];
        [_tableview_right registerClass:[LandingSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerview"];
        _tableview_right.tableHeaderView = self.bannerview;
        _tableview_right.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___action_refresh)];
    }
    return _tableview_right;
}

//- (UILabel *)label_empty
//{
//    if (!_label_empty) {
//        _label_empty = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, APPScreenWidth, 20)];
//        _label_empty.textColor = __color_font_subtitle;
//        _label_empty.font = __font(12);
//        _label_empty.textAlignment = NSTextAlignmentCenter;
//        _label_empty.text = @"没有信息";
//    }
//    return _label_empty;
//}

#pragma mark - tableiview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.dictionary_data allKeys] count] == 0) {
        return 0;
    }
    if (section == SECTION_TYPE_TEACHER) {
        return [[self.dictionary_data arrayForKey:SECTION_KEY_TEACHER] count];
    } else if (section == SECTION_TYPE_COURSE) {
        return [[self.dictionary_data arrayForKey:SECTION_KEY_COURSE] count];
    } else if (section == SECTION_TYPE_ARTICLE) {
        return [[self.dictionary_data arrayForKey:SECTION_KEY_ARTICLE] count];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.array_header_titles count] == 0) {
        return 0;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SECTION_TYPE_TEACHER) {
        return LANDING_TEACHER_HEIGHT + 15;
    } else if (indexPath.section == SECTION_TYPE_COURSE) {
        return LANDING_COURSE_HEIGHT + 15;
    } else if (indexPath.section == SECTION_TYPE_ARTICLE) {
        return LANDING_ARTICLE_HEIGHT + 15;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.array_header_titles count] == 0) {
        return 0.1f;
    }
    return SECTION_HEIGHT;
}

#pragma mark tableview cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dictionary_data allKeys] count] > 0) {
        
        if (indexPath.section == SECTION_TYPE_TEACHER) {
            return [self tableView:tableView _teacherCellForRowAtIndexPath:indexPath];
        } else if (indexPath.section == SECTION_TYPE_COURSE) {
            return [self tableView:tableView _courseCellForRowAtIndexPath:indexPath];
        } else if (indexPath.section == SECTION_TYPE_ARTICLE) {
            return [self tableView:tableView _articleCellForRowAtIndexPath:indexPath];
        } else {
            return [self tableView:tableView _normalCellForRowAtIndexPath:indexPath];
        }
        
    } else {
        return [self tableView:tableView _normalCellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dictionary_data allKeys] count] > 0) {
        if (indexPath.section == SECTION_TYPE_TEACHER) {
            
        } else if (indexPath.section == SECTION_TYPE_COURSE) {
            
        } else if (indexPath.section == SECTION_TYPE_ARTICLE) {
            
        }
    }
}

- (LandingTeacherCell *)tableView:(UITableView *)tableWiew _teacherCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"teacher_cell";
    LandingTeacherCell *cell = [tableWiew dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingTeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dictionary = [[self.dictionary_data arrayForKey:SECTION_KEY_TEACHER] objectAtIndex:indexPath.row];
    [cell bindElementWithData:dictionary];
    return cell;
}

- (LandingCourseCell *)tableView:(UITableView *)tableView _courseCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"course_cell";
    LandingCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dictionary = [[self.dictionary_data arrayForKey:SECTION_KEY_COURSE] objectAtIndex:indexPath.row];
    [cell bindElementWithData:dictionary];
    return cell;
}

- (LandingArticleCell *)tableView:(UITableView *)tableView _articleCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"article_cell";
    LandingArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dictionary = [[self.dictionary_data arrayForKey:SECTION_KEY_ARTICLE] objectAtIndex:indexPath.row];
    [cell bindElementWithData:dictionary];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView _normalCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headviewIdentifier";
    LandingSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!view) {
        view = [[LandingSectionHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        view.frame = CGRectMake(0, 0, APPScreenWidth, SECTION_HEIGHT);
    }
    NSString *string = [self.array_header_titles objectAtIndex:section];
    view.label.text = [NSString stringWithFormat:@"%@", string];
    view.button.tag = section;
    [view.button addTarget:self action:@selector(___action_header_readall:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.1)];
    view.backgroundColor = __color_white;
    return view;
}

//- (SightScrollCell *)tableView:(UITableView *)tableView sightCellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellID = @"cell_scroll";
//    SightScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[SightScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.array_data = [self.array_data_right objectAtIndex:indexPath.section];
//    cell.section_index = indexPath.section;
//    cell.block = ^(NSInteger row, NSInteger section) {
//        [self ___action_sight_detail:row withIndex:section];
//    };
//    [cell bindData];
//    return cell;
//}


#pragma mark - actions

- (void)___action_sight_detail:(NSInteger)index withSection:(NSInteger)section
{
    NSLog(@"第%ld列:第%ld行", section, index);
    if (section == SECTION_TYPE_TEACHER) {
        [[self.dictionary_data arrayForKey:SECTION_KEY_TEACHER] objectAtIndex:index];
    } else if (section == SECTION_TYPE_COURSE) {
        [[self.dictionary_data arrayForKey:SECTION_KEY_COURSE] objectAtIndex:index];
    } else if (section == SECTION_TYPE_ARTICLE) {
        [[self.dictionary_data arrayForKey:SECTION_KEY_ARTICLE] objectAtIndex:index];
    }
//    NSDictionary * dict  = [[self.array_data_right objectAtIndex:index] objectAtIndex:tag];
//    if ([[dict stringForKey:@"type"] isEqualToString:@"2"]) {
//        GuideViewController *profile = [[GuideViewController alloc] init];
//        profile.string_user_id = [dict stringForKey:@"id"];
//        [self.navigationController pushViewController:profile animated:YES];
//
//    } else if ([[dict stringForKey:@"type"] isEqualToString:@"3"]) {
//        StudyBoardViewController *course = [[StudyBoardViewController alloc] init];
//        course.course_id = [dict stringForKey:@"id"];
//        [self.navigationController pushViewController:course animated:YES];
//    }
}

- (void)___action_header_readall:(UIButton *)button
{
    NSInteger tag = button.tag;
    if (tag == SECTION_TYPE_TEACHER) {
        TopTeacherViewController *topteacher = [[TopTeacherViewController alloc] init];
        [self.navigationController pushViewController:topteacher animated:YES];
    } else if (tag == SECTION_TYPE_COURSE) {
        TopCourseViewController *topcourse = [[TopCourseViewController alloc] init];
        [self.navigationController pushViewController:topcourse animated:YES];
    }
}

- (void)___action_refresh
{
    [self ___fetch_category];
}

- (void)action_button:(UIButton *)button
{
//    NSInteger index = button.tag;
//    NSDictionary *dic = [self.array_filter objectAtIndex:index];
//    NSString *collection_id = [dic stringForKey:@"collection_id"];
//    CityCollectionViewController *collectionvc = [[CityCollectionViewController alloc] init];
//    collectionvc.collection_id = collection_id;
//    collectionvc.title = [dic stringForKey:@"name"];
//    [self.navigationController pushViewController:collectionvc animated:YES];
}

- (void)___fetch_category
{
    WeakSelf;
    [AFR requestWithUrl:REQUEST_LANDING_LIST
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionary]
          finishedBlock:^(id responseObject){
        NSLog(@"");
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        [weakSelf.tableview_right.mj_header endRefreshing];
        if ([[tempDic objectForKey:@"code"] integerValue] == 200) {
            
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            [weakSelf.bannerview bindData:[data arrayForKey:SECTION_KEY_BANNER]];
            weakSelf.tableview_right.tableHeaderView = nil;
            weakSelf.tableview_right.tableHeaderView = weakSelf.bannerview;
            weakSelf.array_header_titles = [NSMutableArray arrayWithArray:@[@"优秀老师", @"课程推荐"]];//[data arrayForKey:@"titles"];
            weakSelf.dictionary_data = [NSMutableDictionary dictionaryWithDictionary:data];
            [weakSelf.tableview_right reloadData];
        }
        [weakSelf.tableview_right reloadData];
    }
            failedBlock:^(NSError *errorInfo){
        NSLog(@"");
        [weakSelf.tableview_right.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}





@end
