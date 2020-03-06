//
//  CalendarGridViewController.m
//  edum
//
//  Created by Kevin Chan on 26/5/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "CalendarGridViewController.h"

@interface CalendarGridViewController ()

@end

@implementation CalendarGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBar.hidden = YES;
    [self.button_b setImage:ImageNamed(@"tab_calendar_h") forState:UIControlStateNormal];
    //    [MobClick beginLogPageView:@"mainview"];
}

@end
