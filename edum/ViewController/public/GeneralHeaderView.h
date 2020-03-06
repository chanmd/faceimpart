//
//  GeneralHeaderView.h
//  edum
//
//  Created by Kevin Chan on 26/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *view_accessory;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *image_accessory;

@end

NS_ASSUME_NONNULL_END
