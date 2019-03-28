//
//  BaseTableViewCellProtocol.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BaseTableViewCellProtocol <NSObject>

@optional
- (void)setupViews;
- (void)bindViewModel;

@end

NS_ASSUME_NONNULL_END
