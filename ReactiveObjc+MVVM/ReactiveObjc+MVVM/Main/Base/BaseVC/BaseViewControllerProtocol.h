//
//  BaseViewControllerProtocol.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewModelProtocol;

@protocol BaseViewControllerProtocol <NSObject>

/**
   绑定初始化
 @param viewModel 模型视图
 */
- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;


/*
 添加子视图
 */
- (void)baseaAddSubviews;

/*
    绑定模型视图
 */
- (void)baseBindViewModel;

/**
 更新视图 子视图有特殊需要 如更改导航
 */
- (void)uadataView;

/**
   更新数据
 */
- (void)getNewData;


@end

NS_ASSUME_NONNULL_END
