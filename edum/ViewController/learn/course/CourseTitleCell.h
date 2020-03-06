//
//  CourseTitleCell.h
//  edum
//
//  Created by Kevin Chan on 13/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseTitleCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIButton *button;

- (void)bindDict:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
