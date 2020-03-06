//
//  SightBriefViewController.h
//  gwlx
//
//  Created by Kevin Chan on 29/9/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "BaseViewController.h"

@interface SightBriefViewController : BaseViewController

@property (nonatomic, strong) UIImage *image;

- (void)bindData:(NSString *)string;

@end
