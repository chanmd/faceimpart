//
//  LoginViewController.m
//  gwlx
//
//  Created by Chan Kevin on 6/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "LoginViewController.h"
#import "NSDictionary+JSONExtern.h"
#import "WXApi.h"
#import "BaseUser.h"
#import "BaseWebViewController.h"
#import "VerificationCodeViewController.h"
#import "NSString+IsValidate.h"

#import "TTTAttributedLabel.h"
#import "AboutContentViewController.h"

#define kAuthScope @"snsapi_userinfo"
#define kAuthState @"xxx"
#define kAuthOpenID @""

#define WX_OK 0
#define WX_AUTH_DENIED -4
#define WX_USER_CANCEL -2

@interface LoginViewController () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel *label_privacy;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.button_dismiss];
    [self.view addSubview:self.label_slogan];
    [self.view addSubview:self.textfield_phone_number];
    [self.view addSubview:self.view_underline];
    [self.view addSubview:self.button_verification_code];
    [self.view addSubview:self.label_hint];
    
    [self.view addSubview:self.view_border];
    [self.view addSubview:self.label_another];
    [self.view addSubview:self.button_wx_login];
    
    [self.view addSubview:self.label_privacy];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeOneCI:)
    name:UITextFieldTextDidChangeNotification
    object:self.textfield_phone_number];
    
}

-(void)textFieldTextDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    NSString *text = textfield.text;
    if (text.length == 11) {
        [self setbutton_status:YES];
        
    } else {
        [self setbutton_status:NO];
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

- (void)fakeLogin
{
    [BaseUser instance].openid = @"openid";
    [BaseUser instance].unionid = @"unionid";
    [BaseUser instance].sex = @"sex";
    [BaseUser instance].nickname = @"nickname";
    [BaseUser instance].province = @"province";
    [BaseUser instance].country = @"country";
    [BaseUser instance].headimgurl = @"headimgurl";
    [BaseUser instance].user_id = @"ea69c20de9ee2163782037c3bff53949";
    [self performSelector:@selector(___postnotificationIn) withObject:nil afterDelay:2];
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

- (UIButton *)button_dismiss
{
    if (!_button_dismiss) {
        _button_dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_dismiss.frame = CGRectMake(30, BASE_VIEW_Y + 20, 20, 20);
        [_button_dismiss setImage:ImageNamed(@"view_cancel") forState:UIControlStateNormal];
        [_button_dismiss addTarget:self action:@selector(___action_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_dismiss;
}

- (UILabel *)label_slogan
{
    if (!_label_slogan) {
        _label_slogan = [[UILabel alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y + 90, APPScreenWidth, 80)];
        _label_slogan.textAlignment = NSTextAlignmentCenter;
        _label_slogan.font = __fontthin(30);
        _label_slogan.text = @"登陆音湃 立即学习";
        _label_slogan.textColor = __color_main;
    }
    return _label_slogan;
}

- (UITextField *)textfield_phone_number
{
    if (!_textfield_phone_number) {
        _textfield_phone_number = [[UITextField alloc] initWithFrame:CGRectMake(30, self.label_slogan.bottom + 30, APPScreenWidth - 60, 40)];
        _textfield_phone_number.placeholder = @"请输入手机号";
        _textfield_phone_number.font = __font(20);
        _textfield_phone_number.keyboardType = UIKeyboardTypePhonePad;
    }
    return _textfield_phone_number;
}

- (UIView *)view_underline
{
    if (!_view_underline) {
        _view_underline = [[UIView alloc] initWithFrame:CGRectMake(30, self.textfield_phone_number.bottom, APPScreenWidth - 60, 0.5)];
        _view_underline.backgroundColor = __color_font_placeholder;
    }
    return _view_underline;
}

- (UIButton *)button_verification_code
{
    if (!_button_verification_code) {
        _button_verification_code = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_verification_code.frame = CGRectMake(30, self.view_underline.bottom + 60, APPScreenWidth - 60, 44);
        _button_verification_code.layer.cornerRadius = 22;
        _button_verification_code.layer.masksToBounds = YES;
        [_button_verification_code setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button_verification_code setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        _button_verification_code.layer.backgroundColor = [__color_gray_background CGColor];
        [_button_verification_code addTarget:self action:@selector(___action_send_code) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_verification_code;
}

- (void)setbutton_status:(BOOL)status
{
    if (status) {
        [self.button_verification_code setTitleColor:__color_white forState:UIControlStateNormal];
        self.button_verification_code.layer.backgroundColor = [__color_main CGColor];
        self.button_verification_code.userInteractionEnabled = YES;
    } else {
        [self.button_verification_code setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        self.button_verification_code.layer.backgroundColor = [__color_gray_background CGColor];
        self.button_verification_code.userInteractionEnabled = NO;
    }
}

- (UILabel *)label_hint
{
    if (!_label_hint) {
        _label_hint = [[UILabel alloc] initWithFrame:CGRectMake(0, self.button_verification_code.bottom + 20, APPScreenWidth, 30)];
        _label_hint.font = __font(16);
        _label_hint.textColor = __color_font_placeholder;
        _label_hint.textAlignment = NSTextAlignmentCenter;
        _label_hint.text = @"未注册手机验证后自动登录";
    }
    return _label_hint;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(30, APPScreenHeight - 190 - SafeAreaBottomHeight, APPScreenWidth - 60, 0.5)];
        _view_border.backgroundColor = __color_font_placeholder;
    }
    return _view_border;
}

- (UILabel *)label_another
{
    if (!_label_another) {
        _label_another = [[UILabel alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 200 - SafeAreaBottomHeight, 130, 20)];
        _label_another.font = __font(16);
        _label_another.centerX = APPScreenWidth / 2;
        _label_another.textColor = __color_font_placeholder;
        _label_another.textAlignment = NSTextAlignmentCenter;
        _label_another.backgroundColor = __color_white;
        _label_another.text = @"其他登陆方式";
    }
    return _label_another;
}

- (UIButton *)button_wx_login
{
    if (!_button_wx_login) {
        _button_wx_login = [[UIButton alloc] initWithFrame:CGRectMake(0, APPScreenHeight - SafeAreaBottomHeight - 146, 190, 44)];
        [_button_wx_login setImage:ImageNamed(@"wx_button") forState:UIControlStateNormal];
        _button_wx_login.centerX = APPScreenWidth / 2;
        _button_wx_login.imageView.size = CGSizeMake(18, 18);
        _button_wx_login.titleLabel.font = __font(18);
        _button_wx_login.layer.masksToBounds = YES;
        _button_wx_login.layer.cornerRadius = 3.f;
        _button_wx_login.layer.borderColor = [__color_font_placeholder CGColor];
        _button_wx_login.layer.borderWidth = 1.f;
        _button_wx_login.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_button_wx_login setTitle:@"微信账号登录" forState:UIControlStateNormal];
        [_button_wx_login setTitleColor:__color_font_placeholder forState:UIControlStateNormal];
        [_button_wx_login addTarget:self action:@selector(___action_wechat) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_wx_login;
}

- (TTTAttributedLabel *)label_privacy
{
    if (!_label_privacy) {
        _label_privacy = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, APPScreenHeight - 50 - SafeAreaBottomHeight - BASE_VIEW_Y, APPScreenWidth, 20)];
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

- (void)___action_dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)___action_send_code
{
    NSString *phone = self.textfield_phone_number.text;
    
    if (phone.length == 0) {
        [self alertShow:@"请输入手机号"];
        return;
    } else if (phone.length != 11 || [phone isValidateTelPhoneNum]){
        [self alertShow:@"请输入正确格式手机号"];
        return;
    }
    NSDictionary *parms = @{
        @"phone": phone,
        @"phoneCode": @"86"
    };
    WeakSelf;
    [AFR requestWithUrl:REQUEST_USER_SENDCODE
             httpmethod:@"GET"
                 params:[NSMutableDictionary dictionaryWithDictionary:parms]
          finishedBlock:^(id responseObject){
        NSLog(@"");
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        if ([[tempDic objectForKey:@"code"] integerValue] == RESPONSE_OK) {
                [weakSelf ___action_verification:phone];
            }
        }
            failedBlock:^(NSError *errorInfo){
        NSLog(@"");
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}

- (void)___action_verification:(NSString *)phone_number
{
    WeakSelf;
    VerificationCodeViewController *verification = [[VerificationCodeViewController alloc] init];
    verification.phone_number = phone_number;
    verification.block = ^(NSString *phone_number) {
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    [self.navigationController pushViewController:verification animated:YES];
}

- (void)___action_wechat
{
    if ([WXApi isWXAppInstalled]) {
        
        
        
    } else {
        [self alertShow:@"请下载微信登陆"];
    }
}

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
    
    if (response.errCode == WX_OK) {
        [self upload_userinfo_wx:response.code];
        
    } else if (response.errCode == WX_AUTH_DENIED) {
        //
        [self hud_textonly:NSLocalizedString(@"loginfail", nil)];
    } else if (response.errCode == WX_USER_CANCEL) {
        //
        [self hud_textonly:NSLocalizedString(@"loginfail", nil)];
    }
    
}

- (void)upload_userinfo_wx:(NSString *)code
{
    WeakSelf;
    NSString *url = [NSString stringWithFormat:@"%@/wx", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *dic = @{@"code": code};
    NSLog(@"=============================%@===========================", code);
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *data = [tempDic objectForKey:@"data"];
            [BaseUser instance].openid = [data objectForKey:@"openid"];
            [BaseUser instance].unionid = [data objectForKey:@"unionid"];
            [BaseUser instance].sex = [data objectForKey:@"sex"];
            [BaseUser instance].nickname = [data objectForKey:@"nickname"];
            [BaseUser instance].province = [data objectForKey:@"province"];
            [BaseUser instance].country = [data objectForKey:@"country"];
            [BaseUser instance].headimgurl = [data objectForKey:@"headimgurl"];
            [BaseUser instance].user_id = [data objectForKey:@"user_id"];
            
            [weakSelf hud_textonly:NSLocalizedString(@"loginok", nil)];
            //notification
            [weakSelf performSelector:@selector(___postnotificationIn) withObject:nil afterDelay:2];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
//        [weakSelf hud_textonly:NSLocalizedString(@"loginfail", nil)];
        [weakSelf hud_textonly:operation.responseString];
    }];
    
//    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WXKEY, WXSECRET, code];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [securityPolicy setValidatesDomainName:NO];
//    manager.securityPolicy = securityPolicy;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *tempDic = (NSDictionary *)responseObject;
//        NSLog(@"%@", [tempDic objectForKey:@"access_token"]);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
    
}

- (void)___postnotificationIn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:__LOGIN object:nil];
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
