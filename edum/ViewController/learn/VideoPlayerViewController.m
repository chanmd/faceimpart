//
//  VideoPlayerViewController.m
//  edum
//
//  Created by Md Chen on 11/9/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "VideoPlayerViewController.h"
//#import <SuperPlayer/SuperPlayer.h>
#import "NSDictionary+JSONExtern.h"

@interface VideoPlayerViewController () <SuperPlayerDelegate>

@property (nonatomic, strong) SuperPlayerView *playerview;
@property (nonatomic, strong) SuperPlayerModel *playermodel;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.canvas];
//    [self.view addSubview:self.button_close];
    // Do any additional setup after loading the view.
    self.playermodel.videoURL = [self.data stringForKey:@"video_url"];
    [self.playerview playWithModel:self.playermodel];
    
    [self performSelector:@selector(back_action) withObject:nil afterDelay:0.5];
    
}

- (void)back_action
{
    [self.playerview addObserver:self forKeyPath:@"isLockScreen" options:(NSKeyValueObservingOptionOld) context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isLockScreen"]) {
        if (self.playerview.isFullScreen) {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

- (void)dealloc
{
    [self.playerview removeObserver:self forKeyPath:@"isLockScreen"];
}

- (SuperPlayerView *)playerview
{
    if (!_playerview) {
        _playerview = [[SuperPlayerView alloc] init];
        _playerview.fatherView = self.canvas;
        [_playerview setFullScreen:YES];
        _playerview.delegate = self;
    }
    return _playerview;
}

- (SuperPlayerModel *)playermodel
{
    if (!_playermodel) {
        _playermodel = [[SuperPlayerModel alloc] init];
    }
    return _playermodel;
}

- (UIView *)canvas
{
    if (!_canvas) {
        _canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight)];
        _canvas.backgroundColor = __color_clear;
    }
    return _canvas;
}

- (UIButton *)button_close
{
    if (!_button_close) {
        _button_close = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_close.frame = CGRectMake(10, 20, 40, 40);
        [_button_close setImage:ImageNamed(@"view_cancel") forState:UIControlStateNormal];
    }
    return _button_close;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    self.navigationController.navigationBar.hidden = YES;
//        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    [MobClick beginLogPageView:@"sight"];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //    [self.navigationController.navigationBar lt_reset];
    
    
    //    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:__color_gray_separator]];
    //    [MobClick endLogPageView:@"sight"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (NSDictionary *)data
{
    if (!_data) {
        _data = [NSDictionary dictionary];
    }
    return _data;
}

- (void)superPlayerFullScreenChanged:(SuperPlayerView *)player
{
    if (!player.isFullScreen) {
        [player resetPlayer];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
