//
//  BaseViewModel.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initIalize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)initIalize {

}

- (XQNetWorkUtil *)request {
    if (!_request) {
        _request = [XQNetWorkUtil request];
    }
    return _request;
}

@end
