//
//  VideoCallViewController.h
//  edum
//
//  Created by Md Chen on 7/7/2020.
//  Copyright © 2020 MD Chen. All rights reserved.
//

#import "BaseViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

FOUNDATION_EXPORT NSString *const appID;
FOUNDATION_EXPORT NSString *const token;

NS_ASSUME_NONNULL_BEGIN

@interface VideoCallViewController : BaseViewController <AgoraRtcEngineDelegate>

@property (nonatomic, strong) NSDictionary *course_data;

@end

NS_ASSUME_NONNULL_END
