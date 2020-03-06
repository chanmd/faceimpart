//
//  UserNotificationCell.h
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserNotificationCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_datetime;
@property (nonatomic, strong) UIView *view_container;
@property (nonatomic, strong) UIView *view_border;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIImageView *imageview_accessroy;
@property (nonatomic, strong) UILabel *label_subtitle;

@property (nonatomic, strong) UILabel *newMessageLabel;

- (void)bindUserNotification:(NSDictionary *)message;

@end

NS_ASSUME_NONNULL_END
