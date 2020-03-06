//
//  BaseTableViewController.h
//  edum
//
//  Created by Kevin Chan on 3/7/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIView *view_empty;
@property (nonatomic, strong) UIImageView *image_empty;
@property (nonatomic, strong) UILabel *label_empty;

@end

NS_ASSUME_NONNULL_END
