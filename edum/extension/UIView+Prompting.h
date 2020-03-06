//
//  UIView+Prompting.h
//  zhibo
//
//  Created by Mac on 15/6/2.
//  Copyright (c) 2015年 九州证券. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (Prompting)

- (MBProgressHUD *)hud_textonly:(NSString *)text;
- (MBProgressHUD *)hud_text:(NSString *)text removeauto:(BOOL)removeauto;
- (MBProgressHUD *)hud_show;
- (void)hud_hide;

@end
