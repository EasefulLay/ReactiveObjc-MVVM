//
//  ViewController.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "ViewController.h"
#import "HomeListView.h"
#import "HomeLIstViewModel.h"
#import "RACCommonMethodVC.h"


@interface ViewController ()

@property (nonatomic, strong) HomeListView * homeListView;
@property (nonatomic, strong) HomeLIstViewModel * homeLIstViewModel;

@end

@implementation ViewController

-(HomeListView *)homeListView {
    if (_homeListView == nil) {
        _homeListView = [[HomeListView alloc] initWithViewModel:self.homeLIstViewModel];
    }
    return _homeListView;
}

-(HomeLIstViewModel *)homeLIstViewModel {
    if (_homeLIstViewModel == nil) {
        _homeLIstViewModel = [[HomeLIstViewModel alloc] init];
    }
    return _homeLIstViewModel;
}


- (void)baseaAddSubviews {
    [self.view addSubview:self.homeListView];
    
    [self.homeListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)baseBindViewModel {
   //订阅视图模型点击信号
   @weakify(self)
    [self.homeLIstViewModel.clickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        RACCommonMethodVC * commonMethodVC = [[RACCommonMethodVC alloc] init];
        [self.navigationController pushViewController:commonMethodVC animated:YES];
    }];
}

- (void)uadataView {
    self.title = @"微博";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
