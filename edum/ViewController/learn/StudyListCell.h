//
//  StudyListCell.h
//  edum
//
//  Created by Kevin Chan on 19/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudyListCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *button_video;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIView *view_border;

- (void)bindData:(NSDictionary *)course;

@end

NS_ASSUME_NONNULL_END
