//
//  BannerView.h
//  gwlx
//
//  Created by Chan Kevin on 14/9/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectCategory)(NSInteger selectCategory);

@interface BannerView : UIView

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIPageControl *pagecontrol;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) didSelectCategory block;

- (void)bindData:(NSMutableArray *)array_data;

@end
