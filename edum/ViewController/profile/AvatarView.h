//
//  AvatarView.h
//  gwlx
//
//  Created by Chan Kevin on 19/9/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarView : UIView

@property (nonatomic, strong) UIImageView *imageview_bg;
@property (nonatomic, strong) UIView *view_avatar;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UIView *view_separator;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) CGRect rect;

- (void)bindData:(NSDictionary *)dic;

@end
