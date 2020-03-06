//
//  LoginViewController.h
//  gwlx
//
//  Created by Chan Kevin on 6/11/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (nonatomic, strong) UIButton *button_dismiss;
@property (nonatomic, strong) UILabel *label_slogan;
@property (nonatomic, strong) UITextField *textfield_phone_number;
@property (nonatomic, strong) UIView *view_underline;
@property (nonatomic, strong) UIButton *button_verification_code;
@property (nonatomic, strong) UILabel *label_hint;

@property (nonatomic, strong) UIView *view_border;
@property (nonatomic, strong) UILabel *label_another;

@property (nonatomic, strong) UIButton *button_wx_login;


@end
