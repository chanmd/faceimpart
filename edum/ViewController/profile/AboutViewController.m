//
//  AboutViewController.m
//  gwlx
//
//  Created by Kevin Chan on 11/10/2016.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "AboutViewController.h"
#import "UILabel+LineSpace.h"

@interface AboutViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIImageView *imageview_logo;
@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) UILabel *label_from;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = NSLocalizedString(@"whytravel", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = __color_white;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = [UIColor colorWithHEX:0xe5e5e5];
        _tableView.tableHeaderView = self.header;
        _tableView.tableFooterView = self.footer;
    }
    return _tableView;
}

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, (APPScreenWidth - 40) * 0.6654 + 50)];
        [_header addSubview:self.imageview_logo];
    }
    return _header;
}

- (UIImageView *)imageview_logo
{
    if (!_imageview_logo) {
        _imageview_logo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, APPScreenWidth - 40, (APPScreenWidth - 40) * 0.6654)];
        _imageview_logo.image = ImageNamed(@"OberynMartell");
        _imageview_logo.clipsToBounds = YES;
        _imageview_logo.layer.cornerRadius = 1.f;
    }
    return _imageview_logo;
}


- (UIView *)footer
{
    if (!_footer) {
        _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 200)];
        [_footer addSubview:self.label_from];
    }
    return _footer;
}

- (UILabel *)label_from
{
    if (!_label_from) {
        _label_from = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, APPScreenWidth - 44, 20)];
        _label_from.font = __fontthin(22);
        _label_from.textColor = __color_font_title;
        _label_from.numberOfLines = 0;
        _label_from.lineBreakMode = NSLineBreakByWordWrapping;
        NSString *string = @"It is a big and beautiful world. \nMost of us live and die in the same corner where we were born and never get to see any of it. \nI don’t want to be most of us.\n\nOberyn Martell";
        [_label_from setText:string lineSpacing:4];
        [_label_from sizeToFit];
    }

    return _label_from;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



@end
