//
//  PaymentViewController.h
//  edum
//
//  Created by Kevin Chan on 28/3/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface PaymentViewController : BaseViewController

@property (nonatomic, strong) NSMutableDictionary *course;
@property (nonatomic, strong) NSString *course_id;

@end

NS_ASSUME_NONNULL_END
