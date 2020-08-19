//
//  BaseViewController.m
//  gwlx
//
//  Created by Chan Kevin on 4/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+Prompting.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self clearBackBarButtonItemTitle];
    self.view.backgroundColor = __color_white;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)setupNavigation
{
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithHEX:0xffffff];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: __color_font_title, NSFontAttributeName: __fontthin(18)};
}

- (void)clearBackBarButtonItemTitle
{
    if (self.navigationController.viewControllers.count < 2) {
        return;
    }//otherwise the first viewcontroller will appear back button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back_arrow"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 24, 24);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self addKeyboardNotifaction];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self removeKeyboardNotifaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark handleKeyboard
- (void)addKeyboardNotifaction
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppear:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidDisappear:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeKeyboardNotifaction
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  MAKR:键盘处理
 */
- (void)keyboardWillAppear:(NSNotification *)noti
{
    _isKeyboardAppear = YES;
    CGRect keyboardFrame = [[noti.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    [self keyboardWillAppear:noti withKeyboardRect:keyboardFrame];
}

- (void)keyboardWillDisappear:(NSNotification *)noti
{
    _isKeyboardAppear = NO;
    CGRect keyboardFrame = [[noti.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    [self keyboardWillDisappear:noti withKeyboardRect:keyboardFrame];
}

- (void)keyboardDidAppear:(NSNotification *)noti
{
    _isKeyboardAppear = YES;
    CGRect keyboardFrame = [[noti.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    [self keyboardDidAppear:noti withKeyboardRect:keyboardFrame];
}

- (void)keyboardDidDisappear:(NSNotification *)noti
{
    _isKeyboardAppear = NO;
    CGRect keyboardFrame = [[noti.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    [self keyboardDidDisappear:noti withKeyboardRect:keyboardFrame];
}

- (void)keyboardWillAppear:(NSNotification *)noti withKeyboardRect:(CGRect)rect
{
    
    
}

- (void)keyboardWillDisappear:(NSNotification *)noti withKeyboardRect:(CGRect)rect
{
    
}

- (void)keyboardDidAppear:(NSNotification *)noti withKeyboardRect:(CGRect)rect
{
    
}

- (void)keyboardDidDisappear:(NSNotification *)noti withKeyboardRect:(CGRect)rect
{
    
}

//弹出提示框
- (void)alertShow:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertShowWithConfirm:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancal"
                                          otherButtonTitles:@"Sure", nil];
    [alert show];
}

#pragma mark - changeStateBarStyle
- (void)changeStateBarStyleLight:(BOOL)light
{
    if (light) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
    }else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    
}


#pragma mark -
#pragma mark PromptView

- (void)hud_text:(NSString *)text removeauto:(BOOL)removeauto
{
    [[self promptingTopView] hud_text:text removeauto:removeauto];

}

- (void)hud_textonly:(NSString *)text
{
    [[self promptingTopView] hud_textonly:text];
}

- (void)hud_show
{
    [[self promptingTopView] hud_show];
}

//  消除视图
- (void)hud_hide
{
    [[self promptingTopView] hud_hide];
}

//  获取顶部的视图
- (UIView *)promptingTopView
{
    NSArray *windwos = [[UIApplication sharedApplication] windows];
    
    UIView *topView = self.view;
    
    if (windwos.count > 1 && _isKeyboardAppear) {
        UIWindow *keyboarWindow = [windwos objectAtIndex:1];
        topView = keyboarWindow;
    }
    return topView;
}

- (UIView *)keyboardView
{
    //#pragma mark ------locate keyboard view--------
    NSArray *windowList = [[UIApplication sharedApplication] windows];
    UIWindow* tempWindow = nil;
    if ([windowList count] > 1) {
        tempWindow = [windowList objectAtIndex:1];
    }
    UIView* keyboard;
    for(int i = 0; i < [tempWindow.subviews count]; i ++) {
        
        keyboard = [tempWindow.subviews objectAtIndex:i];
        
        //iPhone SDk 4.0 自定义键盘 版本兼容问题
        if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||
           (([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)))
        {
            return keyboard;
        }
        
    }
    return nil;
}

@end
