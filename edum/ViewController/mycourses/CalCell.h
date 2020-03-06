//
//  CalCell.h
//  edum
//
//  Created by Kevin Chan on 27/5/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_time;

@property (nonatomic, strong) UIView *border_a;
@property (nonatomic, strong) UIView *border_b;
@property (nonatomic, strong) UIView *border_c;
@property (nonatomic, strong) UIView *border_d;
@property (nonatomic, strong) UIView *border_e;
@property (nonatomic, strong) UIView *border_f;
@property (nonatomic, strong) UIView *border_g;

@property (nonatomic, strong) UIButton *button_a;
@property (nonatomic, strong) UIButton *button_b;
@property (nonatomic, strong) UIButton *button_c;
@property (nonatomic, strong) UIButton *button_d;
@property (nonatomic, strong) UIButton *button_e;
@property (nonatomic, strong) UIButton *button_f;
@property (nonatomic, strong) UIButton *button_g;

@end

NS_ASSUME_NONNULL_END
