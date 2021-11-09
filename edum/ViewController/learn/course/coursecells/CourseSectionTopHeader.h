//
//  CourseSectionTopHeader.h
//  edum
//
//  Created by Kevin Chan on 28/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseSectionTopHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UIView *view_shadow;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;

@end

NS_ASSUME_NONNULL_END
