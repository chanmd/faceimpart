//
//  BannerView.m
//  gwlx
//
//  Created by Chan Kevin on 14/9/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import "BannerView.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"
#import "NSDictionary+JSONExtern.h"
#import "UIButton+WebCache.h"
#import "CategoryView.h"
#import "NSTimer+UnretainCircle.h"

@interface BannerView() <UIScrollViewDelegate>

@end

@implementation BannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = __color_white;
        [self addSubview:self.scrollview];
        [self addSubview:self.pagecontrol];
        
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat index = scrollView.contentOffset.x / APPScreenWidth;
    self.pagecontrol.currentPage = (int)floor(index);
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 15, APPScreenWidth, APPScreenWidth / 2)];
        _scrollview.delegate = self;
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
    }
    return _scrollview;
}

- (UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, BANNER_HEIGHT - 20, 80, 20)];
        _pagecontrol.centerX = self.centerX;
        _pagecontrol.currentPage = 0;
    }
    return _pagecontrol;
}

- (void)bindData:(NSMutableArray *)array_data
{
    self.scrollview.contentSize = CGSizeMake(APPScreenWidth * array_data.count, BANNER_HEIGHT);
    
    for (UIView *subview in [self.scrollview subviews]) {
        [subview removeFromSuperview];
    }
    self.pagecontrol.numberOfPages = array_data.count;
    self.pagecontrol.currentPage = 0;
    
    for (UIView *subview in [self.scrollview subviews]) {
        
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i < array_data.count; i ++) {
        
        NSDictionary *dic = [array_data objectAtIndex:i];
        NSString *url = [dic stringForKey:@"url"];
        NSString *title = [dic stringForKey:@"title"];
        CategoryView *category = [[CategoryView alloc] initWithFrame:CGRectMake(APPScreenWidth * i, 0, APPScreenWidth, BANNER_HEIGHT)];
        category.label_title.text = title;
        [category.imageview_cover sd_setImageWithURL:[NSURL URLWithString:url]];
        category.button.tag = i;
        [category.button addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:category];
    }
    self.pagecontrol.currentPage = 0;
    WeakSelf;
    self.timer = [NSTimer proxyScheduledTimerWithTimeInterval:5.f repeats:YES block:^(NSTimer *timer){
        if (weakSelf.pagecontrol.currentPage < [array_data count] - 1) {
//            NSLog(@"%ld", weakSelf.pagecontrol.currentPage);
            weakSelf.pagecontrol.currentPage ++;
            [weakSelf.scrollview setContentOffset:CGPointMake(weakSelf.pagecontrol.currentPage * APPScreenWidth, 0) animated:YES];
        } else {
            weakSelf.pagecontrol.currentPage = 0;
            [weakSelf.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)action_button:(UIButton *)button
{
    NSLog(@"click%ld", button.tag);
    if (self.block) {
        self.block(button.tag);
    }
}

@end
