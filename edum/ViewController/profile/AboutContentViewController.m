//
//  AboutContentViewController.m
//  gwlx
//
//  Created by Kevin Chan on 18/11/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "AboutContentViewController.h"
#import "NSDictionary+JSONExtern.h"
#import "UILabel+LineSpace.h"

@interface AboutContentViewController()

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UILabel *label;

@end

@implementation AboutContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollview];
    [self ___fetch_content];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight + 44)];
        [_scrollview addSubview:self.label];
    }
    return _scrollview;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPScreenWidth - 30, 20)];
        _label.font = __fontlight(18);
        _label.textColor = __color_font_subtitle;
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _label;
}

- (void)bindData:(NSString *)string
{
    [self.label setText:string lineSpacing:3];
    [self.label sizeToFit];
    CGFloat height = [UILabel text:string font:__fontlight(18) width:APPScreenWidth - 30 lineSpacing:3];
    self.scrollview.contentSize = CGSizeMake(APPScreenWidth, height + 44 + 30);
}


- (void)___fetch_content
{
    NSString *url = [NSString stringWithFormat:@"/about?type=%@", self.content_type];
    WeakSelf;
    [AFR requestWithUrl:url
             httpmethod:@"POST"
                 params:[NSMutableDictionary dictionary]
          finishedBlock:^(id responseObject){
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"-------userinfo---%@", tempDic);
        if ([[tempDic objectForKey:@"code"] isEqualToString:@"0"]) {
            NSDictionary *data = [tempDic dictionaryForKey:@"data"];
            weakSelf.title = [data stringForKey:@"title"];
            [weakSelf bindData:[data stringForKey:@"content"]]; 
        }
    } failedBlock:^(NSError *errorInfo){
        
    }];
}


@end
