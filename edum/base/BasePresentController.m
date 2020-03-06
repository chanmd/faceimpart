//
//  BasePresentController.m
//  gwlx
//
//  Created by Kevin Chan on 4/7/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BasePresentController.h"
#import "NSString+BFExtension.h"

@interface BasePresentController ()

@end

@implementation BasePresentController

- (void)viewDidLoad
{
    [self.view addSubview:self.view_navigationbar];
    [super viewDidLoad];
    self.view.backgroundColor = __color_white;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)view_navigationbar
{
    if (!_view_navigationbar) {
        _view_navigationbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, BASE_TABLEVIEW_Y)];
        _view_navigationbar.backgroundColor = __color_white;
        [_view_navigationbar addSubview:self.label_title];
        [_view_navigationbar addSubview:self.button_back];
        [_view_navigationbar addSubview:self.view_navi_border];
        
    }
    return _view_navigationbar;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 30 + BASE_VIEW_Y, APPScreenWidth, 22)];
        _label_title.font = __fontlight(16 );
        _label_title.textColor = __color_font_title;
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    return _label_title;
}

- (UIButton *)button_back
{
    if (!_button_back) {
        _button_back = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_back.frame = CGRectMake(APPScreenWidth - 10 - 60, 30 + BASE_VIEW_Y, 60, 30);
//        [_button_back setImage:ImageNamed(@"icon_cancel") forState:UIControlStateNormal];
        [_button_back setTitle:@"取消" forState:UIControlStateNormal];
        [_button_back setTitleColor:__color_main forState:UIControlStateNormal];
        [_button_back addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_back;
}

- (UIView *)view_navi_border
{
    if (!_view_navi_border) {
        _view_navi_border = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5 + BASE_VIEW_Y, APPScreenWidth, 0.5)];
        _view_navi_border.backgroundColor = __color_gray_separator;
    }
    return _view_navi_border;
}

- (void)action_back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)uniqueIdentity
{
    long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    NSString *seed = [NSString stringWithFormat:@"%lld%@%u", milliseconds, @"moon1030", arc4random_uniform(10000)];
    return [seed toMD5];
}

@end
