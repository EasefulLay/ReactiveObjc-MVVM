//
//  BaseViewProtocol.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewModelProtocol;

@protocol BaseViewProtocol <NSObject>

- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;


/**
 加载子视图
 */
- (void)setupViews;

/**
  绑定模型视图
 */
- (void)bindViewModel;




@end

NS_ASSUME_NONNULL_END
