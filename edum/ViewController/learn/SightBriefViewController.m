//
//  SightBriefViewController.m
//  gwlx
//
//  Created by Kevin Chan on 29/9/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "SightBriefViewController.h"
#import "UIImageEffects.h"
#import "UILabel+LineSpace.h"

@interface SightBriefViewController ()

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button_cancel;

@end

@implementation SightBriefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageview];
    [self.view addSubview:self.scrollview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithImage:self.image];
        _imageview.frame = [[UIScreen mainScreen] bounds];
    }
    return _imageview;
}

- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y)];
        [_scrollview addSubview:self.label];
//        [_scrollview addSubview:self.button_cancel];
    }
    return _scrollview;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label.font = __font(18);
        _label.textColor = __color_font_title;
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _label;
}

- (UIButton *)button_cancel
{
    if (!_button_cancel) {
        _button_cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight)];
        [_button_cancel addTarget:self action:@selector(___action_back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_cancel;
}

#pragma mark - actions

- (void)bindData:(NSString *)string
{
    [self.label setText:string lineSpacing:SIGHT_DETAIL_LINESPACE];
    [self.label sizeToFit];
    CGFloat height = [UILabel text:string font:__font(18) width:APPScreenWidth - 30 lineSpacing:SIGHT_DETAIL_LINESPACE];
    if (height + 60 > APPScreenHeight) {
        self.scrollview.contentSize = CGSizeMake(APPScreenWidth, height + 60);
    }
}

- (void)___action_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
