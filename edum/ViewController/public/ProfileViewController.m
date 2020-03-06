//
//  ProfileViewController.m
//  edum
//
//  Created by Kevin Chan on 26/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "ProfileViewController.h"

#import "BaseUser.h"
#import "AvatarView.h"
#import "GeneralHeaderView.h"
#import "PlainTextCell.h"
#import "UILabel+LineSpace.h"

#define SECTION_HEIGHT 60
#define LINE_SPACE 7

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array_data;
@property (nonatomic, strong) AvatarView *header;
@property (nonatomic, strong) UIButton *button_back;
@property (nonatomic, strong) UIButton *button_calendar;

@property (nonatomic, strong) UIView *footer;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
    [self.view insertSubview:self.tableView atIndex:12];
    [self.view insertSubview:self.button_back atIndex:999];
    [self.view insertSubview:self.button_calendar atIndex:100];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self headview_status];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -(AdaptNaviHeight + BASE_VIEW_Y), APPScreenWidth, APPScreenHeight - 59) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (UIButton *)button_back
{
    if (!_button_back) {
        _button_back = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_back.frame = CGRectMake(15, AdaptNaviHeight + 15, 30, 30);
        [_button_back setImage:ImageNamed(@"back_arrow") forState:UIControlStateNormal];
        [_button_back addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_back;
}

- (void)action_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)button_calendar
{
    if (!_button_calendar) {
        _button_calendar = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_calendar.frame = CGRectMake(30, APPScreenHeight - 44 - SafeAreaBottomHeight, APPScreenWidth - 60, 44);
        _button_calendar.layer.cornerRadius = 22;
        _button_calendar.layer.masksToBounds = YES;
        [_button_calendar setTitle:@"课程预约" forState:UIControlStateNormal];
        [_button_calendar setTitleColor:__color_white forState:UIControlStateNormal];
        _button_calendar.layer.backgroundColor = [__color_main CGColor];
        [_button_calendar addTarget:self action:@selector(action_calendar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_calendar;
}

- (void)action_calendar
{
    
}

- (AvatarView *)header
{
    if (!_header) {
        _header = [[AvatarView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenWidth / 2)];
        [_header.button addTarget:self action:@selector(action_avatar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _header;
}

- (void)action_avatar
{
    //TODO 大头像
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
    NSString *text = [data stringForKey:@"content"];
    CGFloat height = [UILabel text:text font:__font(18) width:APPScreenWidth - 30 lineSpacing:LINE_SPACE];
     return height + 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headviewIdentifier";
    GeneralHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!view) {
        view = [[GeneralHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
        view.frame = CGRectMake(0, 0, APPScreenWidth, SECTION_HEIGHT);
        view.image_accessory.hidden = YES;
    }
    NSDictionary *data = [self.array_data objectAtIndex:section];
    [view.label setText:[data stringForKey:@"title"] lineSpacing:3];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.1)];
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
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSDictionary *data = [self.array_data objectAtIndex:indexPath.section];
    cell.label_text.width = APPScreenWidth - 30;
    [cell.label_text setText:[data stringForKey:@"content"] lineSpacing:LINE_SPACE];
    [cell.label_text sizeToFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray *)array_data
{
    if (!_array_data) {
        NSArray *array = @[
          @{@"title": @"个人经历", @"content": @"郎朗（Lang Lang），1982年6月14日出生于辽宁省沈阳市沈河区，中国钢琴演奏者，联合国和平使者，毕业于美国柯蒂斯音乐学院。"},
          @{@"title": @"个人信息", @"content": @"1997年12月，郎朗与IMG经纪公司签约，开启了职业演出生涯 [1]  。1999年8月，参加美国芝加哥“拉维尼亚音乐节”世纪庆典明星音乐会，作为替补登台演奏 [2]  。2001年，在人民大会堂进行100周年百年庆典巡演 [3]  。2002年，获得伯恩斯坦艺术成就大奖 [4]  。2003年，推出个人钢琴演奏专辑《柴可夫斯基/门德尔松协奏曲名录》 [5]  。2005年，在白宫举行个人专场独奏会 [6]  。2006年，推出个人钢琴演奏专辑《黄河之子》。2008年，获得美国录音师协会颁发的“艺术荣誉奖”。2010年，获得国际门德尔松大奖，成为首位获得该奖项的中国人 [7]  。2011年，举行了“弗朗茨·李斯特诞辰200周年郎朗现场音乐会” [8]  。2013年，参加维也纳音乐厅100周年音乐季，并应邀举行了两场音乐会 [9]  ；同年，获得“全英古典音乐奖”年度国际艺术家奖；同年10月28日，在纽约联合国总部，联合国秘书长潘基文向郎朗授予了“联合国和平使者”称号 [10]  。2015年，凭借专辑《莫扎特》获得“德国古典回声大奖颁奖典礼”年度器乐演奏家大奖（钢琴类） [11]  。2016年，推出首张个人跨界专辑《纽约狂想曲》 [12]  。2017年8月27日，获得亚洲新歌榜年度盛典音乐视频杰出贡献奖 [13]  ；12月8日，获得“商业星力量巅峰人物年度盛典”年度实力音乐人奖 [14]  。2019年，获得“法国胜利大奖”，成为首位中国获奖者 [15]  ；2月25日，发布个人钢琴演奏专辑《钢琴书》 [16]  。"},
          @{@"title": @"演绎经历", @"content": @" ；同年9月16日，推出首张个人跨界专辑《纽约狂想曲》，专辑中的10首歌曲分别改编自地下丝绒乐队、老鹰乐队、Jay-Z等歌手的作品，涵盖了古典、爵士、百老汇、摇滚、嘻哈等风格 [12]  ；同年9月25日，与波士顿交响乐团合作举行了“2016-2017音乐季开季音乐会” [69]  ；同年10月10日，在中华人民共和国驻纽约总领事馆，为潘基文举行了独奏音乐会 [70]  。2017年1月，参加湖南卫视小年夜春晚，并与李玟合作演绎了歌曲《18》、《Happy》 [71]  ；随后，参加辽宁卫视春节联欢晚会，并为开场歌舞《家国年·吉祥颂》进行钢琴演奏 [72]  ；2月8日，与环球音乐集团（Universal Music Group）在美国洛杉矶签署长期录音合约 [73]  ；5月5日，郎朗在巴黎Grevin格雷万蜡像馆出席自己的蜡像揭幕仪式 [74]  ；7月20日，其专辑《纽约狂想曲》获得首届唱工委CMA音乐颁奖盛典最佳古典音乐专辑奖 [75]  ；8月27日，获得亚洲新歌榜年度盛典音乐视频杰出贡献奖 [13]  ；同年，被选为美国智库大西洋理事会授予的“2017全球公民奖”获奖者 [76]。"},
          @{@"title": @"个人生活", @"content": @"郎朗的祖父当过师范学校的音乐教师，他的父亲郎国任是文艺兵，在部队里做过专业的二胡演员，退伍后进入沈阳市公安局工作 [91]  ，他的母亲周秀兰在中国科学院沈阳自动化研究所总机工作，负责整个总机房的维修、服务和转接。"}
        ];
        _array_data = [[NSArray alloc] initWithArray:array];
    }
    return _array_data;
}

- (void)headview_status
{
    if ([BASEUSER loginstatus]) {
        
        NSString *avatar_url = @"";
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
        self.header.label_name.text = BASEUSER.nickname;
        self.header.label_name.hidden = NO;
    } else {
        
        self.header.imageview_avatar.hidden = NO;
        self.header.view_avatar.hidden = NO;
        self.header.imageview_avatar.image = ImageNamed(@"logo_launch");
        self.header.label_name.hidden = NO;
        self.header.label_name.text = @"张天一";
        self.tableView.tableHeaderView = self.header;
        [self.tableView reloadData];
    }
}


@end
