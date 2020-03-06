//
//  GuideContentViewController.h
//  gwlx
//
//  Created by Kevin Chan on 5/1/2018.
//  Copyright © 2018 Kevin. All rights reserved.
//

#import "BasePresentController.h"

typedef void (^addContent)(NSString *languagestring);

@interface GuideContentViewController : BasePresentController

@property (nonatomic, strong) NSString *content_preview;
@property (nonatomic, strong) addContent block;

@end
