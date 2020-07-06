//
//  FollowingCell.h
//  edum
//
//  Created by Kevin Chan on 27/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FollowingCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;
@property (nonatomic, strong) UIButton *button_follow;

- (void)bindFollowingWithData:(NSDictionary *)data;
- (void)bindFollowingStatus:(NSInteger)status;

@end

NS_ASSUME_NONNULL_END
