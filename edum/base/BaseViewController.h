//
//  BaseViewController.h
//  gwlx
//
//  Created by Chan Kevin on 4/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+initWithColor.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFRequest.h"
#import "UrlConstants.h"

@interface BaseViewController : UIViewController

@property (nonatomic, assign)   BOOL isKeyboardAppear;

- (void)setupNavigation;
- (void)goback;
- (void)hud_textonly:(NSString *)text;
- (void)hud_text:(NSString *)text removeauto:(BOOL)removeauto;
- (void)hud_show;
- (void)hud_hide;

- (void)alertShow:(NSString*)message;

- (void)alertShowWithConfirm:(NSString *)message;

@end
