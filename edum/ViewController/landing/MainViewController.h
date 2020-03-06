//
//  MainViewController.h
//  gwlx
//
//  Created by Kevin Chan on 4/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "BannerView.h"

@interface MainViewController : BaseTabbarViewController

@property (nonatomic, strong) UILabel *label_logo;

@property (nonatomic, strong) UIButton *button_refresh;
@property (nonatomic, strong) UIButton *button_refresh_right;

@property (nonatomic, strong) BannerView *bannerview;
@property (nonatomic, strong) NSMutableArray *array_header_titles;
@property (nonatomic, strong) NSMutableDictionary *dictionary_data;

@property (nonatomic, strong) UITableView *tableview_right;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
