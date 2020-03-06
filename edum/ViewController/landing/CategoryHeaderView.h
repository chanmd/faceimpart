//
//  CategoryHeaderView.h
//  gwlx
//
//  Created by Kevin Chan on 25/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryHeaderView : UIView

@property (nonatomic, strong) UIImageView *imageview_cover;
@property (nonatomic, strong) UIView *view_shadow;
@property (nonatomic, strong) UILabel *label_title;

- (void)bindData:(NSDictionary *)dic;

@end
