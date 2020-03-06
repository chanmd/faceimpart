//
//  ProfileHeadCell.h
//  gwlx
//
//  Created by Chan Kevin on 20/12/15.
//  Copyright © 2015 Kevin Chan. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ProfileHeadCell : BaseTableViewCell

@property (nonatomic, strong) UIView *view_bg;
@property (nonatomic, strong) UIView *view_avatar;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UIButton *button_follow;

@end
