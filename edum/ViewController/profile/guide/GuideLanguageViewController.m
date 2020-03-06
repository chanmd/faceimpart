//
//  GuideLanguageViewController.m
//  gwlx
//
//  Created by Kevin Chan on 5/1/2018.
//  Copyright © 2018 Kevin. All rights reserved.
//

#import "GuideLanguageViewController.h"
#import "MJRefresh.h"
#import "NSDictionary+JSONExtern.h"
#import "DestinationHeader.h"

@interface GuideLanguageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;
@property (nonatomic, strong) NSMutableArray *array_continet;

@end

@implementation GuideLanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.label_title.text = @"Languages";
    [self.view addSubview:self.tableView];
    self.array_data = [NSMutableArray arrayWithArray:@[@"English", @"中文", @"Español", @"Français", @"Deutsch"]];
    //self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(___fetch_countries)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [[NSMutableArray alloc] init];
    }
    return _array_data;
}

- (NSMutableArray *)array_continet
{
    if (!_array_continet) {
        _array_continet = [[NSMutableArray alloc] init];
    }
    return _array_continet;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BASE_TABLEVIEW_Y, APPScreenWidth, APPFullScreenHeight - BASE_TABLEVIEW_Y)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = __color_gray_separator;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = __color_white;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = __font(16);
        cell.textLabel.textColor = __color_font_title;
    }
    NSString *language = [self.array_data objectAtIndex:indexPath.row];
    cell.textLabel.text = language;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    NSString *language = [self.array_data objectAtIndex:indexPath.row];
    if (self.block) {
        self.block(language);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - requests

- (void)___fetch_countries
{
    NSString *url = [NSString stringWithFormat:@"%@/destinations", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    WeakSelf;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        [weakSelf.tableView.mj_header endRefreshing];
        if (![[tempDic objectForKey:@"error"] boolValue]) {
//            NSArray *array = [tempDic arrayForKey:@"data"];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

@end
