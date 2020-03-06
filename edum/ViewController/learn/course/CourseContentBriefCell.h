//
//  CourseContentBriefCell.h
//  edum
//
//  Created by Kevin Chan on 10/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseContentBriefCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) UIButton *button_user;

@property (nonatomic, strong) UIView *view_lark;
@property (nonatomic, strong) UIImageView *imageview_feature;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_category;
@property (nonatomic, strong) UILabel *label_name;

@property (nonatomic, strong) UIImageView *imageview_group;
@property (nonatomic, strong) UIImageView *imageview_chat;
@property (nonatomic, strong) UIImageView *imageview_address;

@property (nonatomic, strong) UILabel *label_group;
@property (nonatomic, strong) UILabel *label_chat;
@property (nonatomic, strong) UILabel *label_address;

@property (nonatomic, strong) UIView *view_border;

- (void)bindDict:(NSDictionary *)dic;
- (void)bindUser:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
