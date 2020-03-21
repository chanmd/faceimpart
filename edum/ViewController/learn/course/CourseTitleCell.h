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
@property (nonatomic, strong) UILabel *label_price;
@property (nonatomic, strong) UILabel *label_price_fake;
@property (nonatomic, strong) UILabel *label_appiontment;

@property (nonatomic, strong) UIView *view_contact;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UILabel *label_name;
@property (nonatomic, strong) UILabel *label_bio;

- (void)bindDict:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
