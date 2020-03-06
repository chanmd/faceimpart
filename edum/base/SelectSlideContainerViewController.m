//
//  SelectSlideContainerViewController.m
//  Broker
//
//  Created by Mac on 15/6/18.
//  Copyright (c) 2015年 九州证券. All rights reserved.
//

#import "SelectSlideContainerViewController.h"

@interface SelectSlideContainerViewController () <UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *pageScrollView;

@end

@implementation SelectSlideContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initContentSubViewsWithTitleArray:self.selectionControllers];
}

- (void)initContentSubViewsWithTitleArray:(NSArray *)array
{
        //  多页切换控制
        [self.view addSubview:self.pageScrollView];
        
        [self addContentViewController];
}

//- (NSInteger)selectedButtonIndex
//{
//    return [self.separateView indexSelectedButton];
//}

/**
 *  AddSubControllers
 */
- (void)addContentViewController
{
    CGFloat viewHeight = APPScreenHeight + 20;
    CGFloat viewWidth = APPScreenWidth;

    for (int index = 0; index < self.selectionControllers.count; index ++) {
        UIViewController *controller = [self.selectionControllers objectAtIndex:index];
        
        controller.view.frame = CGRectMake(viewWidth * index, 0, viewWidth, viewHeight);
        
        [controller willMoveToParentViewController:self];
        
        [_pageScrollView addSubview:controller.view];
        
        [self addChildViewController:controller];
        [controller didMoveToParentViewController:self];
    }
    
    
    if (self.selectionControllers.count > 0) {
        _pageScrollView.contentSize = CGSizeMake(APPScreenWidth * self.selectionControllers.count, 0);
    }
}
/**
 *  SubControllers End
 */

- (UIScrollView *)pageScrollView
{
    if (!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight + 20)];
        _pageScrollView.scrollsToTop = NO;
        _pageScrollView.bounces = NO;
        _pageScrollView.delegate = self;
        _pageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.backgroundColor = [UIColor yellowColor];
    }
    
    return _pageScrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    self.segmentControl.selectedSegmentIndex = index;
}


//  MARK: 是否可以改变导航标签
- (BOOL)separateViewShouldChangeMenuAtIndex:(long)index
{
    if (!self.selectionControllers) {
        return NO;
    }
    _pageScrollView.contentOffset = CGPointMake(index * APPScreenWidth, 0);
    
    return YES;
}


@end
