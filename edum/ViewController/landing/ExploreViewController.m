//
//  ExploreViewController.m
//  edum
//
//  Created by Md Chen on 24/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "ExploreViewController.h"
#import "HMSegmentedControl.h"
#import "MJRefresh.h"
#import "CategoryCell.h"
#import "SightScrollCell.h"
#import "LandingSectionHeaderView.h"
#import "CategoryHeaderView.h"
#import "BannerView.h"
#import "CourseListController.h"
#import "SearchCourseViewController.h"
#import "CourseViewController.h"

#define __SECTION_HEIGHT 40
#define GENERAL_CUBE_HEIGHT 80

@interface ExploreViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate>

//@property (nonatomic, strong) HMSegmentedControl *segmentedController;
//@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UILabel *label_logo;

@property (nonatomic, strong) BannerView *bannerview;
@property (nonatomic, strong) UIButton *button_refresh;
@property (nonatomic, strong) UIButton *button_refresh_right;

@property (nonatomic, strong) NSMutableArray *array_filter;//titles
@property (nonatomic, strong) NSMutableArray *array_data;//data
@property (nonatomic, strong) NSMutableArray *array_category;


@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UITextField *searchTextField;


@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
//    self.title = @"BEENTOX";
    [self.view addSubview:[self search_view]];
    [self.view addSubview:self.tableview];
    [self ___action_refresh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:
                           CGRectMake(30, 0, APPScreenWidth - 40, 29)];
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"搜索股票/组合/主题" attributes:@{NSForegroundColorAttributeName : [[TKHqSkin instance]getSkinColor:@"PRICE_TOP_SEARCH_PLACEHOLDER"], NSFontAttributeName : [UIFont systemFontOfSize:14.0f ]}];
//        _searchTextField.attributedPlaceholder = placeholderString;
        _searchTextField.placeholder = @"想学什么课程，一搜即可！";
        _searchTextField.font = __font(14);
        _searchTextField.textColor = __color_font_title;
        _searchTextField.userInteractionEnabled = YES;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.delegate = self;
        [_searchTextField setTintColor:[UIColor colorWithHEX:0x0080ff]];
    }
    return _searchTextField;
}

- (UIView *)search_view
{
    UIView *topSearchContain = [[UIView alloc] initWithFrame:CGRectMake(0, BASE_VIEW_Y + 30, APPScreenWidth, 30)];
    
    //顶部搜索框容器
    UIView *topSearch = [[UIView alloc] initWithFrame:CGRectMake(10, 0, APPScreenWidth - 20, 30)];
    topSearch.backgroundColor = [UIColor colorWithHEX:0xf1f1f1];
    topSearch.clipsToBounds = YES;
    topSearch.layer.cornerRadius = CORNERRADIUS;
    
    //搜索图片
    UIImageView *searchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_search"]];
    searchView.frame = CGRectMake(10, 8, 15, 15);
    [topSearch addSubview:searchView];
    searchView.userInteractionEnabled = YES;
    
    //添加输入框
    [topSearch addSubview:self.searchTextField];
    [topSearchContain addSubview:topSearch];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = topSearch.frame;
    [button addTarget:self action:@selector(action_search) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:button];
    return topSearchContain;
}

- (void)action_search
{
    SearchCourseViewController *search = [[SearchCourseViewController alloc] init];
    [self.navigationController pushViewController:search animated:NO];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (NSMutableArray *)array_filter
{
    if (!_array_filter) {
        _array_filter = [NSMutableArray array];
    }
    return _array_filter;
}

- (NSMutableArray *)array_category
{
    if (!_array_category) {
        _array_category = [NSMutableArray array];
    }
    return _array_category;
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

- (BannerView *)bannerview
{
    if (!_bannerview) {
        _bannerview = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, CATEGORY_HEIGHT + 45 + 5)];
        WeakSelf;
        _bannerview.block = ^(NSInteger selectCategory){
            CourseListController *collectionvc = [[CourseListController alloc] init];
            NSDictionary *dict = [weakSelf.array_category objectAtIndex:selectCategory];
            collectionvc.title = [dict stringForKey:@"name"];
            collectionvc.category = [dict stringForKey:@"category_id"];
            [weakSelf.navigationController pushViewController:collectionvc animated:YES];
        };
    }
    return _bannerview;
}

- (UIButton *)button_refresh_right
{
    if (!_button_refresh_right) {
        _button_refresh_right = [[UIButton alloc] initWithFrame:CGRectMake((APPScreenWidth - 100) / 2, 90, 100, 100)];
        [_button_refresh_right setImage:ImageNamed(@"refresh") forState:UIControlStateNormal];
        [_button_refresh_right setTitleColor:[UIColor colorWithHEX:0xdcdcdc] forState:UIControlStateNormal];
        [_button_refresh_right setTitle:@"Refresh" forState:UIControlStateNormal];
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
        _label_logo = [[UILabel alloc] initWithFrame:CGRectMake(0, -90 , APPScreenWidth, 80)];
        _label_logo.textColor = __color_gray_separator;
        _label_logo.textAlignment = NSTextAlignmentCenter;
//        _label_logo.text = @"BEENTOX TRAVEL";
        _label_logo.numberOfLines = 2;
        _label_logo.font = __fontlight(22);
    }
    return _label_logo;
}

#pragma -mark Properties

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPFullScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y - 49 - SafeAreaBottomHeight) style:UITableViewStyleGrouped];//
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor clearColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.backgroundColor = __color_white;
        _tableview.backgroundView = self.button_refresh_right;
//        [_tableview_right addSubview:self.label_logo];
        [_tableview registerClass:[LandingSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerview"];
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___action_refresh)];
    }
    return _tableview;
}

#pragma mark - tableiview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.array_data count] > 0) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LANDING_SIGHT_HEIGHT + 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return __SECTION_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LandingSectionHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerview"];
    if (!view) {
        view = [[LandingSectionHeaderView alloc] initWithReuseIdentifier:@"headerview"];
        view.frame = CGRectMake(0, 0, APPScreenWidth, __SECTION_HEIGHT);
    }
    NSString *string = [self.array_filter objectAtIndex:section];
    view.label.text = [NSString stringWithFormat:@"%@", string];
    view.button.tag = section;
    [view.button addTarget:self action:@selector(___action_header_readall:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 5)];
    view.backgroundColor = __color_white;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView sightCellForRowAtIndexPath:indexPath];
}

- (SightScrollCell *)tableView:(UITableView *)tableView sightCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell_scroll";
    SightScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SightScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.array_data = [self.array_data objectAtIndex:indexPath.section];
    cell.block = ^(NSInteger tag, NSInteger index) {
        [self ___action_sight_detail:tag withIndex:index];
    };
    cell.section_index = indexPath.section;
    [cell bindData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SightViewController *sight = [[SightViewController alloc] init];
//    NSDictionary *dict = [self.array_data_right objectAtIndex:indexPath.row];
//    sight.package_id = [dict stringForKey:@"package_id"];
//    sight.dic_preview = dict;
//    [self.navigationController pushViewController:sight animated:YES];
}

#pragma mark - actions

- (void)___action_sight_detail:(NSInteger)tag withIndex:(NSInteger)index
{
    NSLog(@"%ld:%ld", tag, index);
    CourseViewController *sight = [[CourseViewController alloc] init];
    NSDictionary *dict = [[self.array_data objectAtIndex:index] objectAtIndex:tag];
    sight.course_id = [dict stringForKey:@"course_id"];
    [self.navigationController pushViewController:sight animated:YES];
}

- (void)___action_header_readall:(UIButton *)button
{
    NSInteger tag = button.tag;
    CourseListController *collections = [[CourseListController alloc] init];
    NSArray *array = [self.array_data objectAtIndex:tag];
    collections.array_data = [NSMutableArray arrayWithArray:array];
    collections.title = [self.array_filter objectAtIndex:tag];
    [self.navigationController pushViewController:collections animated:YES];
    NSLog(@"%ld", tag);
}

- (void)___action_refresh
{
    [self ___fetch_things];
}

#pragma mark - requests

- (void)___fetch_things
{
    WeakSelf;
    [AFR requestWithUrl:REQUEST_LANDING_LIST
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionary]
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        [weakSelf.tableview.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            
            [weakSelf.array_category removeAllObjects];
            [weakSelf.array_filter removeAllObjects];
            [weakSelf.array_data removeAllObjects];
            
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            weakSelf.array_filter = [NSMutableArray arrayWithArray:[data arrayForKey:@"course_titles"]];
            weakSelf.array_data = [NSMutableArray arrayWithArray:[data arrayForKey:@"course"]];
            weakSelf.array_category = [NSMutableArray arrayWithArray:[data arrayForKey:@"category"]];
            [weakSelf.bannerview bindData:weakSelf.array_category];
            weakSelf.tableview.tableHeaderView = nil;
            weakSelf.tableview.tableHeaderView = weakSelf.bannerview;
            
            [weakSelf.tableview reloadData];
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf.tableview.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}


- (void)action_button:(UIButton *)button
{
    NSInteger index = button.tag;
    NSDictionary *dic = [self.array_filter objectAtIndex:index];
    NSString *category_id = [dic stringForKey:@"id"];
    CourseListController *collections = [[CourseListController alloc] init];
    collections.title = [dic stringForKey:@"name"];
    collections.category = category_id;
    [self.navigationController pushViewController:collections animated:YES];
    
}

@end
