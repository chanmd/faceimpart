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

@interface BannerView() <UIScrollViewDelegate>

@end

@implementation BannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = __color_white;
        [self addSubview:self.label_title];
        [self addSubview:self.scrollview];
        [self addSubview:self.pagecontrol];
//        [self addSubview:self.filterview];
    }
    return self;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth, 20)];
        _label_title.font = __fontmedium(18);
        _label_title.text = @"乐器";
    }
    return _label_title;
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, APPScreenWidth, APPScreenWidth / 2)];
        _scrollview.delegate = self;
//        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.showsVerticalScrollIndicator = NO;
    }
    return _scrollview;
}

- (UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, APPScreenWidth / 2 - 25, 80, 20)];
        _pagecontrol.centerX = self.centerX;
    }
    return _pagecontrol;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = self.scrollview.frame.size.width; // you need to have a **iVar** with getter for scrollView
//    float fractionalPage = self.scrollview.contentOffset.x / pageWidth;
//    NSInteger page = lround(fractionalPage);
//    self.pagecontrol.currentPage = page; // you need to have a **iVar** with getter for pageControl
//}

- (void)bindData:(NSArray *)data
{
    NSArray *array_filter = data;
    self.scrollview.contentSize = CGSizeMake((CATEGORY_WIDTH + 10) * array_filter.count + 10, CATEGORY_HEIGHT + 5);
    
    for (UIView *subview in [self.scrollview subviews]) {
        
        [subview removeFromSuperview];
        
    }
    self.pagecontrol.numberOfPages = array_filter.count;
    self.pagecontrol.currentPage = 0;
    
    
    for (UIView *subview in [self.scrollview subviews]) {
        
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i < array_filter.count; i ++) {
        
        NSDictionary *dic = [array_filter objectAtIndex:i];
        NSString *url = [dic stringForKey:@"imageurl"];
        NSString *title = [dic stringForKey:@"name"];
        CategoryView *category = [[CategoryView alloc] initWithFrame:CGRectMake((CATEGORY_WIDTH + 10) * i + 10, 0, CATEGORY_WIDTH, CATEGORY_HEIGHT)];
        category.label_title.text = title;
        [category.imageview_cover sd_setImageWithURL:[NSURL URLWithString:url]];
        category.button.tag = i;
        [category.button addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollview addSubview:category];
    }
}

- (void)action_button:(UIButton *)button
{
    NSLog(@"click:%ld", button.tag);
    if (self.block) {
        self.block(button.tag);
    }
}

@end
