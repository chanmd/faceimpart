//
//  UITableView+YYAdditions.m
//  YYProduct
//
//  Created by suchangqin on 13-9-11.
//  Copyright (c) 2013年 suchangqin. All rights reserved.
//

#import "UITableView+YYAdditions.h"

@implementation UITableView (YYAdditions)

-(void)cleanBackgroundViewAndBackgroundColor{
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
}

-(UIView *) ____clearView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

/*
-(void) removeTableHeaderView{
    if (self.style == UITableViewStyleGrouped) {
        if (DYY_APP_IOS_VERSION_ABOVE_7_0) {
            self.tableHeaderView = [self ____clearView];
            return;
        }
    }
    self.tableHeaderView = nil;
}

-(void)removeTableFooterView{
    if (self.style == UITableViewStyleGrouped) {
        if (DYY_APP_IOS_VERSION_ABOVE_7_0) {
            self.tableFooterView = [self ____clearView];
            return;
        }
    }
    self.tableFooterView = nil;
}
*/
-(void)cleanBottomSeparatorLines{
    if (self.style == UITableViewStylePlain && self.tableFooterView == nil) {
        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(0, 0, 320, 1);
        view.backgroundColor = [UIColor clearColor];
        self.tableFooterView = view;
    }
}
@end
