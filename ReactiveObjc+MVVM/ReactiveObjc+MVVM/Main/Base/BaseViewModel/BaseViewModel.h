//
//  BaseViewModel.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject<BaseViewModelProtocol>

@property (strong, nonatomic)XQNetWorkUtil * request;


@end

NS_ASSUME_NONNULL_END
