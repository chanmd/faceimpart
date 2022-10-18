//
//  BaseTabbarViewController.m
//  gwlx
//
//  Created by Chan Kevin on 6/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "UIImageEffects.h"
#import "LoginOverseaViewController.h"
//#import "BaseUser.h"

@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = __color_white;
    [self addMyTabbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)addMyTabbar
{
    [self.view addSubview:self.toolbar];
}

- (UIView *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[UIView alloc] initWithFrame:CGRectMake(-0.5, APPFullScreenHeight - 49 - SafeAreaBottomHeight, APPScreenWidth + 1, 49 + SafeAreaBottomHeight)];
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _toolbar.backgroundColor = __color_white;
        _toolbar.layer.borderColor = [__color_gray_background CGColor];
        _toolbar.layer.borderWidth = 0.5f;
        _toolbar.clipsToBounds = YES;
        [_toolbar addSubview:self.button_a];
        [_toolbar addSubview:self.button_b];
        [_toolbar addSubview:self.button_c];
//        [_toolbar addSubview:self.button_d];
        //[_toolbar addSubview:self.button_e];
    }
    return _toolbar;
}

- (UIButton *)button_a
{
    if (!_button_a) {
        _button_a = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_a.frame = CGRectMake(APPScreenWidth / TAB_COUNT * 0, 0, APPScreenWidth / TAB_COUNT, 49);
        [_button_a setImage:ImageNamed(@"landing") forState:UIControlStateNormal];
        [_button_a setImage:ImageNamed(@"landing_highlight") forState:UIControlStateHighlighted];
        _button_a.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _button_a.titleLabel.text = @"首页";
        [_button_a addTarget:self action:@selector(___action_a) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_a;
}

- (UIButton *)button_b
{
    if (!_button_b) {
        _button_b = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_b.frame = CGRectMake(APPScreenWidth / TAB_COUNT * 1, 0, APPScreenWidth / TAB_COUNT, 49);
        [_button_b setImage:ImageNamed(@"calendar") forState:UIControlStateNormal];
        [_button_b setImage:ImageNamed(@"calendar_highlight") forState:UIControlStateHighlighted];
//        _button_b.titleLabel.text = @"课程";
        _button_b.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_button_b addTarget:self action:@selector(___action_b) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_b;
}

- (UIButton *)button_c
{
    if (!_button_c) {
        _button_c = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_c.frame = CGRectMake(APPScreenWidth / TAB_COUNT * 2, 0, APPScreenWidth / TAB_COUNT, 49);
        [_button_c setImage:ImageNamed(@"profile") forState:UIControlStateNormal];
        [_button_c setImage:ImageNamed(@"profile_highlight") forState:UIControlStateHighlighted];
//        _button_c.titleLabel.text = @"我的";
        [_button_c addTarget:self action:@selector(___action_c) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_c;
}

- (UIButton *)button_d
{
    if (!_button_d) {
        _button_d = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_d.frame = CGRectMake(APPScreenWidth / TAB_COUNT * 3, 0, APPScreenWidth / TAB_COUNT, 49);
        [_button_d setImage:ImageNamed(@"tab_bio_n") forState:UIControlStateNormal];
        [_button_d setImage:ImageNamed(@"tab_bio_h") forState:UIControlStateHighlighted];
        [_button_d addTarget:self action:@selector(___action_d) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_d;
}

- (UIButton *)button_e
{
    if (!_button_e) {
        _button_e = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_e.frame = CGRectMake(APPScreenWidth / TAB_COUNT * 4, 0, APPScreenWidth / TAB_COUNT, 49);
        [_button_e setImage:ImageNamed(@"tab_profile_n") forState:UIControlStateNormal];
        [_button_e setImage:ImageNamed(@"tab_profile_h") forState:UIControlStateHighlighted];
        [_button_e addTarget:self action:@selector(___action_e) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_e;
}


- (void)___action_a
{
    [self.tabBarController setSelectedIndex:0];
}

- (void)___action_b
{
    [self.tabBarController setSelectedIndex:1];
}

- (void)___action_c
{
    [self.tabBarController setSelectedIndex:2];
//    if ([BASEUSER isLogin]) {
//        [self.tabBarController setSelectedIndex:2];
//    } else {
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [self presentViewController:login animated:YES completion:nil];
//    }
}

- (void)___action_d
{
    [self.tabBarController setSelectedIndex:3];
//    if ([BASEUSER isLogin]) {
//        [self.tabBarController setSelectedIndex:3];
//    } else {
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [self presentViewController:login animated:YES completion:nil];
//    }
}

- (void)___action_e
{
    [self.tabBarController setSelectedIndex:4];
}

- (void)actionLoginView
{
    LoginOverseaViewController *login = [[LoginOverseaViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

- (void)___action_snap
{
//    SnapshotViewController *share = [[SnapshotViewController alloc] init];
//    UIImage *image = [self takeSnapshotOfView:self.navigationController.view];
//    UIImage *image_effects = [UIImageEffects imageByApplyingLightEffectToImage:image];
//    share.image = image_effects;
//    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:share];
//    [navCon setNavigationBarHidden:YES];
//    [self presentViewController:navCon animated:NO completion:nil];
}

- (UIImage *)takeSnapshotOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(CGSizeMake(APPFullScreenWidth, APPFullScreenHeight));
    [view drawViewHierarchyInRect:CGRectMake(0, 0, APPFullScreenWidth, APPFullScreenHeight) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
