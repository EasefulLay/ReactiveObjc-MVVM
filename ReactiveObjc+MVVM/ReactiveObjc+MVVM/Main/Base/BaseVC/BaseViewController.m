//
//  BaseViewController.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


//allol 调用allocWithZone方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController baseaAddSubviews];
        [viewController baseBindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController uadataView];
        [viewController getNewData];
    }];
    return viewController;
}



-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    if (self == [super init]) {
    }
    return self;
}


- (void)baseaAddSubviews {
    
}

- (void)baseBindViewModel {
    
}


- (void)uadataView {
    
}

- (void)getNewData {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}


@end
