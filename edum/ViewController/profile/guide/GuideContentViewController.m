//
//  GuideContentViewController.m
//  gwlx
//
//  Created by Kevin Chan on 5/1/2018.
//  Copyright © 2018 Kevin. All rights reserved.
//

#import "GuideContentViewController.h"
#import "UITextView+Placeholder.h"
#import "NSDictionary+JSONExtern.h"

@interface GuideContentViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data_question;

@property (nonatomic, strong) UITextView *textview_desc;

@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UIButton *button_done;

@end

@implementation GuideContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.label_title.text = @"Edit";
    [self.view insertSubview:self.tableView atIndex:1];
    [self.view_navigationbar addSubview:self.button_done];
    NSArray *array_question = @[@"About me"];
    [self.array_data_question addObjectsFromArray:array_question];
    [self.textview_desc becomeFirstResponder];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)array_data_question
{
    if (!_array_data_question) {
        _array_data_question = [NSMutableArray array];
    }
    return _array_data_question;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_white;
        //        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 98)];
        [_footer addSubview:self.button_done];
    }
    return _footer;
}


- (UIButton *)button_done
{
    if (!_button_done) {
        _button_done = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_done.frame = CGRectMake(APPScreenWidth - 60, 32, 60, 20);
        _button_done.clipsToBounds = YES;
        [_button_done setTitle:@"Done" forState:UIControlStateNormal];
        [_button_done setTitleColor:__color_main forState:UIControlStateNormal];
//        [[_button_done layer] setCornerRadius:2.f];
//        [[_button_done layer] setBorderColor:[__color_main CGColor]];
//        [[_button_done layer] setBorderWidth:0.5f];
        //        [[_button_addone layer] setBackgroundColor:[__color_main CGColor]];
        [[_button_done titleLabel] setFont:__font(16)];
        [_button_done addTarget:self action:@selector(action_done) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_done;
}

- (void)action_done
{
    if (self.textview_desc.text.length == 0 ) {
        [self hud_textonly:@"Nothing"];
    } else if (self.textview_desc.text.length > 200) {
        [self hud_textonly:@"Too long"];
    } else {
        if (self.block) {
            self.block(self.textview_desc.text);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UITextView *)textview_desc
{
    if (!_textview_desc) {
        _textview_desc = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, APPScreenWidth - 20, 260)];
        _textview_desc.font = __font(20);
        _textview_desc.textColor = __color_font_title;
        _textview_desc.delegate = self;
    }
    return _textview_desc;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    [self animateTextViewWithup:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    [self animateTextViewWithup:NO];
}

- (void)animateTextViewWithup: (BOOL) up
{
    const int movementDistance = 170; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.tableView.frame = CGRectOffset(self.tableView.frame, 0, movement);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array_data_question count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    return view;
}

 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        [self.textview_desc removeFromSuperview];
        [cell.contentView addSubview:self.textview_desc];
    }
    return cell;
}

@end

