//
//  CalHeader.h
//  edum
//
//  Created by Kevin Chan on 27/5/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalHeader : UIView

@property (nonatomic, strong) UIView *border_a;
@property (nonatomic, strong) UIView *border_b;
@property (nonatomic, strong) UIView *border_c;
@property (nonatomic, strong) UIView *border_d;
@property (nonatomic, strong) UIView *border_e;
@property (nonatomic, strong) UIView *border_f;
@property (nonatomic, strong) UIView *border_g;

@property (nonatomic, strong) UILabel *label_a;
@property (nonatomic, strong) UILabel *label_b;
@property (nonatomic, strong) UILabel *label_c;
@property (nonatomic, strong) UILabel *label_d;
@property (nonatomic, strong) UILabel *label_e;
@property (nonatomic, strong) UILabel *label_f;
@property (nonatomic, strong) UILabel *label_g;

@property (nonatomic, strong) UIView *border_line;
@property (nonatomic, strong) UIView *border_line_up;

@end

NS_ASSUME_NONNULL_END
