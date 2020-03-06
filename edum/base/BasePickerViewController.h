//
//  BasePickerViewController.h
//  gwlx
//
//  Created by Kevin Chan on 30/9/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^selectPicker)(NSString *selectedstring);

@interface BasePickerViewController : BaseViewController

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *array_data;
@property (nonatomic, strong) selectPicker block;

@end
