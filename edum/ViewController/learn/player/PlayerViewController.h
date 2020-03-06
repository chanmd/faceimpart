//
//  PlayerViewController.h
//  edum
//
//  Created by Kevin Chan on 18/10/2018.
//  Copyright © 2018 MD Chen. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : BaseViewController

@property (nonatomic, strong) NSString *course_id;
@property (nonatomic, strong) NSString *video_id;
@property (nonatomic, strong) NSMutableDictionary *dictionary_data;

@end

NS_ASSUME_NONNULL_END
