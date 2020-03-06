//
//  VerificationCodeViewController.m
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "VerificationCodeViewController.h"
#import "TTTAttributedLabel.h"
#import "AboutContentViewController.h"
#import "NSDictionary+JSONExtern.h"

#define QUARTER_WIDTH (APPScreenWidth - 60) / 4
#define QUARTER_PADDING_WIDTH (APPScreenWidth - 120) / 4

@interface VerificationCodeViewController () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) UIButton *button_dismiss;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_code;

@property (nonatomic, strong) UITextField *textfield_code;
@property (nonatomic, strong) UITextField *textfield_code2;
@property (nonatomic, strong) UITextField *textfield_code3;
@property (nonatomic, strong) UITextField *textfield_code4;
@property (nonatomic, strong) UIView *view_underline;
@property (nonatomic, strong) UIView *view_underline2;
@property (nonatomic, strong) UIView *view_underline3;
@property (nonatomic, strong) UIView *view_underline4;

@property (nonatomic, strong) UIButton *button_resend;

@property (nonatomic, strong) UIButton *button_login;

@property (nonatomic,assign) NSTimer *codeTimer;
@property (nonatomic,assign) NSInteger remainTime;

@property (nonatomic, strong) TTTAttributedLabel *label_privacy;

@end

@implementation VerificationCodeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.button_dismiss];
    
    [self.view addSubview:self.label_title];
    [self.view addSubview:self.label_code];
    [self.view addSubview:self.textfield_code];
    [self.view addSubview:self.textfield_code2];
    [self.view addSubview:self.textfield_code3];
    [self.view addSubview:self.textfield_code4];
    
    [self.view addSubview:self.view_underline];
    [self.view addSubview:self.view_underline2];
    [self.view addSubview:self.view_underline3];
    [self.view addSubview:self.view_underline4];
    
    [self.view addSubview:self.button_resend];
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    self.remainTime = 59;
    [self.view addSubview:self.button_login];
    
    [self.view addSubview:self.label_privacy];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeOneCI:)
    name:UITextFieldTextDidChangeNotification
    object:self.textfield_code];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeOneCI:)
    name:UITextFieldTextDidChangeNotification
    object:self.textfield_code2];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeOneCI:)
    name:UITextFieldTextDidChangeNotification
    object:self.textfield_code3];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeOneCI:)
    name:UITextFieldTextDidChangeNotification
    object:self.textfield_code4];
    
}

-(void)textFieldTextDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    NSString *text = textfield.text;
    if (text.length == 1) {
        switch (textfield.tag) {
            case 1:
                [self.textfield_code2 becomeFirstResponder];
                break;
            case 2:
                [self.textfield_code3 becomeFirstResponder];
                break;
            case 3:
                [self.textfield_code4 becomeFirstResponder];
                break;
            
            case 4:
                
                [self.button_login setTitleColor:__color_white forState:UIControlStateNormal];
                self.button_login.layer.backgroundColor = [__color_main CGColor];
                
                break;
            default:
                break;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.view addSubview:self.panormaview];
    
//    [self.panormaview startAnimating];
    //    [self fakeLogin];
//    [self fetch_fb_user_info];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark initviews

- (UIButton *)button_dismiss
{
    if (!_button_dismiss) {
        _button_dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_dismiss.frame = CGRectMake(30, BASE_VIEW_Y + 10, 40, 40);
        [_button_dismiss setImage:ImageNamed(@"navigation_back") forState:UIControlStateNormal];
        [_button_dismiss addTarget:self action:@selector(action_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_dismiss;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(30, self.button_dismiss.bottom + 30, APPScreenWidth, 40)];
        _label_title.font = __font(30);
        _label_title.text = @"请输入验证码";
        _label_title.textColor = __color_black;
    }
    return _label_title;
}

- (UILabel *)label_code
{
    if (!_label_code) {
        _label_code = [[UILabel alloc] initWithFrame:CGRectMake(32, self.label_title.bottom + 5, APPScreenWidth - 60, 30)];
        _label_code.font = __font(18);
        _label_code.textColor = __color_font_title;
        if (self.phone_number) {
            _label_code.text = [NSString stringWithFormat:@"短信已发送至 %@", self.phone_number];
        } else {
            _label_code.text = @"短信已发送";
        }
        
    }
    return _label_code;
}

- (UITextField *)textfield_code
{
    if (!_textfield_code) {
        _textfield_code = [[UITextField alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 0, self.label_code.bottom + 50, QUARTER_PADDING_WIDTH, 40)];
        _textfield_code.placeholder = @"0";
        _textfield_code.font = __font(30);
        _textfield_code.tag = 1;
        _textfield_code.textAlignment = NSTextAlignmentCenter;
        _textfield_code.keyboardType = UIKeyboardTypeNumberPad;
        [_textfield_code becomeFirstResponder];
    }
    return _textfield_code;
}

- (UITextField *)textfield_code2
{
    if (!_textfield_code2) {
        _textfield_code2 = [[UITextField alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 1, self.label_code.bottom + 50, QUARTER_PADDING_WIDTH, 40)];
        _textfield_code2.placeholder = @"0";
        _textfield_code2.font = __font(30);
        _textfield_code2.tag = 2;
        _textfield_code2.textAlignment = NSTextAlignmentCenter;
        _textfield_code2.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textfield_code2;
}

- (UITextField *)textfield_code3
{
    if (!_textfield_code3) {
        _textfield_code3 = [[UITextField alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 2, self.label_code.bottom + 50, QUARTER_PADDING_WIDTH, 40)];
        _textfield_code3.placeholder = @"0";
        _textfield_code3.font = __font(30);
        _textfield_code3.tag = 3;
        _textfield_code3.textAlignment = NSTextAlignmentCenter;
        _textfield_code3.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textfield_code3;
}

- (UITextField *)textfield_code4
{
    if (!_textfield_code4) {
        _textfield_code4 = [[UITextField alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 3, self.label_code.bottom + 50, QUARTER_PADDING_WIDTH, 40)];
        _textfield_code4.placeholder = @"0";
        _textfield_code4.tag = 4;
        _textfield_code4.textAlignment = NSTextAlignmentCenter;
        _textfield_code4.font = __font(30);
        _textfield_code4.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textfield_code4;
}


- (UIView *)view_underline
{
    if (!_view_underline) {
        _view_underline = [[UIView alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 0,  self.textfield_code.bottom, QUARTER_PADDING_WIDTH, 0.5)];
        _view_underline.backgroundColor = __color_font_placeholder;
    }
    return _view_underline;
}

- (UIView *)view_underline2
{
    if (!_view_underline2) {
        _view_underline2 = [[UIView alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 1, self.textfield_code.bottom, QUARTER_PADDING_WIDTH, 0.5)];
        _view_underline2.backgroundColor = __color_font_placeholder;
    }
    return _view_underline2;
}

- (UIView *)view_underline3
{
    if (!_view_underline3) {
        _view_underline3 = [[UIView alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 2, self.textfield_code.bottom, QUARTER_PADDING_WIDTH, 0.5)];
        _view_underline3.backgroundColor = __color_font_placeholder;
    }
    return _view_underline3;
}

- (UIView *)view_underline4
{
    if (!_view_underline4) {
        _view_underline4 = [[UIView alloc] initWithFrame:CGRectMake(30 + QUARTER_WIDTH * 3, self.textfield_code.bottom, QUARTER_PADDING_WIDTH, 0.5)];
        _view_underline4.backgroundColor = __color_font_placeholder;
    }
    return _view_underline4;
}

- (UIButton *)button_resend
{
    if (!_button_resend) {
        _button_resend = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view_underline.bottom + 30, APPScreenWidth, 30)];
        _button_resend.titleLabel.font = __font(16);
        [_button_resend setTitle:@"59秒后重新获取" forState:UIControlStateNormal];
        [_button_resend setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        [_button_resend addTarget:self action:@selector(action_resend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_resend;
}


- (void)setbutton_status:(NSInteger)status
{
    if (status == 2) {
        [self.button_login setTitleColor:__color_white forState:UIControlStateNormal];
        self.button_login.layer.backgroundColor = [__color_main CGColor];
    } else {
        [self.button_login setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        self.button_login.layer.backgroundColor = [__color_gray_background CGColor];
    }
}

- (UIButton *)button_login
{
    if (!_button_login) {
        _button_login = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_login.frame = CGRectMake(30, self.button_resend.bottom + 40, APPScreenWidth - 60, 44);
        _button_login.layer.cornerRadius = 22;
        _button_login.layer.masksToBounds = YES;
        [_button_login setTitle:@"登录" forState:UIControlStateNormal];
        [_button_login setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        _button_login.layer.backgroundColor = [__color_gray_background CGColor];
        [_button_login addTarget:self action:@selector(action_login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_login;
}

- (void)timerAction:(NSTimer *)timer
{
    self.button_resend.userInteractionEnabled = NO;
    [self.button_resend setTitle:[NSString stringWithFormat:@"%.2ld秒后重新发送短信",(long)self.remainTime] forState:UIControlStateNormal];
    [self.button_resend setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
    if (self.remainTime == 0) {
        [timer invalidate];
        [self.button_resend setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [self.button_resend setTitleColor:__color_main forState:UIControlStateNormal];
        self.button_resend.userInteractionEnabled = YES;
    }
    self.remainTime --;
}

- (TTTAttributedLabel *)label_privacy
{
    if (!_label_privacy) {
        _label_privacy = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 30 - SafeAreaBottomHeight - 64, APPScreenWidth, 20)];
        _label_privacy.font = __font(12);
        _label_privacy.textAlignment = NSTextAlignmentCenter;
        NSString *privacy = @" 隐私政策";
        NSString *reg = @" 用户注册协议 ";
        NSString *strAll = [NSString stringWithFormat:@"登录表示同意%@和%@", reg, privacy];
        NSMutableAttributedString *stringAll = [[NSMutableAttributedString alloc] initWithString:strAll];
        
        NSRange regRange = [strAll rangeOfString:reg];
        NSRange privacyRange = [strAll rangeOfString:privacy];
        [stringAll addAttribute:NSForegroundColorAttributeName value:__color_font_subtitle range:NSMakeRange(0, strAll.length)];
        [stringAll addAttribute:NSForegroundColorAttributeName value:__color_main range:privacyRange];
        [stringAll addAttribute:NSForegroundColorAttributeName value:__color_main range:regRange];
        
        NSMutableDictionary *dictAtt = [NSMutableDictionary dictionary];
        [dictAtt setValue:__color_main forKey:(NSString *)kCTForegroundColorAttributeName];
        _label_privacy.attributedText = stringAll;
        _label_privacy.delegate = self;
        [_label_privacy setLinkAttributes:dictAtt];
        [_label_privacy setActiveLinkAttributes:dictAtt];
        [_label_privacy addLinkToURL:[NSURL URLWithString:@"webReg"] withRange:regRange];
        [_label_privacy addLinkToURL:[NSURL URLWithString:@"webPrivacy"] withRange:privacyRange];
    }
    return _label_privacy;
}

#pragma mark TTTAttributedLabelDelegate
- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    NSLog(@"dianji");
    if ([url.absoluteString isEqualToString:@"webPrivacy"]) {
        [self gotoPrivacy];
    }
    else if ([url.absoluteString isEqualToString:@"webReg"]) {
        [self gotoProtocol];
    }
}

- (void)gotoPrivacy
{
    AboutContentViewController *privacy = [[AboutContentViewController alloc] init];
    privacy.content_type = @"privacy";
    [self.navigationController pushViewController:privacy animated:YES];
}

- (void)gotoProtocol
{
    AboutContentViewController *protocol = [[AboutContentViewController alloc] init];
    protocol.content_type = @"protocol";
    [self.navigationController pushViewController:protocol animated:YES];
}


#pragma mark - actions

- (void)action_dismiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)action_resend
{
//    [self action_login];
}

- (void)action_done
{
    if (self.block) {
        self.block(self.phone_number);
    }
    [self action_dismiss];
}

- (void)action_login
{
    NSString *code = self.textfield_code.text;
    NSString *code2 = self.textfield_code2.text;
    NSString *code3 = self.textfield_code3.text;
    NSString *code4 = self.textfield_code4.text;
    NSString *verification_code = @"";
    if (code && code.length == 1 && code2 && code2.length == 1 && code3 && code3.length == 1 && code4 && code4.length == 1) {
        verification_code = [NSString stringWithFormat:@"%@%@%@%@", code, code2, code3, code4];
    } else {
        [self alertShow:@"请输入验证码"];
        return;
    }
    NSDictionary *parms = @{
        @"phone": self.phone_number,
        @"phoneCode": @"86",
        @"code": verification_code,
    };
    WeakSelf;
    [AFR requestWithUrl:REQUEST_USER_LOGINPHONECODE
             httpmethod:@"GET"
                 params:[NSMutableDictionary dictionaryWithDictionary:parms]
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        if ([[tempDic objectForKey:@"code"] integerValue] == RESPONSE_OK) {
            NSDictionary *data = [tempDic objectForKey:@"data"];
            BASEUSER.user = [data dictionaryForKey:@"user"];
            if ([data dictionaryForKey:@"teacher"]) {
                BASEUSER.teacher = [data dictionaryForKey:@"teacher"];
            }
            BASEUSER.token = [data stringForKey:@"token"];
            BASEUSER.user_id = [data stringForKey:@"id"];
            BASEUSER.mobile_phone = [data stringForKey:@"phone"];
            BASEUSER.code = [data stringForKey:@"phoneCode"];
            BASEUSER.headimgurl = [data stringForKey:@"headImg"];
            BASEUSER.status = [data stringIntForKey:@"status"];
            [weakSelf action_done];
        }
    }
            failedBlock:^(NSError *errorInfo){
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}


@end
