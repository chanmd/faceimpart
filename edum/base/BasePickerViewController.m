//
//  BasePickerViewController.m
//  gwlx
//
//  Created by Kevin Chan on 30/9/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "BasePickerViewController.h"

@interface BasePickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIView *view_blur;
@property (nonatomic, strong) UIButton *button_cancel;

@property (nonatomic, strong) UIView *view_accessory;
@property (nonatomic, strong) UIButton *button_done;
@property (nonatomic, strong) UIPickerView *picker;

@property (nonatomic, strong) NSString *selected_string;

@end

@implementation BasePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageview];
    [self.view addSubview:self.view_blur];
    [self.view addSubview:self.button_cancel];
    [self.view addSubview:self.view_accessory];
    [self.view addSubview:self.button_done];
    [self.view addSubview:self.picker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSArray array];
    }
    return _array_data;
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithImage:self.image];
        _imageview.frame = [[UIScreen mainScreen] bounds];
    }
    return _imageview;
}

- (UIView *)view_blur
{
    if (!_view_blur) {
        _view_blur = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _view_blur.backgroundColor = [UIColor colorWithHEX:0x000000 Alpha:0.4];
    }
    return _view_blur;
}

- (UIButton *)button_cancel
{
    if (!_button_cancel) {
        _button_cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight)];
        [_button_cancel addTarget:self action:@selector(___action_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_cancel;
}

- (UIView *)view_accessory
{
    if (!_view_accessory) {
        _view_accessory = [[UIView alloc] initWithFrame:CGRectMake(-0.5, APPFullScreenHeight - 200 - 44, APPScreenWidth + 1, 44)];
        _view_accessory.layer.borderColor = [__color_gray_separator CGColor];
        _view_accessory.layer.borderWidth = 0.5f;
        _view_accessory.backgroundColor = __color_white;
    }
    return _view_accessory;
}


- (UIButton *)button_done
{
    if (!_button_done) {
        _button_done = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_done.frame = CGRectMake(APPScreenWidth - 60, APPFullScreenHeight - 200 - 44, 60, 44);
        _button_done.clipsToBounds = YES;
        [_button_done setTitle:@"Done" forState:UIControlStateNormal];
        [_button_done setTitleColor:__color_red_main forState:UIControlStateNormal];
        [[_button_done layer] setCornerRadius:3.f];
        [[_button_done titleLabel] setFont:__font(16)];
        [_button_done addTarget:self action:@selector(action_done) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_done;
}

- (UIPickerView *)picker
{
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, APPFullScreenHeight - 200, APPScreenWidth, 200)];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.backgroundColor = __color_white;
        _picker.showsSelectionIndicator = YES;
    }
    return _picker;
}

#pragma mark - actions

- (void)___action_dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)action_done
{
    if (self.block && self.selected_string) {
        self.block(self.selected_string);
    }
    [self ___action_dismiss];
}

#pragma mark pickview datasource and delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.array_data count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = [self.array_data objectAtIndex:row];
    return string;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selected_string = [self.array_data objectAtIndex:row];
}


@end
