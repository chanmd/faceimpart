//
//  CourseBriefDetailViewController.h
//  edum
//
//  Created by Kevin Chan on 17/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BasePresentController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseBriefDetailViewController : BasePresentController

@property (nonatomic, strong) UIImage *image;

- (void)bindData:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
