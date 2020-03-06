//
//  GuideEditViewController.m
//  gwlx
//
//  Created by Kevin Chan on 30/10/2017.
//  Copyright © 2017 Kevin. All rights reserved.
//

#import "GuideEditViewController.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "BaseUser.h"
#import "GuideHeaderView.h"
#import "GuideGeneralCell.h"
#import "GuideEditViewController.h"
#import "GuideLanguageViewController.h"
#import "GuideContentViewController.h"
#import "UIImage+ImageCompress.h"
//#import <AWSS3/AWSS3.h>

#define HEADER_HEIGHT 90

@interface GuideEditViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array_data;

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIImageView *imageview_avatar;
@property (nonatomic, strong) UIButton *button_avatar;
@property (nonatomic, strong) UIImageView *imageview_upload;
@property (nonatomic, strong) UIView *view_border;

@property (nonatomic, strong) NSMutableArray *array_datasource;

@property (nonatomic, strong) NSString *image_path;

@end

@implementation GuideEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"编辑个人资料";
    [self setup_right_button];
    [self.view addSubview:self.tableView];
//    [self ___fetch_user_info];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setup_right_button
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:__color_main forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action_save) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (NSString *)getDateString
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy/MM/dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    curTime = [NSString stringWithFormat:@"%@/%.0f", curTime, [curDate timeIntervalSince1970]];
    return curTime;
}

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, HEADER_HEIGHT)];
        [_header addSubview:self.imageview_avatar];
        [_header addSubview:self.imageview_upload];
        [_header addSubview:self.view_border];
        [_header addSubview:self.button_avatar];
    }
    return _header;
}

- (UIImageView *)imageview_avatar
{
    if (!_imageview_avatar) {
        _imageview_avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
        _imageview_avatar.clipsToBounds = YES;
        _imageview_avatar.layer.cornerRadius = 3.f;
        _imageview_avatar.image = [UIImage imageNamed:@"logo_launch"];
    }
    return _imageview_avatar;
}

- (UIImageView *)imageview_upload
{
    if (!_imageview_upload) {
        _imageview_upload = [[UIImageView alloc] initWithFrame:CGRectMake(APPScreenWidth - 40, 35, 20, 20)];
        _imageview_upload.image = ImageNamed(@"photo");
    }
    return _imageview_upload;
}

- (UIButton *)button_avatar
{
    if (!_button_avatar) {
        _button_avatar = [UIButton buttonWithType:UIButtonTypeCustom];
        _button_avatar.frame = CGRectMake(0, 0, APPScreenWidth, HEADER_HEIGHT);
        [_button_avatar addTarget:self action:@selector(action_upload) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button_avatar;
}

- (UIView *)view_border
{
    if (!_view_border) {
        _view_border = [[UIView alloc] initWithFrame:CGRectMake(5, HEADER_HEIGHT - 1, APPScreenWidth - 10, 0.5)];
        _view_border.backgroundColor = __color_gray_separator;
    }
    return _view_border;
}


- (NSMutableArray *)array_data
{
    if (!_array_data) {
        _array_data = [NSMutableArray array];
        _array_data = [NSMutableArray arrayWithArray:@[@"乐器", @"级别", @"个人简介", @"地区"]];
    }
    return _array_data;
}

- (NSMutableArray *)array_datasource
{
    if (!_array_datasource) {
        _array_datasource = [NSMutableArray arrayWithArray:@[@"大提琴", @"二级", @"这个人太懒，什么都没有", @"中国 北京"]];
    }
    return _array_datasource;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPFullScreenHeight - 44)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = __color_white;
        _tableView.tableHeaderView = self.header;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array_data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    GuideGeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GuideGeneralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *title = [self.array_data objectAtIndex:indexPath.row];
    NSString *subtitle = [self.array_datasource objectAtIndex:indexPath.row];
    cell.label_title.text = title;
    cell.label_subtitle.width = APPScreenWidth;
    cell.label_subtitle.text = subtitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        GuideLanguageViewController *languagevc = [[GuideLanguageViewController alloc] init];
        WeakSelf;
        languagevc.block = ^(NSString *languagestring){
            [weakSelf.array_datasource replaceObjectAtIndex:0 withObject:languagestring];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:languagevc animated:YES completion:nil];
        
    } else if (indexPath.row == 1) {
        
        GuideContentViewController *languagevc = [[GuideContentViewController alloc] init];
        WeakSelf;
        languagevc.block = ^(NSString *languagestring){
            [weakSelf.array_datasource replaceObjectAtIndex:1 withObject:languagestring];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:languagevc animated:YES completion:nil];
        
    } else if (indexPath.row == 2) {
        
        GuideContentViewController *languagevc = [[GuideContentViewController alloc] init];
        WeakSelf;
        languagevc.block = ^(NSString *languagestring){
            [weakSelf.array_datasource replaceObjectAtIndex:2 withObject:languagestring];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:languagevc animated:YES completion:nil];
        
    }
}

- (void)___fetch_user_info9
{
    NSString *url = [NSString stringWithFormat:@"%@/user", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parms = @{@"user_id": BASEUSER.user_id};
    WeakSelf;
    [manager POST:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            NSDictionary *user_information = [tempDic dictionaryForKey:@"data"];
            NSString *fb_url = @"";
            [weakSelf.imageview_avatar sd_setImageWithURL:[NSURL URLWithString:fb_url] placeholderImage:[UIImage imageNamed:@"logo_avatar"]];
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

- (void)action_save
{
    [self request_save_user_info];
}

- (void)request_save_user_info
{
    NSString *url = [NSString stringWithFormat:@"%@/update_user", SERVER_DOMAIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //TODO remove emoji and illegal chars.
    NSDictionary *parms = @{@"user_id": BASEUSER.user_id, @"languages": [self.array_datasource objectAtIndex:0], @"bio": [self.array_datasource objectAtIndex:1], @"address": [self.array_datasource objectAtIndex:2], @"fb_picture":self.image_path};
    WeakSelf;
    [manager POST:url parameters:parms success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *tempDic = (NSDictionary *)responseObject;
        NSLog(@"----------%@", tempDic);
        if (![[tempDic objectForKey:@"error"] boolValue]) {
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf hud_textonly:@"Nothing happened!"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf hud_textonly:RESPONSE_ERROR_MESSAGE];
    }];
}

/*

- (void)uploadToS3:(UIImage *)img
{
    [self hud_show];
    int random_index = arc4random_uniform(10000);
    NSString *imagename = [NSString stringWithFormat:@"%@_%d.png", BASEUSER.user_id, random_index];
    self.image_path = [NSString stringWithFormat:@"https://s3-ap-northeast-1.amazonaws.com/beento-img/%@/%@", @"user_avatars", imagename];
    // create a local image that we can use to upload to s3
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:imagename];
    NSData *imageData = UIImagePNGRepresentation(img);
    [imageData writeToFile:path atomically:YES];
    
    // once the image is saved we can use the path to create a local fileurl
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
    // next we set up the S3 upload request manager
    AWSS3TransferManagerUploadRequest *_uploadRequest = [AWSS3TransferManagerUploadRequest new];
    // set the bucket
    _uploadRequest.bucket = @"beento-img";
    // I want this image to be public to anyone to view it so I'm setting it to Public Read
    _uploadRequest.ACL = AWSS3ObjectCannedACLPublicRead;
    // set the image's name that will be used on the s3 server. I am also creating a folder to place the image in
    _uploadRequest.key = [NSString stringWithFormat:@"user_avatars/%@", imagename];
    // set the content type
    _uploadRequest.contentType = @"image/png";
    // we will track progress through an AWSNetworkingUploadProgressBlock
    _uploadRequest.body = url;
    
    //    WeakSelf;
    _uploadRequest.uploadProgress =^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend){
        dispatch_sync(dispatch_get_main_queue(), ^{
            //
            
        });
    };
    
    // now the upload request is set up we can creat the transfermanger, the credentials are already set up in the app delegate
    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    // start the upload
    
    WeakSelf;
    
    [[transferManager upload:_uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                        withBlock:^id(AWSTask *task) {
                                                            [self hud_hide];
                                                            if (task.error) {
                                                                if ([task.error.domain isEqualToString:AWSS3TransferManagerErrorDomain]) {
                                                                    switch (task.error.code) {
                                                                        case AWSS3TransferManagerErrorCancelled:
                                                                        case AWSS3TransferManagerErrorPaused:
                                                                            break;
                                                                            
                                                                        default:
                                                                            NSLog(@"Error: %@", task.error);
                                                                            break;
                                                                    }
                                                                } else {
                                                                    // Unknown error.
                                                                    NSLog(@"Error: %@", task.error);
                                                                }
                                                            }
                                                            
                                                            if (task.result) {
                                                                //                                                               AWSS3TransferManagerUploadOutput *uploadOutput = task.result;
                                                                weakSelf.imageview_avatar.image = img;
                                                            }
                                                            return nil;
                                                        }];
    
}

- (UIImage*)getSubImageFrom: (UIImage*) img WithRect: (CGRect) rect {
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, img.size.width, img.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // draw image
    [img drawInRect:drawRect];
    
    // grab image
    UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return subImage;
}

 */
 
- (void)action_upload
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate = self;
        controller.allowsEditing = YES;
        [self.navigationController presentViewController:controller animated:YES completion:^{
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *compress = [UIImage compressImage:image
                                       compressRatio:0.1];
    UIImage *crop_image = [self imageWithImage:compress scaledToSize:CGSizeMake(300, 300)];
//    [self uploadToS3:crop_image];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

