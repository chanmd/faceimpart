//
//  SightScrollCell.h
//  gwlx
//
//  Created by Kevin Chan on 11/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SightScrollCell : BaseTableViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *array_data;

@property (nonatomic, assign) NSInteger section_index;

typedef void (^Button_TouchUpInside_Block)(NSInteger tag, NSInteger index);

@property (nonatomic, copy) Button_TouchUpInside_Block block;

- (void)bindData;

@end
