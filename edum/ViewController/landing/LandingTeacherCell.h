//
//  LandingTeacherCell.h
//  edum
//
//  Created by Kevin Chan on 30/1/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LandingTeacherCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_left;
@property (nonatomic, strong) UIButton *button_left;
@property (nonatomic, strong) UIImageView *imageview_right;
@property (nonatomic, strong) UIButton *button_right;

- (void)bindElementWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
