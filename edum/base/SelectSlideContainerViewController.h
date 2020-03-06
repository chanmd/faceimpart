//
//  SelectSlideContainerViewController.h
//  Broker
//
//  Created by Mac on 15/6/18.
//  Copyright (c) 2015年 九州证券. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+BFExtension.h"

@interface SelectSlideContainerViewController : BaseViewController

@property (nonatomic,strong)NSArray *selectionControllers;
@property (nonatomic,strong)NSArray *functionTitles;
@property (nonatomic,strong)UISegmentedControl *segmentControl;

- (BOOL)separateViewShouldChangeMenuAtIndex:(long)index;
@end
