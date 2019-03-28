//
//  BaseViewModelProtocol.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DataStatus) {
    HeaderRefreshData = 0,   //刷新数据
    HeaderRefreshNoMoreData, //停止刷新
    FooterLoadMoreData,      //加载数据
    FooterLoadNoMoreData,    //停止加载
    RefreshError,            //刷新失败
    RefreshUI,               //刷新UI
};

@protocol BaseViewModelProtocol <NSObject>

@optional
- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)initIalize;


@end

NS_ASSUME_NONNULL_END
