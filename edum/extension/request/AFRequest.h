//
//  AFRequest.h
//  edum
//
//  Created by Kevin Chan on 30/12/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AFRequest;

typedef void(^RequestFinishBlock)(id responseObject);
typedef void(^RequestFailBlock)(NSError * errorInfo);

#define AFR [[AFRequest alloc] init]


@interface AFRequest : NSObject

/**
 返回参数字典
 */
@property(nonatomic,strong)NSDictionary *dataDic;

/**
 网址请求String
 */
@property(nonatomic,strong)NSString *urlString;

/**
 数据请求完成
 */
@property(nonatomic,copy)RequestFinishBlock  finishedBlock;
/**
 数据请求失败
 */
@property(nonatomic,copy)RequestFailBlock  failedBlock;


-(void)requestWithUrl:(NSString*)url
           httpmethod:(NSString*)httpMethod
               params:(NSMutableDictionary*)params
        finishedBlock:(RequestFinishBlock) finishedBlock
          failedBlock:(RequestFailBlock) faildedBlock;

- (NSMutableURLRequest *)requestUrl:(NSString *)url
                         httpMethod:(NSString *)method
                          httpParms:(NSDictionary *)parms;

- (NSMutableURLRequest *)requestUrlWithGET:(NSString *)url
                   httpParms:(NSDictionary *)parms;


- (NSString *)header_body:(NSDictionary *)parms;


@end

NS_ASSUME_NONNULL_END
