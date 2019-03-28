//
//  RACCommonMethodVC.m
//  ReactiveObjc+MVVM
//
//  Created by work on 2019/3/28.
//  Copyright © 2019 XQ. All rights reserved.
//

//RAC最核心最基本的概念就是这些，
//四个名词类：RACEvent（事件），RACSignal（信号），RACSubscriber（发送者），RACDisposable   清理者）；
//三个动词：创建（create），订阅（subscribe），发送/清理（dispose）。


#import "RACCommonMethodVC.h"
#import "Person.h"

@interface RACCommonMethodVC ()

@property (nonatomic, strong) Person * person;

@property (nonatomic, strong) UITextField * textOneField;
@property (nonatomic, strong) UITextField * textTwoField;
@property (nonatomic, strong) UIButton * sendButton;


@end

@implementation RACCommonMethodVC

- (Person *)person{
    if (_person == nil){
        _person = [[Person alloc] init];
    }
    return _person;
}

-(UITextField *)textOneField {
    if (_textOneField == nil) {
        _textOneField = [[UITextField alloc] init];
        _textOneField.borderStyle = UITextBorderStyleRoundedRect;
        _textOneField.backgroundColor = [UIColor redColor];
    }
    return _textOneField;
}

-(UITextField *)textTwoField {
    if (_textTwoField == nil) {
        _textTwoField = [[UITextField alloc] init];
        _textTwoField.borderStyle = UITextBorderStyleRoundedRect;
        _textTwoField.backgroundColor = [UIColor redColor];
    }
    return _textTwoField;
}

-(UIButton *)sendButton {
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = [UIColor blueColor];
        //监听button 点击事件
        @weakify(self);
        [[_sendButton rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             @strongify(self);
             NSLog(@"点击了button");
         }];
    }
    return _sendButton;
}



-(void)baseaAddSubviews {
   
    [self.view addSubview:self.textOneField];
    [self.textOneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(120);
        make.size.mas_equalTo(CGSizeMake(200, 30)).priorityHigh();
    }];
    
    [self.view addSubview:self.textTwoField];
    [self.textTwoField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.equalTo(self.textOneField.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 30)).priorityHigh();
    }];
    
    [self.view addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(120);
        make.top.equalTo(self.textTwoField.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(200, 30)).priorityHigh();
    }];
    
    [super updateViewConstraints];
}

-(void)baseBindViewModel {
    
//    [self foreachObj];
    
//     [self racKvo];
//    [self setPersonName];
//    [self sendTextField];

//  [self racNotification];
    
//    [self racTime];
    
    [self combineLatestTextField];
}

#pragma -mark 文本框输入事件监听
/**
  监听多个文本框 控制button
 */
- (void)combineLatestTextField {
    @weakify(self);
    //合并信号 将combineLatest:后面的数组中的信合打包成为一个新的信号。只有当两个信号都成功发送过信号的时候打包后的信号才能正常执行订阅后的代码块
    RACSignal * signal = [RACSignal combineLatest:@[self.textOneField.rac_textSignal,
                                                   self.textTwoField.rac_textSignal]
                                          reduce:^(NSString *oneFieldTextStr, NSString *twoFieldTextStr){
                                              @strongify(self);
                                              self.sendButton.backgroundColor  = (oneFieldTextStr.length > 5 && twoFieldTextStr.length > 5) ? [UIColor magentaColor] : [UIColor blueColor];
                                              return @(oneFieldTextStr.length > 5 && twoFieldTextStr.length > 5 );
                                          }];
    RAC(self.sendButton, enabled) = signal;
//  RAC() 绑定信号 可以是控件 可以是对象 属性
    RAC(self.person,name) = self.textOneField.rac_textSignal;
    RAC(self.person,age) = self.textTwoField.rac_textSignal;

    /*
    // merge 被合并的信号有任意一个完成发送都能正常被订阅接收信号
    RACSignal * mergeSina = [[RACSignal merge:@[self.textOneField.rac_textSignal,
                                         self.textTwoField.rac_textSignal]]
                      subscribeNext:^(id  _Nullable x) {
                           @strongify(self);
                           NSLog(@"信号merge发送信号 %@",x);

    }];
    */
}


/**
  定时器
 */
- (void)racTime {
    
    //1 循环执行 RACSchedulerPriority 枚举类型 执行优先级 RACSchedulerPriorityBackground 可在后台调用
    [[RACReplaySubject interval:1 onScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityLow]] subscribeNext:^(NSDate * _Nullable x) {
        // x 是当前的时间
        NSLog(@"每隔一秒调用订阅代码：x = %@ , 在线程 thread = %@",x,[NSThread currentThread]);
    }];
    
//    //2 延迟执行
//    [[[RACReplaySubject createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@"~~2秒后执行"];
//        return nil ;
//    }] delay:2] // 延时 2秒
//     subscribeNext:^(id  _Nullable x) {
//         NSLog(@"2秒后调用订阅代码：x = %@ , 在线程 thread = %@",x,[NSThread currentThread]);
//     }];

}

/**
    监听通知
 */
- (void)racNotification {
    // 监听通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"racNotificationObj" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"NSNotification 1 x = %@",x.object);
    }];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"racNotificationObj" object:@"发出通知事件"];
}


/**
 * 监听文本框的输入内容，并用kvo监听属性值变化
 */
- (void)sendTextField {
    @weakify(self);
    //1 监听文本输入
    [[self.textOneField rac_textSignal] subscribeNext:^(id x) {
         @strongify(self);
         NSLog(@"监听文本框的输入内容 == %@",x);
         self.person.name = x;
     }];
    
    //2 过滤文本输入
    [[self.textOneField.rac_textSignal filter:^BOOL(id value) {
          NSString *text = value;
          //长度大于5才执行下方的打印方法
          return text.length > 5;
    }] subscribeNext:^(id x) {
         NSLog(@">=5%@", x);
    }];
    
    
    //map（映射）把原信号的值映射成一个新的值（还有其它concat(顺序)，then(连接)，merge(合并)，zipWith(压缩)，reduce(聚合)等信号操作方法，详情查询API）
    [[self.textOneField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        value = [NSString stringWithFormat:@"张三+%@", value];
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

#pragma -mark KVO 监听
- (void)racKvo {
    NSLog(@"1次");
    @weakify(self)
    [RACObserve(self.person, name) subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"person name属性的值 == %@",x);
    }];
}

- (void)setPersonName {
    self.person.name = @"张三";
}


#pragma -mark 遍历数组
- (void)foreachObj {
    //1 遍历数组
    NSArray * list = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    RACSignal *letters = list.rac_sequence.signal;
    // Outputs: A B C D E F G H I
    [letters subscribeNext:^(NSString *x) {
        NSLog(@"subscribeNext: %@", x);
    }];
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象) 有序遍历
    NSDictionary *dict = @{@"name":@"张三",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        NSLog(@"%@ %@",key,value);
    }];
    
}



- (void)uadataView {
    self.title = @"RAC事件监听";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
