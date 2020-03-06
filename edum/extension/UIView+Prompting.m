//
//  UIView+Prompting.m
//  zhibo
//
//  Created by Mac on 15/6/2.
//  Copyright (c) 2015年 九州证券. All rights reserved.
//

#import "UIView+Prompting.h"
#import "UIColor+ColorExtension.h"


@implementation UIView (Prompting)

- (MBProgressHUD *)hud_show
{
    return [MBProgressHUD showHUDAddedTo:self animated:NO];
}

- (MBProgressHUD *)hud_textonly:(NSString *)text
{
    return [self showMBHudTextOnlyView:text removeAuto:YES];
}

- (MBProgressHUD *)hud_text:(NSString *)text removeauto:(BOOL)removeauto
{
    return [self showMBHudTextOnlyView:text removeAuto:removeauto];
}

- (void)hud_hide
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (MBProgressHUD *)showMBHudTextOnlyView:(NSString *)text removeAuto:(BOOL)autoremove
{
    [MBProgressHUD hideHUDForView:self animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:NO];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    hud.layer.cornerRadius = 3.f;
    hud.margin = 10.f;
    if (autoremove) {
        [hud hideAnimated:YES afterDelay:1.2];
    }
    return hud;
}

@end
