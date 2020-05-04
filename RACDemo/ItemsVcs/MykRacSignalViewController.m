//
//  MykRacSignalViewController.m
//  RACDemo
//
//  Created by 慕慕跃科 on 2020/5/4.
//  Copyright © 2020 myk. All rights reserved.
//

#import "MykRacSignalViewController.h"

@interface MykRacSignalViewController ()

@end

@implementation MykRacSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
}

-(void)test1{
    //创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //发布信号
        [subscriber sendNext:@"123"];
//        [subscriber sendCompleted];
        [subscriber sendNext:@"444"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
    }];
    //订阅
    [signal subscribeNext:^(id x) {
        NSLog(@"x === %@",x);
    }];
    [signal subscribeCompleted:^{
        NSLog(@"完成");
    }];
}


/**
 *  RACSignal总结：
 一.核心：
    1.核心：信号类
    2.信号类的作用：只要有数据改变就会把数据包装成信号传递出去
    3.只要有数据改变就会有信号发出
    4.数据发出，并不是信号类发出，信号类不能发送数据
 一.使用方法：
    1.创建信号
    2.订阅信号
 二.实现思路：
    1.当一个信号被订阅，创建订阅者，并把nextBlock保存到订阅者里面。
    2.创建的时候会返回 [RACDynamicSignal createSignal:didSubscribe];
    3.调用RACDynamicSignal的didSubscribe
    4.发送信号[subscriber sendNext:value];
    5.拿到订阅者的nextBlock调用
 */

@end
