//
//  HomeLIstViewModel.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

//accessToken
#define ACCESSTOKEN @"2.00frMm_ERx6PzB4114099588fGT6LC"

//请求公共微博的网络接口
#define REQUESTPUBLICURL @"https://api.weibo.com/2/statuses/public_timeline.json"

#import "HomeLIstViewModel.h"
#import "HomeListModel.h"

@interface HomeLIstViewModel ()

@property (nonatomic, assign) int page;

@end


@implementation HomeLIstViewModel

//重写父类 初始化 创建信号
- (void)initIalize {
    //订阅信号
    @weakify(self);
    //skip：忽略第一次刚刚创建信号的时候，信号是非激活状态（冷信号），所以第一次对于我们的场景是无效的
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"正在加载..."];
        }
    }];
    
    //第二次 创建信号接收数据
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSDictionary * dict = x;
        self.dataArray = [HomeListModel mj_objectArrayWithKeyValuesArray:dict[@"statuses"]];
        //发送refreshEndSubject 刷新信号给视图
        [self.refreshEndSubject sendNext:@(HeaderRefreshData)];
        [SVProgressHUD dismiss];
    }];
    
}


//RACCommand 信号对象类初始化 创建双向信号 用于网络请求 事件监听
-(RACCommand *)refreshDataCommand {
    if (_refreshDataCommand == nil) {
        @weakify(self)
        _refreshDataCommand =  [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            //返回值 一个RACSubject 的单向信号 最终目的是由ViewController中发出命令，refreshDataCommand收到命令后进行网络请求，并将获取的网络数据包发送出去
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                self.page = 1;
                
                NSDictionary *parameter = @{@"access_token": ACCESSTOKEN,
                                            @"count": @"20",
                                            @"page": @(self.page)
                                            };
                
                [self.request NetRequestWithParameters:parameter httpMethod:GET requestURL:REQUESTPUBLICURL completeBlock:^(id  _Nonnull returnValue) {
                    NSLog(@"%@",returnValue);
                    //发送给initIalize方法中的refreshDataCommand信号 接收数据
                    [subscriber sendNext:returnValue];
                    //结束信号
                    [subscriber sendCompleted];
                    
                } errorBlock:^(id  _Nonnull errorCode) {
                    @strongify(self);
                    self.page --; //失败页面减一
                    [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
            
        }];
    }
    return _refreshDataCommand;
}


//RACSubject 信号对象 初始化 创建的是单向信号
- (RACSubject *)refreshEndSubject {
    if (_refreshEndSubject == nil) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

// 创建视图模型点击信号
-(RACSubject *)clickSubject {
    if (_clickSubject == nil) {
        _clickSubject = [RACSubject subject];
    }
    return _clickSubject;
}


-(NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}




@end
