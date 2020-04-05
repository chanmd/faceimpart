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
#import "HMSegmentedControl.h"

#pragma cells
#import "CourseHeaderView.h"
#import "CourseBriefCell.h"
#import "CourseContentCell.h"
#import "CourseBriefDetailViewController.h"
#import "PaymentViewController.h"

#define NAVBAR_CHANGE_POINT 50
#define PADDING_OFFSET_X -50


@interface CourseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dict_data;
@property (nonatomic, strong) NSMutableArray *array_data_content;

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
    [self.view addSubview:self.tableView];
    [self __init_test_data];
    self.selectedIndex = 1;
    [self.tableView reloadData];
    [self.header.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.view_border];
    [self.view addSubview:self.view_buy];
    [self.view addSubview:self.view_arrange];
//    self.view_buy.hidden = YES;
//    self.view_arrange.hidden = NO;
    
}

- (void)segmentedControlChangedValue
{
    self.selectedIndex = self.header.segmentedControl.selectedSegmentIndex + 1;
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_clear;
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}

- (CourseHeaderView *)header
{
    if (!_header) {
        _header = [[CourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 184 + 44)];
        [_header bindDict:@{}];
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
        _label_brief.text = @"共3章，7节课";
    }
    return _label_brief;
}

- (void)__init_test_data
{
    NSArray *content =@[@{@"title": @"第一组", @"subtitle": @"长弓练习", @"content": @"一弓四拍，一共24小节"}, @{@"title": @"第二组", @"subtitle": @"分弓练习 一弓一拍，20小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节"}, @{@"title": @"第三组", @"subtitle": @"快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节快速换弓练习 一弓16分音符，16小节"}];
    self.array_data_content = [NSMutableArray arrayWithArray:content];
    
    NSDictionary *dict = @{@"title": @"C大调音阶练习", @"subtitle": @"音阶的练习既是音准练习的必修课，同时也是视作流畅的左手练习的重要教材。\n\n这正是为什么全世界弦乐工作者反复强调音阶重要性的原因，作为大提琴学生，学习大提琴，目的是为了更完美的将大提琴美好的音质传递给观众。因此对学习过程中所面临的技巧问题，诸如音阶的掌握程度，直接关系到演奏水平的发挥。\n\n音阶的基本功愈扎实，其表现的音乐愈准确且流畅。\n\n著名小提琴家海菲兹曾说：“技巧的解决之时，才是音乐的开始。”这也充分证明了技巧的重要性。音阶既然是技巧的重要组成部分之一，我们在学习中应树立正确的观念和做好长期艰苦训练的打算，从小培养准、匀、美的高标准和高质量发音要求，既要高度重视音阶的音准，也要高质量的要求发音圆润的大提琴音质以及连贯性，动听的旋律表现效果，从准备好听方面严格要求，并通过长期的历练从而获得表现音乐美的良好手段，这也是我们大提琴演奏者追求的最终目的。\n\n我们知道音乐是表现情感的艺术，有了坚实的技术支撑，尤其是在音阶技术有保障的情况下，我们更能由哀的表达各自内心的情感，今后无论演奏任何作品均可更得心应手。\n\n因为无论任何作品尤其像奏鸣曲、协奏曲及组曲类作品其基本音乐语言包含了太多的音阶、双音琶音等一系列基础音乐语汇，这些乐音的表达需要有稳定和谐的音准去体现音乐的意味和音乐流动的自然度，如果我们拥有坚实的音准把握度和良好的发音感方可运筹帷幄地去实现作品的内涵，风格和情感的表达意义，其诠释的作品更具有匀、准、美的审美意义，换句话说演奏的作品更能打动观众的心，因此我认为音阶学习是大提琴学生必须高度重视的课题。\n\n作为教师应从小培养他们主动学习音阶的意识，并逐步让他们认识到音准及发音的基本标准。从概念到意识上帮助他们建立起良好的审美标准和正确的演奏动势，这样有助于学生们在学习的道路上走的更高、更宽、更远，并充分施展自己的才华。"};
    self.dict_data = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    self.label_price.text = @"¥3033";
    [self.label_price sizeToFit];
    self.label_price_fake.centerY = self.label_price.centerY;
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥39999" attributes:attribtDic];
    self.label_price_fake.attributedText = attribtStr;
    self.label_price_fake.left = self.label_price.right + 5;
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
        _view_buy = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 49 - SafeAreaBottomHeight, APPScreenWidth, 49 + SafeAreaBottomHeight)];
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
        _label_price = [[UILabel alloc] initWithFrame:CGRectMake(30, 6, 120, 36)];
        _label_price.textColor = __color_main;
        _label_price.font = __font(24);
    }
    return _label_price;
}


- (UILabel *)label_price_fake
{
    if (!_label_price_fake) {
        _label_price_fake = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 120, 36)];
        _label_price_fake.textColor = __color_font_subtitle;
        _label_price_fake.font = __font(18);
    }
    return _label_price_fake;
}


- (UIButton *)button_buy
{
    if (!_button_buy) {
        _button_buy = [[UIButton alloc] initWithFrame:CGRectMake(APPScreenWidth - 15 - 120, 6, 120, 36)];
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
        _view_arrange = [[UIView alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 49 - SafeAreaBottomHeight, APPScreenWidth, 49)];
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
        _label_status = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, APPScreenWidth - 15 - 120, 36)];
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
        _button_arrangement = [[UIButton alloc] initWithFrame:CGRectMake(APPScreenWidth - 15 - 120, 6, 120, 36)];
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


#pragma mark - tableiview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectedIndex == 1) {
        return 1;
    } else {
        return [self.array_data_content count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        return [self __cell_brief:tableView];
    } else {
        return [self __cell_category:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndex == 1) {
        return [self __calculate_height_brief:[self.dict_data stringForKey:@"subtitle"]];
    } else {
        return [self __calculate_height_content:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.selectedIndex == 2) {
        return 44.f;
    } else {
        return 0.1f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.1)];
    view.backgroundColor = __color_gray_background;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.selectedIndex == 2) {
        return self.briefview;
    }
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
}

#pragma mark heights

- (CGFloat)__calculate_height_brief:(NSString *)brief
{
    CGFloat height = [UILabel text:brief font:__fontlight(18) width:APPScreenWidth - 40 lineSpacing:5];
    return height + 65;
}

- (CGFloat)__calculate_height_content:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.array_data_content objectAtIndex:indexPath.row];
    NSString *content = [dic stringForKey:@"subtitle"];
    CGFloat label_height = [UILabel text:content font:__fontthin(16) width:APPScreenWidth - 40 lineSpacing:5];
    CGFloat height = label_height + 90;
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
    [cell bindData:self.dict_data];
    return cell;
}

- (UITableViewCell *)__cell_category:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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


- (void)action_buy
{
    if (![BASEUSER loginstatus]) {
        
        PaymentViewController *payment = [[PaymentViewController alloc] init];
//        payment.course_id = self.course_id;
        payment.course_id = @"13424243";
        [self.navigationController pushViewController:payment animated:YES];
        
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
