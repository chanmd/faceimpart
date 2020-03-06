//
//  ProfileHeaderView.h
//  gwlx
//
//  Created by Chan Kevin on 1/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileHeaderView : UIView

@property (nonatomic, strong) UIView *view_background;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UIImageView *imageview_gender;
@property (nonatomic, strong) UILabel *label_place;

@property (nonatomic, strong) UIView *view_separator;
@property (nonatomic, strong) UIButton *button_follower;
@property (nonatomic, strong) UIButton *button_following;
@property (nonatomic, strong) UILabel *label_follower;
@property (nonatomic, strong) UILabel *label_following;

@property (nonatomic, strong) UIView *view_split;

- (void)bindData:(NSDictionary *)dic;

- (void)bindAvatar:(NSDictionary *)dic;

- (void)bindNumber:(NSDictionary *)dic;

@end
