//
//  XQNetWorkUtil.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//网络请求枚举
typedef NS_ENUM(NSInteger, HttpMethod) {
    GET = 0,
    POST,
    PUT,
    DELETE,
};

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface XQNetWorkUtil : NSObject

#pragma 监测网络的可链接性
+ (void) netWorkReachability:(NetWorkBlock)isConnection;

/**
 *[AFNetWorking]的operationManager对象
 */
@property (nonatomic, strong) AFHTTPSessionManager* operationManager;

/**
 *当前的请求operation队列
 */
@property (nonatomic, strong) NSOperationQueue* operationQueue;

/**
 *功能: 创建CMRequest的对象方法
 */
+ (instancetype)request;

/**
 *功能：网络请求
 *参数：(1)请求的参数:params
 *     (2)请求的方式:httpMethod
 (1)请求的URL:server
 *     (3)请求成功调用的Block: completeblock
 *     (4)请求失败调用的Block: errorblock
 */

- (void)NetRequestWithParameters:(NSDictionary *)params
                      httpMethod:(HttpMethod)method
                      requestURL:(NSString *)server
                   completeBlock:(ReturnValueBlock)completeblock
                      errorBlock:(ErrorCodeBlock)errorblock;

/**
 *取消当前请求队列的所有请求
 */
- (void)cancelAllOperations;


@end

NS_ASSUME_NONNULL_END
