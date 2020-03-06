//
//  BaseWebViewController.m
//  gwlx
//
//  Created by Kevin Chan on 18/4/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () <WKUIDelegate, WKNavigationDelegate>

@end

@implementation BaseWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.requestURL]];
    [self hud_show];
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight)];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self hud_hide];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
