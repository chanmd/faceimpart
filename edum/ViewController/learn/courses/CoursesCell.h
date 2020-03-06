//
//  CoursesCell.h
//  edum
//
//  Created by Kevin Chan on 23/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoursesCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_cover;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UILabel *label_add;

- (void)bindDict:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
