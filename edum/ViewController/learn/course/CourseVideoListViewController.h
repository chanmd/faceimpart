//
//  CourseVideoListViewController.h
//  edum
//
//  Created by Md Chen on 24/10/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "BaseViewController.h"
#import <SuperPlayer/SuperPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseVideoListViewController : BaseViewController

@property (nonatomic, strong) UIView *canvas;

@property (nonatomic, strong) UIView *videoBarView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data_titles;
@property (nonatomic, strong) NSMutableArray *array_data;

@end

NS_ASSUME_NONNULL_END
