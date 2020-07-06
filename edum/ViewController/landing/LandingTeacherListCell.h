//
//  LandingTeacherListCell.h
//  edum
//
//  Created by Kevin Chan on 27/5/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LandingTeacherListCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;
@property (nonatomic, strong) UIButton *button_follow;

- (void)bindTeacherListWithData:(NSDictionary *)data;
- (void)bindTeacherListFollowingStatus:(NSInteger)status;
@end

NS_ASSUME_NONNULL_END
