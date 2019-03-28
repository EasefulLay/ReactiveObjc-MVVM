//
//  HomeLIstViewModel.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeLIstViewModel : BaseViewModel

/**
 刷新和加载 信号类对象
 创建了一个RACCommand类的对象，并将传入的block保存为 signalBlock 属性，然后初始化了一个信号数组，留待以后接收命令信号
 */
@property (nonatomic, strong) RACCommand *refreshDataCommand;
@property (nonatomic, strong) RACCommand *nextPageCommand;

/**
 刷新信号
 */
@property (nonatomic, strong) RACSubject *refreshEndSubject;


/**
 视图点击事件信号
 */
@property (nonatomic, strong) RACSubject *clickSubject;


/**
 存储数据数组
 */
@property (nonatomic, strong) NSArray *dataArray;


@end

NS_ASSUME_NONNULL_END
