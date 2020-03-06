//
//  BaseWebViewController.h
//  gwlx
//
//  Created by Kevin Chan on 18/4/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWebViewController : BaseViewController

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURL *requestURL;

@end
