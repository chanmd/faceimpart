//
//  UserNotificationDetailViewController.m
//  edum
//
//  Created by Kevin Chan on 5/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "UserNotificationDetailViewController.h"
#import "UILabel+LineSpace.h"

@interface UserNotificationDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_content;
@property (nonatomic, strong) UILabel *label_time;

@end

@implementation UserNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollview];
    [self bindData:self.data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight + 44)];
        [_scrollview addSubview:self.label_title];
        [_scrollview addSubview:self.label_content];
//        [_scrollview addSubview:self.label_time];
    }
    return _scrollview;
}

- (UILabel *)label_title
{
    if (!_label_title) {
        _label_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label_title.font = __fontlight(20);
        _label_title.textColor = __color_font_title;
        _label_title.numberOfLines = 0;
        _label_title.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_title;
}

- (UILabel *)label_time
{
    if (!_label_time) {
        _label_time = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label_time.font = __fontlight(16);
        _label_time.textColor = __color_font_subtitle;
        _label_time.numberOfLines = 0;
        _label_time.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_time;
}

- (UILabel *)label_content
{
    if (!_label_content) {
        _label_content = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label_content.font = __fontlight(16);
        _label_content.textColor = __color_font_subtitle;
        _label_content.numberOfLines = 0;
        _label_content.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label_content;
}

- (void)bindData:(NSDictionary *)data
{
    [self.label_title setText:[data objectForKey:@"title"] lineSpacing:3];
    [self.label_title sizeToFit];
    CGFloat title_height = [UILabel text:[data objectForKey:@"title"] font:__fontlight(18) width:APPScreenWidth - 30 lineSpacing:3];
    
    self.label_content.top = self.label_title.bottom + 15;
    [self.label_content setText:[data objectForKey:@"content"] lineSpacing:5];
    [self.label_content sizeToFit];
    CGFloat height = [UILabel text:[data objectForKey:@"content"] font:__fontlight(16) width:APPScreenWidth - 30 lineSpacing:5];
    
    self.label_time.text = [data objectForKey:@"created_at"];
    self.label_time.top = self.label_content.bottom + 15;
    self.scrollview.contentSize = CGSizeMake(APPScreenWidth, height + 44 + 30 + title_height + 40);
}

@end
