//
//  HomeListView.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/27.
//  Copyright © 2019 XQ. All rights reserved.
//

#import "HomeListView.h"
#import "HomeLIstViewModel.h"
#import "HomeListTableViewCell.h"
#import "RACCommonMethodVC.h"

static NSString * cellId = @"homeListTableViewCell.h";

@interface HomeListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * homeListTableView;
@property (nonatomic, strong) HomeLIstViewModel * homeLIstViewModel;


@end

@implementation HomeListView

//-(HomeLIstViewModel *)homeLIstViewModel {
//    if (_homeLIstViewModel == nil) {
//        _homeLIstViewModel = [[HomeLIstViewModel alloc] init];
//    }
//    return _homeLIstViewModel;
//}

//初始化视图模型转化
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.homeLIstViewModel = (HomeLIstViewModel* )viewModel;
    return [super initWithViewModel:self.homeLIstViewModel];
}

/**
 加载子视图
 */
-(void)setupViews {
    [self addSubview:self.homeListTableView];
    //RAC @weakify(self) / @strongify(self) 组合解除循环引用；
    //每往里一层 调用一次 @strongify(self) 释放信号
    @weakify(self);
    [self.homeListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
}


/**
    绑定模型 刷新视图
 */
-(void)bindViewModel {
    
    //初始化数据信号
    [self.homeLIstViewModel.refreshDataCommand execute:nil];
    
    //订阅刷新信号
    @weakify(self);
    [self.homeLIstViewModel.refreshEndSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
         [self.homeListTableView reloadData];
         //判断刷新动作
         //结束刷新
         [self.homeListTableView.mj_header endRefreshing];
    }];
    
}


-(UITableView *)homeListTableView {
    if (_homeListTableView == nil) {
        _homeListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _homeListTableView.delegate = self;
        _homeListTableView.dataSource = self;
        [_homeListTableView registerClass:[HomeListTableViewCell class] forCellReuseIdentifier:cellId];
        @weakify(self);
        _homeListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            //执行信号调用
            [self.homeLIstViewModel.refreshDataCommand execute:nil];
        }];
        
    }
    return _homeListTableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //加载视图模型数据
    return self.homeLIstViewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}

//cel 模型赋值 , UITableView+FDTemplateLayoutCell获取自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellH = [tableView fd_heightForCellWithIdentifier:cellId cacheByIndexPath:indexPath configuration:^(HomeListTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    NSLog(@"cellH ======= %f",cellH);
    return cellH;
}


- (void)configureCell:(HomeListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.homeListModel = self.homeLIstViewModel.dataArray[indexPath.row];
}


//发送视图模型 点击信号
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //1通过RAC信号传递 跳转控制器 弊端不灵活 mvvm最终又回到了C
    //[self.homeLIstViewModel.clickSubject sendNext:self.homeLIstViewModel.dataArray[indexPath.row]];
    //2响应链事件 在视图中跳转控制器 回归mvvm
    RACCommonMethodVC * commonMethodVC = [[RACCommonMethodVC alloc] init];
    [self.viewController.navigationController pushViewController:commonMethodVC animated:YES];
}



@end
