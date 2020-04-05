//
//  PaymentCell.h
//  edum
//
//  Created by Kevin Chan on 31/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_icon;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIButton *button_select;

- (void)bindPaymentCell:(NSDictionary *)data;
- (void)bindPaymentCellButton:(NSInteger)payment;

@end

NS_ASSUME_NONNULL_END
