//
//  SightCubeView.h
//  gwlx
//
//  Created by Kevin Chan on 11/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SightCubeView : UIView

@property (nonatomic, strong) UIImageView *imageview_photo;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIImageView *imageview_shadow;
@property (nonatomic, strong) UIImageView *imageview_feature;

@property (nonatomic, strong) UIView *view_white;
@property (nonatomic, strong) UILabel *label_rates;
@property (nonatomic, strong) UIButton *button_heart;
@property (nonatomic, strong) UILabel *label_content;
@property (nonatomic, strong) UIButton *button;

- (void)bindData:(NSDictionary *)dic;

@end
