//
//  ExploreCell.h
//  edum
//
//  Created by Md Chen on 6/3/22.
//  Copyright © 2022 MD Chen. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^didTouchSingleCell)(NSInteger section, NSInteger row);

@interface ExploreCell : BaseTableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, copy) didTouchSingleCell touchBlock;


@end

NS_ASSUME_NONNULL_END
