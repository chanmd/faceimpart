//
//  LoginViewController.m
//  gwlx
//
//  Created by Chan Kevin on 6/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "LoginOverseaViewController.h"
#import "NSDictionary+JSONExtern.h"
#import "BaseUser.h"
#import "BaseWebViewController.h"
#import "VerificationCodeViewController.h"
#import "NSString+IsValidate.h"
#import "AboutContentViewController.h"

#import "WXApiRequestHandler.h"
//#import "WXApi.h"
#import "WXApiManager.h"
#import <AuthenticationServices/AuthenticationServices.h>

#define kAuthScope @"snsapi_userinfo"
#define kAuthState @"xxx"
#define kAuthOpenID @""

#define WX_OK 0
#define WX_AUTH_DENIED -4
#define WX_USER_CANCEL -2

@interface LoginOverseaViewController () <TTTAttributedLabelDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@end

@implementation LoginOverseaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.button_dismiss];
    [self.view addSubview:self.label_slogan];
    [self.view addSubview:self.button_verification_code];
    
    [self.view addSubview:self.label_privacy];
    
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
        _button_dismiss.frame = CGRectMake(APPScreenWidth - 40, BASE_TABLEVIEW_Y - 20, 20, 20);
        [_button_dismiss setImage:ImageNamed(@"view_cancel") forState:UIControlStateNormal];
        [_button_dismiss addTarget:self action:@selector(___action_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_dismiss;
}

- (UILabel *)label_slogan
{
    if (!_label_slogan) {
        _label_slogan = [[UILabel alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y + 40, APPScreenWidth, 80)];
        _label_slogan.textAlignment = NSTextAlignmentCenter;
        _label_slogan.font = __font(30);
        _label_slogan.text = @"Faceimpart";
        _label_slogan.textColor = __color_font_title;
    }
    return _label_slogan;
}

- (UIButton *)button_verification_code
{
    if (!_button_verification_code) {
        _button_verification_code = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_verification_code.frame = CGRectMake(80, RealScreenHeight / 2 - 20, APPScreenWidth - 160, (APPScreenWidth - 160) / 6);
        [_button_verification_code setImage:ImageNamed(@"appleid_button") forState:UIControlStateNormal];
        [_button_verification_code addTarget:self action:@selector(___action_apple) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_verification_code;
}

- (TTTAttributedLabel *)label_privacy
{
    if (!_label_privacy) {
        _label_privacy = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(30, APPScreenHeight - 80 - SafeAreaBottomHeight - BASE_VIEW_Y, APPScreenWidth - 60, 40)];
        _label_privacy.font = __font(12);
        _label_privacy.textAlignment = NSTextAlignmentCenter;
        _label_privacy.numberOfLines = 2;
        NSString *privacy = @" Terms & Conditions";
        NSString *reg = @" Privacy Policy ";
        NSString *strAll = [NSString stringWithFormat:@"By logging in, you understand and agree to Faceimpart's %@ & %@", reg, privacy];
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
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:privacy];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)gotoProtocol
{
    AboutContentViewController *protocol = [[AboutContentViewController alloc] init];
    protocol.content_type = @"protocol";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:protocol];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - actions

- (void)___action_dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)___action_apple
{
    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *authAppleIDRequest = [provider createRequest];
        authAppleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
        NSMutableArray <ASAuthorizationRequest *> *array = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [array addObject:authAppleIDRequest];
        }
        NSArray <ASAuthorizationRequest *> *requests = [array copy];
        ASAuthorizationController *authController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
        authController.delegate = self;
        authController.presentationContextProvider = self;
        [authController performRequests];
        
    } else {
        // Fallback on earlier versions
    }
    
    
    
    
    NSDictionary *parms = @{
        @"phone": @"",
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
                [weakSelf ___action_verification:@""];
            }
        }
            failedBlock:^(NSError *errorInfo){
        NSLog(@"");
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
    
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0))
{
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        UserInfo.ap_givenName = credential.fullName.givenName;
        UserInfo.ap_email = credential.email;
        UserInfo.ap_authorizationCode = credential.authorizationCode;
        UserInfo.ap_identityToken = credential.identityToken;
        UserInfo.loginType = @"apple";
        [self alertShow:credential.email];
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"Authorization is canceled.";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"Authorization is failed.";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"Authorization invalid.";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"Authorization can not handled.";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"Unkown reason failed for authorization.";
        default:
            break;
    }
    [self hud_textonly:errorMsg];
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
        
        [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                   State:kAuthState
                  OpenID:kAuthOpenID
        InViewController:self];
        
        
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
    NSString *url = [NSString stringWithFormat:@"%@/login", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *dic = @{@"code": code};
    NSLog(@"=============================%@===========================", code);
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *data = [tempDic objectForKey:@"data"];
            UserInfo.openid = [data objectForKey:@"openid"];
            UserInfo.unionid = [data objectForKey:@"unionid"];
            UserInfo.sex = [data objectForKey:@"sex"];
            UserInfo.nickname = [data objectForKey:@"nickname"];
            UserInfo.province = [data objectForKey:@"province"];
            UserInfo.country = [data objectForKey:@"country"];
            UserInfo.headimgurl = [data objectForKey:@"headimgurl"];
            UserInfo.user_id = [data objectForKey:@"user_id"];
            
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

