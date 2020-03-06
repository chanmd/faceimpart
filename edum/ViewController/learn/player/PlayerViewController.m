//
//  PlayerViewController.m
//  edum
//
//  Created by Kevin Chan on 18/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "PlayerViewController.h"
#import "ZFTableHeaderView.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFIJKPlayerManager.h>
#import "ZFPlayerDetailViewController.h"
#import "ZFTableData.h"
#import "ZFOtherCell.h"

static NSString *kIdentifier = @"kIdentifier";

@interface PlayerViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZFTableHeaderView *headerView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) ZFTableData *video_data;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self requestData];
    
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*9/16);
    
    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.headerView.coverImageView];
    self.player.controlView = self.controlView;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
        [UIViewController attemptRotationToDeviceOrientation];
        self.tableView.scrollsToTop = !isFullScreen;
    };
    
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player stopCurrentPlayingCell];
    };
}

- (void)requestData {
    self.dataSource = @[].mutableCopy;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *videoList = [rootDict objectForKey:@"list"];
    for (NSDictionary *dataDic in videoList) {
        ZFTableData *data = [[ZFTableData alloc] init];
        [data setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:data];
    }
}

- (ZFTableData *)video_data
{
    if (!_video_data) {
        _video_data = [[ZFTableData alloc] init];
    }
    return _video_data;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat h = CGRectGetMaxY(self.view.frame);
    self.tableView.frame = CGRectMake(0, y, self.view.frame.size.width, h-y);
}

- (BOOL)shouldAutorotate {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheIndex:indexPath.row];
}

#pragma mark - private

- (void)playTheIndex:(NSInteger)index {
    /// 在这里判断能否播放。。。
    ZFTableData *data = self.dataSource[index];
    self.player.currentPlayerManager.assetURL = [NSURL URLWithString:data.video_url];
    [self.controlView showTitle:data.title coverURLString:data.thumbnail_url fullScreenMode:ZFFullScreenModeLandscape];
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[ZFOtherCell class] forCellReuseIdentifier:kIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.rowHeight = 100;
    }
    return _tableView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
    }
    return _controlView;
}

- (ZFTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[ZFTableHeaderView alloc] init];
        @weakify(self)
        _headerView.playCallback = ^{
            @strongify(self)
            [self playTheIndex:0];
        };
    }
    return _headerView;
}

- (void)request_video_info
{
    NSString *url = [NSString stringWithFormat:@"%@/course/videoinfo?id=%@", SERVER_DOMAIN, self.video_id];
    //    NSDictionary *dic = @{@"user_id": [BaseUser instance].user_id};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            //            weakSelf.pager.total = [[tempDic stringIntForKey:@"total"] integerValue];
            NSDictionary *dictionary = (NSDictionary *)[tempDic objectForKey:@"data"];
            if ([[dictionary allKeys] count] > 0) {
                weakSelf.dictionary_data = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
//                ZFTableData *data = [[ZFTableData alloc] init];
                [weakSelf.video_data setValuesForKeysWithDictionary:dictionary];
                [weakSelf.tableView reloadData];
            } else {
                [weakSelf hud_textonly:RESPONSE_NONE];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

@end
