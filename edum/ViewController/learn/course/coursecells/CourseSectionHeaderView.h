//
//  CourseSectionHeaderView.h
//  edum
//
//  Created by Kevin Chan on 27/4/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UIButton *button_more;

@end

NS_ASSUME_NONNULL_END
