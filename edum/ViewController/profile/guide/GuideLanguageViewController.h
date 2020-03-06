//
//  GuideLanguageViewController.h
//  gwlx
//
//  Created by Kevin Chan on 5/1/2018.
//  Copyright © 2018 Kevin. All rights reserved.
//

#import "BasePresentController.h"

typedef void (^selectLanguage)(NSString *languagestring);

@interface GuideLanguageViewController : BasePresentController

@property (nonatomic, strong) selectLanguage block;

@end
