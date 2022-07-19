//
//  LandingArticleCell.h
//  edum
//
//  Created by Kevin Chan on 31/1/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LandingArticleCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_subtitle;
@property (nonatomic, strong) UIImageView *imageview_cover;

- (void)bindElementWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
