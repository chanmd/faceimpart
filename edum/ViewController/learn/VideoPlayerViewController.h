//
//  VideoPlayerViewController.h
//  edum
//
//  Created by Md Chen on 11/9/2021.
//  Copyright © 2021 MD Chen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerViewController : BaseViewController

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) UIView *canvas;
@property (nonatomic, strong) UIButton *button_close;

@end

NS_ASSUME_NONNULL_END

