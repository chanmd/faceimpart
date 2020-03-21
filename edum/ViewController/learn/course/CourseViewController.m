//
//  CourseViewController.m
//  edum
//
//  Created by Kevin Chan on 26/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "CourseViewController.h"

#pragma utils
#import "NSDictionary+JSONExtern.h"
#import "UILabel+LineSpace.h"
#import "UIImageEffects.h"

#pragma cells
#import "CourseTitleCell.h"
#import "CourseDetailBriefCell.h"
#import "CourseContentBriefCell.h"
#import "CourseContentCell.h"
#import "CourseBriefDetailViewController.h"


#define NAVBAR_CHANGE_POINT 50
#define PADDING_OFFSET_X -50

#define TABLEVIEW_TITLE 0
#define TABLEVIEW_BRIEF 1
#define TABLEVIEW_CONTENT 2
#define TABLEVOEW_ALL 3

@interface CourseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dict_data;
@property (nonatomic, strong) NSMutableArray *array_data_brief;
@property (nonatomic, strong) NSMutableArray *array_data_content;

@end

@implementation CourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view insertSubview:self.tableView atIndex:1];
    [self __init_test_data];
    [self.tableView reloadData];
}

- (void)__init_test_data
{
    NSArray *brief = @[@{@"title": @"时间", @"content": @"20分钟"}, @{@"title": @"难度", @"content": @"★★★"}, @{@"title": @"调号", @"content": @"C大调"}];
    [self.array_data_brief addObjectsFromArray:brief];
    
    NSArray *content =@[@{@"title": @"第一组", @"subtitle": @"长弓练习", @"content": @"一弓四拍，一共24小节"}, @{@"title": @"第二组", @"subtitle": @"分弓练习", @"content": @"一弓一拍，20小节"}, @{@"title": @"第三组", @"subtitle": @"快速换弓练习", @"content": @"一弓16分音符，16小节"}];
    [self.array_data_content addObjectsFromArray:content];
    
    NSDictionary *dict = @{@"title": @"C大调音阶练习", @"subtitle": @"音阶的练习既是音准练习的必修课，同时也是视作流畅的左手练习的重要教材。这正是为什么全世界弦乐工作者反复强调音阶重要性的原因，作为大提琴学生，学习大提琴，目的是为了更完美的将大提琴美好的音质传递给观众。因此对学习过程中所面临的技巧问题，诸如音阶的掌握程度，直接关系到演奏水平的发挥。音阶的基本功愈扎实，其表现的音乐愈准确且流畅。著名小提琴家海菲兹曾说：“技巧的解决之时，才是音乐的开始。”这也充分证明了技巧的重要性。音阶既然是技巧的重要组成部分之一，我们在学习中应树立正确的观念和做好长期艰苦训练的打算，从小培养准、匀、美的高标准和高质量发音要求，既要高度重视音阶的音准，也要高质量的要求发音圆润的大提琴音质以及连贯性，动听的旋律表现效果，从准备好听方面严格要求，并通过长期的历练从而获得表现音乐美的良好手段，这也是我们大提琴演奏者追求的最终目的。\n我们知道音乐是表现情感的艺术，有了坚实的技术支撑，尤其是在音阶技术有保障的情况下，我们更能由哀的表达各自内心的情感，今后无论演奏任何作品均可更得心应手。因为无论任何作品尤其像奏鸣曲、协奏曲及组曲类作品其基本音乐语言包含了太多的音阶、双音琶音等一系列基础音乐语汇，这些乐音的表达需要有稳定和谐的音准去体现音乐的意味和音乐流动的自然度，如果我们拥有坚实的音准把握度和良好的发音感方可运筹帷幄地去实现作品的内涵，风格和情感的表达意义，其诠释的作品更具有匀、准、美的审美意义，换句话说演奏的作品更能打动观众的心，因此我认为音阶学习是大提琴学生必须高度重视的课题。作为教师应从小培养他们主动学习音阶的意识，并逐步让他们认识到音准及发音的基本标准。从概念到意识上帮助他们建立起良好的审美标准和正确的演奏动势，这样有助于学生们在学习的道路上走的更高、更宽、更远，并充分施展自己的才华。"};
    [self.dict_data setObject:dict forKey:@"brief"];
    
    
}

- (void)action_goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)dict_data
{
    if (!_dict_data) {
        _dict_data = [NSMutableDictionary dictionary];
    }
    return _dict_data;
}

- (NSMutableArray *)array_data_brief
{
    if (!_array_data_brief) {
        _array_data_brief = [NSMutableArray array];
    }
    return _array_data_brief;
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
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
//        self.view_navigationbar.alpha = alpha;
    } else {
//        self.view_navigationbar.alpha = 0;
    }
}


#pragma mark - tableiview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLEVOEW_ALL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == TABLEVIEW_TITLE) {
        
        return 1;
    }
    if (section == TABLEVIEW_BRIEF) {
        
        return [self.array_data_brief count];
        
    } else if (section == TABLEVIEW_CONTENT) {
        
        return [self.array_data_content count];
        
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TABLEVIEW_TITLE) {
        
        return [self __cell_banner:tableView];
        
    } else if (indexPath.section == TABLEVIEW_BRIEF) {
        
        return [self __cell_brief:tableView indexPath:indexPath];
        
    } else if (indexPath.section == TABLEVIEW_CONTENT) {
        
        return [self __cell_detail:tableView cellForRowAtIndexPath:indexPath];
        
    } else {
        
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == TABLEVIEW_TITLE) {
        return 64 + 60; 
        
    } else if (indexPath.section == TABLEVIEW_BRIEF) {
        
        return [self __calculate_height_brief];
        
    } else if (indexPath.section == TABLEVIEW_CONTENT) {
        
        return [self __calculate_height_content];
        
    } else {
        
        return 44.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == TABLEVIEW_CONTENT) {
        return 44.f;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == TABLEVIEW_CONTENT) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 50)];
        view.backgroundColor = __color_white;
        UILabel *label_temp = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, APPScreenWidth - 20, 20)];
        label_temp.font = __font(16);
        label_temp.textColor = __color_font_title;
        label_temp.text = @"练习内容";
        [view addSubview:label_temp];
        return view;
    }
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
}

#pragma mark heights

- (CGFloat)__calculate_height_title:(NSDictionary *)dic
{
    NSString *title = [dic stringForKey:@"title"];
    NSString *subtitle = [dic stringForKey:@"subtitle"];
    NSString *cutString = @"";
    if ([dic stringForKey:@"subtitle"].length > 100) {
        cutString = [NSString stringWithFormat:@"%@...", [subtitle substringToIndex:100]];
    }
    
    CGFloat title_label_height = [UILabel text:title font:__fontbold(22) width:APPScreenWidth - 30 lineSpacing:2];
    CGFloat subtitle_label_height = [UILabel text:cutString font:__font(16) width:APPScreenWidth - 30 lineSpacing:SIGHT_DETAIL_LINESPACE];
    return 20 + title_label_height + 10 + subtitle_label_height + 20 + 20 + 20;
}

- (CGFloat)__calculate_height_brief
{
    return 44.f;
}

- (CGFloat)__calculate_height_content
{
    return 100;
}

- (CGFloat)__calculate_height_title:(NSString *)string lineSpace:(CGFloat)linespace Font:(UIFont *)font
{
    CGFloat label_height = [UILabel text:string font:font width:APPScreenWidth - 20 lineSpacing:linespace];
    return label_height;
}

- (CGFloat)__calculate_height_contentt:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.array_data_brief objectAtIndex:indexPath.row];
    NSString *content = [dic stringForKey:@"content"];
    CGFloat label_height = [UILabel text:content font:__font(18) width:APPScreenWidth - 20 lineSpacing:SIGHT_DETAIL_LINESPACE];
    CGFloat height = label_height + 60;
    return height;
}

#pragma mark cells

- (UITableViewCell *)__cell_banner:(UITableView *)tableView
{
    static NSString *bannercellID = @"bannercell";
    CourseTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:bannercellID];
    if (!cell) {
        cell = [[CourseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bannercellID];
    }
    NSDictionary *brief = [self.dict_data dictionaryForKey:@"brief"];
    [cell bindDict:brief];
    return cell;
}

- (void)___action_readmore
{
    CourseBriefDetailViewController *brief = [[CourseBriefDetailViewController alloc] init];
    UIImage *image = [self takeSnapshotOfView:self.navigationController.view];
    UIImage *image_effects = [UIImageEffects imageByApplyingLightEffectToImage:image];
    brief.image = image_effects;
    NSString *string = [[self.dict_data dictionaryForKey:@"brief"] stringForKey:@"subtitle"];
    [brief bindData:string];
    brief.title = @"更多";
    [self presentViewController:brief animated:YES completion:nil];
}

- (UITableViewCell *)__cell_brief:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString *detailcell = @"briefcell";
    CourseDetailBriefCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseDetailBriefCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    NSDictionary *dic = [self.array_data_brief objectAtIndex:indexPath.row];
    [cell bindDict:dic];
    return cell;
}

- (UITableViewCell *)__cell_detail:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailcell = @"detailcell";
    CourseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:detailcell];
    if (!cell) {
        cell = [[CourseContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailcell];
    }
    NSDictionary *dic = [self.array_data_content objectAtIndex:indexPath.row];
    [cell bindDict:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - actions


- (void)___action_buy
{
    if ([BASEUSER loginstatus]) {
        
        /*
        SightCalCheckViewController *calcheck = [[SightCalCheckViewController alloc] init];
        calcheck.array_data = [self.dict_data arrayForKey:@"calendar"];
        calcheck.dict_package = self.dict_data;
        //    WeakSelf;
        //    calcheck.block = ^void(NSMutableDictionary *selectedDate){
        //        [weakSelf performSelector:@selector(___action_order) withObject:nil afterDelay:0.8];
        //    };
        [self.navigationController pushViewController:calcheck animated:YES];
         */
        
    } else {
        [self action_login];
    }
}

- (void)action_login
{
//    LoginViewController *login = [[LoginViewController alloc] init];
//    [self presentViewController:login animated:YES completion:nil];
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

- (void)___fetch_sights
{
    [self hud_show];
    NSString *url = [NSString stringWithFormat:@"%@/package", SERVER_DOMAIN];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"package_id" forKey:@"package_id"];
    if ([BASEUSER loginstatus]) {
        [dict setValue:[BaseUser instance].user_id forKey:@"user_id"];
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        [self hud_hide];
        NSLog(@"--------------------------------------------------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *dict = [tempDic dictionaryForKey:@"data"];
            if ([dict.allKeys count] > 0) {
                weakSelf.dict_data = [NSMutableDictionary dictionaryWithDictionary:dict];
                
                weakSelf.array_data_content = [weakSelf.dict_data arrayForKey:@"detail"];
                [weakSelf.tableView reloadData];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self hud_hide];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}


@end
