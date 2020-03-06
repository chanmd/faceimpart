//
//  StudyBoardViewController.m
//  edum
//
//  Created by Kevin Chan on 3/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "StudyBoardViewController.h"
#import "StudyListCell.h"
#import "CourseBannerCell.h"
#import "CourseListViewController.h"
#import "CourseViewController.h"
#import "MJRefresh.h"
#import "SightBriefCell.h"
#import "UILabel+LineSpace.h"
#import "SightBriefViewController.h"
#import "UIImageEffects.h"
#import "GuideViewController.h"
#import "ProcessPlayerViewController.h"

#define STUDY_HEADER_HEIGHT 260

#define NAVBAR_CHANGE_POINT 50
#define PADDING_OFFSET_X -50
#define TABLEVIEW_TITLE 0
#define TABLEVIEW_CONTENT 1

@interface StudyBoardViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *view_navigationbar;
@property (nonatomic, strong) UIButton *button_back;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIButton *button_fav;
@property (nonatomic, strong) UIView *view_navi_border;

@property (nonatomic, strong) UIView *view_empty;
@property (nonatomic, strong) UIImageView *imageview_empty;
@property (nonatomic, strong) UILabel *label_empty;
@property (nonatomic, strong) NSMutableArray *array_empty;//empty titles

@property (nonatomic, strong) UIView *view_current;

@property (nonatomic, strong) UIView *header;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array_data_chapter;
@property (nonatomic, strong) NSMutableDictionary *dictionary_data;

@end

@implementation StudyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.view_navigationbar];
    self.view_current.hidden = YES;
    self.view_empty.hidden = YES;
    [self fetch_course_info];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (UIView *)view_navigationbar
{
    if (!_view_navigationbar) {
        _view_navigationbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, BASE_TABLEVIEW_Y)];
        _view_navigationbar.backgroundColor = __color_main;
        [_view_navigationbar addSubview:self.label_title];
        [_view_navigationbar addSubview:self.button_back];
//        [_view_navigationbar addSubview:self.view_navi_border];
        
    }
    return _view_navigationbar;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(45, 32 + BASE_VIEW_Y, APPScreenWidth - 90, 20)];
        _label_title.font = __font(18);
        _label_title.textColor = __color_white;
        _label_title.textAlignment = NSTextAlignmentCenter;
        _label_title.text = @"课程";
    }
    return _label_title;
}

- (UIButton *)button_back
{
    if (!_button_back) {
        _button_back = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_back.frame = CGRectMake(10, 10 + 21 + BASE_VIEW_Y, 30, 30);
        [_button_back setImage:ImageNamed(@"back_white") forState:UIControlStateNormal];
        [_button_back addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_back;
}

- (void)action_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)button_fav
{
    if (!_button_fav) {
        _button_fav = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_fav.frame = CGRectMake(APPScreenWidth - 35, 9 + 20 + BASE_VIEW_Y, 22, 22);
        [_button_fav setImage:ImageNamed(@"icon_heart_n") forState:UIControlStateNormal];
        [_button_fav setImage:ImageNamed(@"heart_h") forState:UIControlStateHighlighted];
//        [_button_fav addTarget:self action:@selector(___action_fav) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_fav;
}

- (UIView *)view_navi_border
{
    if (!_view_navi_border) {
        _view_navi_border = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5 + 20 + BASE_VIEW_Y, APPScreenWidth, 0.5)];
        _view_navi_border.backgroundColor = __color_gray_separator;
    }
    return _view_navi_border;
}

#pragma mark headers

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, STUDY_HEADER_HEIGHT + 10)];
        _header.backgroundColor = __color_gray_background;
        [_header addSubview:self.view_empty];
        [_header addSubview:self.view_current];
    }
    return _header;
}

- (UIView *)view_empty
{
    if (!_view_empty) {
        _view_empty = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, STUDY_HEADER_HEIGHT)];
        _view_empty.backgroundColor = __color_white;
        [_view_empty addSubview:self.label_empty];
        [_view_empty addSubview:self.imageview_empty];
        _view_empty.hidden = YES;
    }
    return _view_empty;
}

- (UIImageView *)imageview_empty
{
    if (!_imageview_empty) {
        _imageview_empty = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 145, 180)];
        _imageview_empty.image = [UIImage imageNamed:@"empty_piano"];
    }
    return _imageview_empty;
}

- (UILabel *)label_empty
{
    if (!_label_empty) {
        _label_empty = [[UILabel alloc] initWithFrame:CGRectMake(165, (STUDY_HEADER_HEIGHT - 30) / 2, APPScreenWidth - 165, 30)];
        _label_empty.textColor = __color_font_subtitle;
        _label_empty.font = __font(14);
        _label_empty.textAlignment = NSTextAlignmentCenter;
        _label_empty.text = @"开始第一次练习吧";
    }
    return _label_empty;
}

- (NSMutableArray *)array_empty
{
    if (!_array_empty) {
        NSArray *array = @[@"", @"", @""];
        _array_empty = [NSMutableArray arrayWithArray:array];
    }
    return _array_empty;
}

- (UIView *)view_current
{
    if (!_view_current) {
        _view_current = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, STUDY_HEADER_HEIGHT)];
        _view_current.backgroundColor = __color_white;
        _view_current.hidden = YES;
    }
    return _view_current;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = __color_gray_separator;
        _tableView.backgroundColor = __color_white;
    }
    return _tableView;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > NAVBAR_CHANGE_POINT) {
//        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//        self.view_navigationbar.alpha = alpha;
//    } else {
//        self.view_navigationbar.alpha = 0;
//    }
//}

- (NSMutableArray *)array_data_chapter
{
    if (!_array_data_chapter) {
        _array_data_chapter = [NSMutableArray array];
    }
    return _array_data_chapter;
}


#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == TABLEVIEW_TITLE || section == TABLEVIEW_CONTENT) {
        return 1;
    } else {
        return [self.array_data_chapter count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TABLEVIEW_TITLE) {
        return STUDY_HEADER_HEIGHT;
    } else if (indexPath.section == TABLEVIEW_CONTENT) {
        NSString *content = [self.dictionary_data stringForKey:@"content"];
        NSString *cutString = @"";
        if (content.length > 200) {
            cutString = [NSString stringWithFormat:@"%@...", [content substringToIndex:200]];
            CGFloat height = [self __caclute_height:cutString lineSpace:SIGHT_DETAIL_LINESPACE  Font:__font(16)] + 85;
            return height;
        } else {
            CGFloat height = [self __caclute_height:content lineSpace:SIGHT_DETAIL_LINESPACE  Font:__font(16)] + 30;
            return height;
        }
        
    } else {
        return 80;
    }
}

- (CGFloat)__caclute_height:(NSString *)string lineSpace:(CGFloat)linespace Font:(UIFont *)font
{
    CGFloat label_height = [UILabel text:string font:font width:APPScreenWidth - 20 lineSpacing:linespace];
    return label_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.01)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TABLEVIEW_TITLE) {
        static NSString *identifier = @"banner_cell";
        CourseBannerCell *cell  =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CourseBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.button_avatar.tag = [[[self.dictionary_data dictionaryForKey:@"teacher_info"] stringForKey:@"id"] integerValue];
        [cell.button_avatar addTarget:self action:@selector(action_teacher:) forControlEvents:UIControlEventTouchUpInside];
        [cell bindData:self.dictionary_data];
        return cell;
    } else if (indexPath.section == TABLEVIEW_CONTENT) {
        return [self __cellSubtitle:tableView];
    }
    static NSString *identifier = @"trianlistcell";
    StudyListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[StudyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *course = [self.array_data_chapter objectAtIndex:indexPath.row];
    [cell bindData:course];
    return cell;
}

- (UITableViewCell *)__cellSubtitle:(UITableView *)tableView
{
    static NSString *detailcell = @"briefcell";
    SightBriefCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[SightBriefCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    NSString *string = [self.dictionary_data stringForKey:@"content"];
    NSString *cutString = @"";
    if (string.length > 200) {
        cutString = [NSString stringWithFormat:@"%@...", [string substringToIndex:200]];
        cell.button.hidden = NO;
    } else {
        cell.button.hidden = YES;
        cutString = string;
    }
    cell.label.width = APPScreenWidth - 30;
    [cell.label setText:cutString lineSpacing:SIGHT_DETAIL_LINESPACE];
    [cell.label sizeToFit];
    cell.button.top = cell.label.bottom + 15;
    //    cell.view_border.top = cell.button.bottom + 15;
    [cell.button addTarget:self action:@selector(___action_readmore) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)action_teacher:(UIButton *)button
{
    NSInteger teacher_id = button.tag;
    GuideViewController *profile = [[GuideViewController alloc] init];
    profile.string_user_id = [NSString stringWithFormat:@"%ld", teacher_id];
    [self.navigationController pushViewController:profile animated:YES];
}

- (void)___action_readmore
{
    SightBriefViewController *brief = [[SightBriefViewController alloc] init];
    UIImage *image = [self takeSnapshotOfView:self.navigationController.view];
    UIImage *image_effects = [UIImageEffects imageByApplyingLightEffectToImage:image];
    brief.image = image_effects;
    NSString *string = [self.dictionary_data stringForKey:@"content"];
    [brief bindData:string];
    brief.title = @"详细";
    [self.navigationController pushViewController:brief animated:YES];
}

- (UIImage *)takeSnapshotOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(CGSizeMake(APPFullScreenWidth, APPFullScreenHeight));
    [view drawViewHierarchyInRect:CGRectMake(0, 0, APPFullScreenWidth, APPFullScreenHeight) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProcessPlayerViewController *videocontroller = [[ProcessPlayerViewController alloc] init];
//    NSDictionary *dic = [self.array_data objectAtIndex:indexPath.row];
    videocontroller.video_url = @"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4";
    [self.navigationController pushViewController:videocontroller animated:YES];
}

- (void)fetch_course_info
{
    NSString *url = [NSString stringWithFormat:@"%@/course/info?id=%@", SERVER_DOMAIN, self.course_id];
    //    NSDictionary *dic = @{@"user_id": [BaseUser instance].user_id};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@------------", tempDic);
        [weakSelf.tableView.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *dictionary = [tempDic dictionaryForKey:@"data"];
            if ([[dictionary allKeys] count] > 0) {
                weakSelf.dictionary_data = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
                weakSelf.array_data_chapter = [NSMutableArray arrayWithArray:[dictionary arrayForKey:@"chapter"]];
                [weakSelf.tableView reloadData];
            } else {
                [weakSelf hud_textonly:RESPONSE_NONE];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

@end
