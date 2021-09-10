//
//  SettingCell.h
//  edum
//
//  Created by Kevin Chan on 11/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) UILabel *label_left;
@property (nonatomic, strong) UILabel *label_right;
@property (nonatomic, strong) UIView *view_line;
@property (nonatomic, strong) UIImageView *imageview_bank;
@property (nonatomic, strong) UILabel *label_middle;

@end

NS_ASSUME_NONNULL_END
