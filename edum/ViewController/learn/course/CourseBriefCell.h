//
//  CourseBriefCell.h
//  edum
//
//  Created by Kevin Chan on 24/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseBriefCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;

- (void)bindData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
