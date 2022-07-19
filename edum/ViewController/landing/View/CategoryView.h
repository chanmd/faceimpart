//
//  CategoryView.h
//  gwlx
//
//  Created by Kevin Chan on 8/6/2018.
//  Copyright © 2018 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ColorExtension.h"
#import "UIView+BFExtension.h"

@interface CategoryView : UIView

@property (nonatomic, strong) UIImageView *imageview_cover;
@property (nonatomic, strong) UIView *view_shadow;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIButton *button;

@end
