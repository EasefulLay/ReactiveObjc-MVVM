//
//  HomeListTableViewCell.h
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "BaseTableViewCell.h"

@class HomeListModel;
NS_ASSUME_NONNULL_BEGIN

@interface HomeListTableViewCell : BaseTableViewCell

@property (nonatomic, strong) HomeListModel * homeListModel;

@end

NS_ASSUME_NONNULL_END
