//
//  CourseBannerCell.h
//  edum
//
//  Created by Kevin Chan on 22/4/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseBannerCell : BaseTableViewCell

@property (nonatomic, strong) UIView *bg_view;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UIButton *button_avatar;

- (void)bindData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
