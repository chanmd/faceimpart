//
//  LandingViewController.m
//  edum
//
//  Created by Kevin Chan on 16/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "LandingViewController.h"

#import "TopTeacherViewController.h"
#import "TopCourseViewController.h"

#import "HMSegmentedControl.h"
#import "MJRefresh.h"

#import "LandingSectionHeaderView.h"
#import "CategoryCell.h"
#import "LandingTeacherCell.h"
#import "LandingCourseCell.h"
#import "BannerView.h"

#import "CourseViewController.h"

#define MAIN_HEIGHT APPScreenHeight - BASE_VIEW_Y - 20 - 49 - SafeAreaBottomHeight - 40

#define TAG_SELECTED 1
#define TAG_PIANO 2
#define TAG_VIOLIN 3
#define TAG_VIOLINCELLO 4

#define SECTION_TYPE_TEACHER 0
#define SECTION_TYPE_COURSE 1

#define SECTION_KEY_BANNER @"banners"
#define SECTION_KEY_TEACHER @"teachers"
#define SECTION_KEY_COURSE @"courses"

#define SECTION_HEIGHT 60

@interface LandingViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UITableView *tableview_selected;
@property (nonatomic, strong) UITableView *tableview_piano;
@property (nonatomic, strong) UITableView *tableview_violin;
@property (nonatomic, strong) UITableView *tableview_violincello;

@property (nonatomic, strong) NSMutableDictionary *dictionary_selected_data;
@property (nonatomic, strong) NSMutableDictionary *dictionary_piano_data;
@property (nonatomic, strong) NSMutableDictionary *dictionary_violin_data;
@property (nonatomic, strong) NSMutableDictionary *dictionary_violincello_data;

@property (nonatomic, strong) NSMutableArray *array_header_titles;
@property (nonatomic, strong) BannerView *bannerview;

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollview];
    self.array_header_titles = [NSMutableArray arrayWithArray:@[@"推荐老师", @"精选课程"]];
    [self ___fetch_category];
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

- (NSMutableArray *)array_header_titles
{
    if (!_array_header_titles) {
        _array_header_titles = [NSMutableArray array];
    }
    return _array_header_titles;
}

- (NSMutableDictionary *)dictionary_selected_data
{
    if (!_dictionary_selected_data) {
        _dictionary_selected_data = [NSMutableDictionary dictionary];
    }
    return _dictionary_selected_data;
}

- (NSMutableDictionary *)dictionary_piano_data
{
    if (!_dictionary_piano_data) {
        _dictionary_piano_data = [NSMutableDictionary dictionary];
    }
    return _dictionary_piano_data;
}

- (NSMutableDictionary *)dictionary_violin_data
{
    if (!_dictionary_violin_data) {
        _dictionary_violin_data = [NSMutableDictionary dictionary];
    }
    return _dictionary_violin_data;
}

- (NSMutableDictionary *)dictionary_violincello_data
{
    if (!_dictionary_violincello_data) {
        _dictionary_violincello_data = [NSMutableDictionary dictionary];
    }
    return _dictionary_violincello_data;
}

- (NSMutableDictionary *)dictionary_data:(NSInteger )type
{
    if (type == TAG_SELECTED) {
        return self.dictionary_selected_data;
    } else if (type == TAG_PIANO) {
        return self.dictionary_piano_data;
    } else if (type == TAG_VIOLIN) {
        return self.dictionary_violin_data;
    } else if (type == TAG_VIOLINCELLO) {
        return self.dictionary_violincello_data;
    } else {
        return self.dictionary_selected_data;
    }
}

- (HMSegmentedControl *)segmentedControl
{
    if(!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] init];
        _segmentedControl.sectionTitles = @[@"精选", @"钢琴", @"小提琴", @"大提琴"];
        _segmentedControl.frame = CGRectMake(15, BASE_VIEW_Y + 20, APPScreenWidth - 15 - 80, 40);
        _segmentedControl.backgroundColor = __color_white;
        _segmentedControl.selectionIndicatorHeight = 2.f;
        _segmentedControl.selectionIndicatorColor = __color_main;
        _segmentedControl.shouldAnimateUserSelection = YES;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectedTitleTextAttributes = [NSDictionary dictionaryWithObjects:
                                                         [NSArray arrayWithObjects:__color_main, __fontthin(18), nil]
                                                                                    forKeys:
                                                         [NSArray arrayWithObjects:NSForegroundColorAttributeName, NSFontAttributeName, nil]];
        
        _segmentedControl.titleTextAttributes = [NSDictionary dictionaryWithObjects:
                                                 [NSArray arrayWithObjects:__color_font_title,
                                                  __fontthin(18), nil]
                                                                            forKeys:
                                                 [NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]];
        [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)segmentedControlChangedValue
{
    NSInteger index = self.segmentedControl.selectedSegmentIndex;
    [self.scrollview setContentOffset:CGPointMake(index * APPScreenWidth, 0) animated:YES];
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BASE_VIEW_Y + 20 + 40, APPScreenWidth, MAIN_HEIGHT)];
        _scrollview.contentSize = CGSizeMake(APPScreenWidth * 4, MAIN_HEIGHT);
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.backgroundColor = __color_white;
        [_scrollview addSubview:self.tableview_selected];
        [_scrollview addSubview:self.tableview_piano];
        [_scrollview addSubview:self.tableview_violin];
        [_scrollview addSubview:self.tableview_violincello];
    }
    return _scrollview;
}

- (UITableView *)tableview_selected
{
    if (!_tableview_selected) {
        _tableview_selected = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, MAIN_HEIGHT) style:UITableViewStyleGrouped];
                _tableview_selected.delegate = self;
                _tableview_selected.dataSource = self;
                _tableview_selected.separatorStyle = UITableViewCellSeparatorStyleNone;
                _tableview_selected.backgroundColor = __color_clear;
        _tableview_selected.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(action_refresh)];
    }
    return _tableview_selected;
}

- (BannerView *)bannerview
{
    if (!_bannerview) {
        _bannerview = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, BANNER_WIDTH, BANNER_HEIGHT + 15)];
        _bannerview.block = ^(NSInteger selectCategory){
        };
    }
    return _bannerview;
}

- (UITableView *)tableview_piano
{
    if (!_tableview_piano) {
        _tableview_piano = [[UITableView alloc] initWithFrame:CGRectMake(APPScreenWidth, 0, APPScreenWidth, MAIN_HEIGHT) style:UITableViewStyleGrouped];
                _tableview_piano.delegate = self;
                _tableview_piano.dataSource = self;
                _tableview_piano.separatorStyle = UITableViewCellSeparatorStyleNone;
                _tableview_piano.backgroundColor = __color_clear;
        _tableview_piano.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(action_refresh)];
    }
    return _tableview_piano;
}

- (UITableView *)tableview_violin
{
    if (!_tableview_violin) {
        _tableview_violin = [[UITableView alloc] initWithFrame:CGRectMake(APPScreenWidth* 2, 0, APPScreenWidth, MAIN_HEIGHT) style:UITableViewStyleGrouped];
                _tableview_violin.delegate = self;
                _tableview_violin.dataSource = self;
                _tableview_violin.separatorStyle = UITableViewCellSeparatorStyleNone;
                _tableview_violin.backgroundColor = __color_clear;
        _tableview_violin.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(action_refresh)];
    }
    return _tableview_violin;
}

- (UITableView *)tableview_violincello
{
    if (!_tableview_violincello) {
        _tableview_violincello = [[UITableView alloc] initWithFrame:CGRectMake(APPScreenWidth* 3, 0, APPScreenWidth, MAIN_HEIGHT) style:UITableViewStyleGrouped];
                _tableview_violincello.delegate = self;
                _tableview_violincello.dataSource = self;
                _tableview_violincello.separatorStyle = UITableViewCellSeparatorStyleNone;
                _tableview_violincello.backgroundColor = __color_clear;
        _tableview_violincello.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(action_refresh)];
    }
    return _tableview_violincello;
}

- (void)action_refresh
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat index = scrollView.contentOffset.x / APPScreenWidth;
//    NSLog(@"%f---%f", index, floor(index));
    if (index - floor(index) < 0.1) {
        self.segmentedControl.selectedSegmentIndex = index;
    }
}


#pragma mark - tableiview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[self dictionary_data:tableView.tag] allKeys] count] == 0) {
        return 0;
    }
    if (section == SECTION_TYPE_TEACHER) {
        return [[[self dictionary_data:tableView.tag] arrayForKey:SECTION_KEY_TEACHER] count];
    } else if (section == SECTION_TYPE_COURSE) {
        return [[[self dictionary_data:tableView.tag] arrayForKey:SECTION_KEY_COURSE] count];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.array_header_titles count] == 0) {
        return 0;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SECTION_TYPE_TEACHER) {
        return LANDING_TEACHER_HEIGHT + 15;
    } else if (indexPath.section == SECTION_TYPE_COURSE) {
        return LANDING_COURSE_HEIGHT + 15;
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
    if ([[[self dictionary_data:tableView.tag] allKeys] count] > 0) {
        
        if (indexPath.section == SECTION_TYPE_TEACHER) {
            return [self tableView:tableView _teacherCellForRowAtIndexPath:indexPath];
        } else if (indexPath.section == SECTION_TYPE_COURSE) {
            return [self tableView:tableView _courseCellForRowAtIndexPath:indexPath];
        } else {
            return [self tableView:tableView _normalCellForRowAtIndexPath:indexPath];
        }
        
    } else {
        return [self tableView:tableView _normalCellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self dictionary_data:tableView.tag] allKeys] count] > 0) {
        if (indexPath.section == SECTION_TYPE_TEACHER) {
            
        } else if (indexPath.section == SECTION_TYPE_COURSE) {
            CourseViewController *courseview = [[CourseViewController alloc] init];
            [self.navigationController pushViewController:courseview animated:YES];
        }
    }
}

- (LandingTeacherCell *)tableView:(UITableView *)tableView _teacherCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"teacher_cell";
    LandingTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[LandingTeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *dictionary = [[[self dictionary_data:tableView.tag] arrayForKey:SECTION_KEY_TEACHER] objectAtIndex:indexPath.row];
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
    NSDictionary *dictionary = [[[self dictionary_data:tableView.tag] arrayForKey:SECTION_KEY_COURSE] objectAtIndex:indexPath.row];
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


#pragma mark - actions

- (void)___action_sight_detail:(NSInteger)index withSection:(NSInteger)section
{
    NSLog(@"第%ld列:第%ld行", section, index);
//    if (section == SECTION_TYPE_TEACHER) {
//        [[[self dictionary_data:tableView.tag] arrayForKey:SECTION_KEY_TEACHER] objectAtIndex:index];
//    } else if (section == SECTION_TYPE_COURSE) {
//        [[[self dictionary_data:tableView.tag] arrayForKey:SECTION_KEY_COURSE] objectAtIndex:index];
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
        [weakSelf.tableview_selected.mj_header endRefreshing];
        if ([[tempDic objectForKey:@"code"] integerValue] == 200) {
            
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            [weakSelf.bannerview bindData:[data arrayForKey:SECTION_KEY_BANNER]];
            weakSelf.tableview_selected.tableHeaderView = nil;
            weakSelf.tableview_selected.tableHeaderView = weakSelf.bannerview;
            weakSelf.dictionary_selected_data = [NSMutableDictionary dictionaryWithDictionary:data];
            weakSelf.dictionary_piano_data = [NSMutableDictionary dictionaryWithDictionary:data];
            weakSelf.dictionary_violin_data = [NSMutableDictionary dictionaryWithDictionary:data];
            weakSelf.dictionary_violincello_data = [NSMutableDictionary dictionaryWithDictionary:data];
            
            [weakSelf.tableview_selected reloadData];
            [weakSelf.tableview_piano reloadData];
            [weakSelf.tableview_violin reloadData];
            [weakSelf.tableview_violincello reloadData];
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf.tableview_selected.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}


@end
