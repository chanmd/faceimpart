//
//  AFRequest.m
//  edum
//
//  Created by Kevin Chan on 30/12/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "AFRequest.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "UrlConstants.h"
#import "NSString+BFExtension.h"
#import "NSDictionary+JSONExtern.h"
#import "NSObject+YYAdditions.h"
#import "NSString+YYAdditions.h"
#import "FileHash.h"
#import "NSString+BFExtension.h"
#import "BTKeychain.h"

#define DATA_STAMP @"f97ce70eb9f96d44179e6391437b1cd3"

@interface AFRequest()

@end

@implementation AFRequest

- (AFHTTPRequestOperationManager* )createRequestManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    manager.responseSerializer = responseSerializer;
    return manager;
}

-(void)requestWithUrl:(NSString*)url
           httpmethod:(NSString*)httpMethod
               params:(NSMutableDictionary*)params
        finishedBlock:(RequestFinishBlock) finishedBlock
          failedBlock:(RequestFailBlock) faildedBlock
{
    AFHTTPRequestOperationManager *manager = [self createRequestManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    NSString* urlString = [NSString stringWithFormat:@"%@/%@/%@", BASE_URL, @"api", url];
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        urlString = url;
    }
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:[BTKeychain getUUID] forKey:@"deviceidentifier"];
    [paramsDic setObject:APPVERSION forKey:@"appversion"];
    [paramsDic setObject:APPTYPE forKey:@"apptype"];
    if (![BASEUSER isLogin]) {
//        [paramsDic setObject:BASEUSER.user_id forKey:@"user_id"];
//        [paramsDic setObject:BASEUSER.token forKey:@"token"];
        [paramsDic setObject:@"user_id" forKey:@"user_id"];
        [paramsDic setObject:@"123" forKey:@"token"];
    }
    
    paramsDic = [self parmarsSignWithDic:paramsDic Secret:DATA_STAMP];
    if (params) {
        NSArray *allKey=[params allKeys];
        for (int i=0; i<params.count; i++) {
            NSString *key=[allKey objectAtIndex:i];
            id value=[params objectForKey:key];
            [paramsDic setObject:value forKey:key];
        }
    }
    
    NSLog(@"%@", paramsDic);
     
    if ([httpMethod isEqualToString:@"POST"]) {
        [manager POST:urlString parameters:paramsDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = responseObject;
            NSLog(@"requestUrl-------[%@]\n responseObject-------%@",urlString,responseObject);
            NSString *code = [dic stringIntForKey:@"code"];
            NSString *message = [dic stringForKey:@"message"];
            NSLog(@"responseMsg: [%@]", message);
            if ([code isEqualToString:@"1000"] || [code isEqualToString:@"500"] || [code isEqualToString:@"401"]) {
                NSLog(@"requestUrl-------[%@]\n responseObject-------%@",urlString,responseObject);
                return;
            }
            finishedBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            faildedBlock(error);
        }];
    }else if ([httpMethod isEqualToString:@"GET"]){
        [manager GET:urlString parameters:paramsDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = responseObject;
            NSString *code = [dic stringIntForKey:@"code"];
            NSString *msg = [dic stringForKey:@"message"];
            NSLog(@"msg: %@", msg);
            if ([code isEqualToString:@"1000"] || [code isEqualToString:@"500"] || [code isEqualToString:@"401"]) {
                NSLog(@"requestUrl-------[%@]\n responseObject-------%@",urlString,responseObject);
                return;
            }
            finishedBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            faildedBlock(error);
        }];
    }
}


- (NSMutableURLRequest *)requestUrl:(NSString *)url
                         httpMethod:(NSString *)method
                          httpParms:(NSDictionary *)parms
{
    NSString* urlString = [NSString stringWithFormat:@"%@%@", BASE_URL, url];
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        urlString = url;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:method];
    NSData *data = [[self header_body:parms] dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody:data];
    return request;
}

- (NSMutableURLRequest *)requestUrlWithGET:(NSString *)url
                   httpParms:(NSDictionary *)parms
{
    NSString* urlString = [NSString stringWithFormat:@"%@/%@/%@",BASE_URL, @"api", url];
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        urlString = url;
    }
    NSString *strUrlWIthParma = [self urlAccount2Expand:urlString];
    NSString *strUrl = [strUrlWIthParma hasSuffix:@"&"] ? strUrlWIthParma : [NSString stringWithFormat:@"%@&",strUrlWIthParma];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    return request;
}

- (NSString *)urlAccount2Expand:(NSString *)url
{
    NSString *url_link = @"";
    NSRange r = [url rangeOfString:@"?"];
    NSMutableString *url_param = [NSMutableString string];
    if (NSNotFound == r.location) {
        url_link = [NSString stringWithFormat:@"%@?%@",url, url_param];
    }else{
        url_link = [NSString stringWithFormat:@"%@&%@",url, url_param];
    }
    return url_link;
}

- (NSString *)header_body:(NSDictionary *)parms
{
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    [paramsDic setObject:[BTKeychain readUUID] forKey:@"deviceidentifier"];
    [paramsDic setObject:APPVERSION forKey:@"appversion"];
    [paramsDic setObject:APPTYPE forKey:@"apptype"];
    paramsDic = [self parmarsSignWithDic:paramsDic Secret:DATA_STAMP];
    if (parms && parms.allKeys.count > 0) {
        [paramsDic setValuesForKeysWithDictionary:parms];
    }
    NSString *content = [self urlEncodedString:paramsDic];
    return content;
}

- (NSString *)urlEncodedString:(NSMutableDictionary *)dic
{
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dic) {
        id value = [dic objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

/**
 *  @author Jakey
 *
 *  @brief  下载文件
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:paramDic error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}

- (NSMutableDictionary *)parmarsSignWithDic:(NSMutableDictionary *)dics Secret:(NSString *)secret{
    //将参数键值对以字典序生序排列
    NSArray *params=[dics.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    //把前面排序好的参数集拼接在一起，
    NSString *parStrs = @"";
    for (NSString *key in params) {
        parStrs=[parStrs stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,dics[key]]];
    }
    //在拼接好的字符串末尾加上seesion_secret参数
    parStrs=[parStrs stringByAppendingString:secret];
    //获取MD5值
    NSString *signStr=[parStrs toMD5];
    //将sign值添加到参数中
    [dics setObject:signStr forKey:@"dataAuth"];
    return dics;
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

@end
