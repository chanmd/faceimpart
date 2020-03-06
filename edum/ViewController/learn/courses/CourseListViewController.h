//
//  CourseListViewController.h
//  edum
//
//  Created by Kevin Chan on 26/9/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BasePresentController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseListViewController : BasePresentController

@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) NSDictionary *dict_info;

@end

NS_ASSUME_NONNULL_END
