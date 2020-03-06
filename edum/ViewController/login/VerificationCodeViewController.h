//
//  VerificationCodeViewController.h
//  edum
//
//  Created by Kevin Chan on 12/2/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DoneLogin)(NSString *phone_number);

@interface VerificationCodeViewController : BaseViewController

@property (nonatomic, strong) NSString *phone_number;
@property (nonatomic, strong) DoneLogin block;

@end

NS_ASSUME_NONNULL_END
