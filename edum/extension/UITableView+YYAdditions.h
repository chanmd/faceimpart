//
//  UITableView+YYAdditions.h
//  YYProduct
//
//  Created by suchangqin on 13-9-11.
//  Copyright (c) 2013年 suchangqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (YYAdditions)

// 清楚背景颜色和背景视图
-(void) cleanBackgroundViewAndBackgroundColor;

// tableview header空白问题兼容修改
//-(void) removeTableHeaderView;
//-(void) removeTableFooterView;
//清除多余的间隔线
-(void)  cleanBottomSeparatorLines;
@end
