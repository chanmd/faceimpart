//
//  LoginOverseaViewController.h
//  edum
//
//  Created by Md Chen on 8/8/22.
//  Copyright © 2022 MD Chen. All rights reserved.
//

#import "BaseViewController.h"
#import "TTTAttributedLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginOverseaViewController : BaseViewController

@property (nonatomic, strong) UIButton *button_dismiss;

@property (nonatomic, strong) UILabel *label_slogan;
@property (nonatomic, strong) UIButton *button_verification_code;

@property (nonatomic, strong) TTTAttributedLabel *label_privacy;
@property (nonatomic, strong) NSString *email;

@end

NS_ASSUME_NONNULL_END
