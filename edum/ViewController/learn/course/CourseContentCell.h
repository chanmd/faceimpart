//
//  CourseContentCell.h
//  edum
//
//  Created by Kevin Chan on 11/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseContentCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UILabel *label_content;
@property (nonatomic, strong) UIView *view_border;
@property (nonatomic, strong) UIView *view_accessory;

- (void)bindDict:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
