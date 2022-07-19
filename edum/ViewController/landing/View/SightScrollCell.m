//
//  SightScrollCell.m
//  gwlx
//
//  Created by Kevin Chan on 11/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "SightScrollCell.h"
#import "SightCubeView.h"

@implementation SightScrollCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, LANDING_SIGHT_HEIGHT + GENERAL_CUBE_HEIGHT)];
//        _scrollView.backgroundColor = __color_gray_background;
        _scrollView.backgroundColor = __color_white;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)bindData
{
    if ([[self.scrollView subviews] count] > 0) {
        for (UIView *view in [self.scrollView subviews]) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i < self.array_data.count; i ++) {
        SightCubeView *view = [[SightCubeView alloc] initWithFrame:CGRectMake((LANDING_SIGHT_WIDTH + GENERAL_PADDING) * i, 0, LANDING_SIGHT_WIDTH + GENERAL_PADDING, LANDING_SIGHT_HEIGHT + 50)];
        NSDictionary *dic = [self.array_data objectAtIndex:i];
        view.button.tag = i;
        [view.button addTarget:self action:@selector(___action_button:) forControlEvents:UIControlEventTouchUpInside];
        [view bindData:dic];
        [self.scrollView addSubview:view];
    }
    self.scrollView.contentSize = [self contentSizeForPagingScrollView];
}

- (void)___action_button:(UIButton *)button
{
    if (self.block) {
        self.block(button.tag, self.section_index);
    } else {
        NSLog(@"Stop touching, fucking unimplement block function");
    }
}

- (CGSize)contentSizeForPagingScrollView
{
    return CGSizeMake((LANDING_SIGHT_WIDTH + GENERAL_PADDING) * [self.array_data count] + GENERAL_PADDING, LANDING_SIGHT_HEIGHT + 55);
}

@end
