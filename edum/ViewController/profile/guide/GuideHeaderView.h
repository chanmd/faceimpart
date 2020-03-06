//
//  GuideHeaderView.h
//  gwlx
//
//  Created by Kevin Chan on 25/10/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideHeaderView : UIView

@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, strong) UIImageView *imageview_feature;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_category;
@property (nonatomic, strong) UILabel *label_name;

@property (nonatomic, strong) UIView *view_border;

- (void)bindDict:(NSDictionary *)dic;

@end
