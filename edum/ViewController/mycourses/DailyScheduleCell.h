//
//  DailyScheduleCell.h
//  edum
//
//  Created by Kevin Chan on 17/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DailyScheduleCell : BaseTableViewCell

@property (nonatomic, strong) UIView *view_container;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIImageView *imageview_time;
@property (nonatomic, strong) UILabel *label_time;
@property (nonatomic, strong) UIButton *button_status;
@property (nonatomic, strong) UIView *view_contact;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;

@property (nonatomic, strong) NSDictionary *daily;

@property (nonatomic,copy) void(^enteryCall)(NSDictionary *data);

@end

NS_ASSUME_NONNULL_END
