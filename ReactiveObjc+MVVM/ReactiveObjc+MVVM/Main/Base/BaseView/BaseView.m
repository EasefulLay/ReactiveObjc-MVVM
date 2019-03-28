//
//  BaseView.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init
{
    if (self == [super init]) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    
    if (self == [super init]) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}


- (void)bindViewModel {
    
}


- (void)setupViews {
    
}

@end
