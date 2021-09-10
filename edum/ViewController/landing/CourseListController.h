//
//  CourseListController.h
//  edum
//
//  Created by Md Chen on 27/8/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseListController : BaseViewController

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) NSString *category;

@end

NS_ASSUME_NONNULL_END
