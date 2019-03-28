//
//  UIView+UIViewController.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/28.
//  Copyright © 2019 XQ. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (UIViewController)


/**
 通过响应链关系 得到当前视图所在的视图控制器 获得视图控制器属性和方法
 */
- (UIViewController *)viewController;


@end

NS_ASSUME_NONNULL_END
