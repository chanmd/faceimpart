//
//  ExploreCourseCell.h
//  edum
//
//  Created by Md Chen on 6/12/22.
//  Copyright © 2022 MD Chen. All rights reserved.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExploreCourseCell : BaseCollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label_type;
@property (nonatomic, strong) UILabel *label_intensity;
@property (nonatomic, strong) UILabel *label_duration;

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_teachername;

@property (nonatomic, strong) NSDictionary *dictionaryData;

@end

NS_ASSUME_NONNULL_END
