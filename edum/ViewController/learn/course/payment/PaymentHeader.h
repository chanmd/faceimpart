//
//  PaymentHeader.h
//  edum
//
//  Created by Kevin Chan on 28/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentHeader : UIView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UILabel *label_price_title;
@property (nonatomic, strong) UILabel *label_price;

- (void)bindPaymentHeader:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
