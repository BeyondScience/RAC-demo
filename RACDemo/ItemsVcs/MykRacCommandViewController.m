//
//  MykRacCommandViewController.m
//  RACDemo
//
//  Created by 慕慕跃科 on 2020/5/4.
//  Copyright © 2020 myk. All rights reserved.
//

#import "MykRacCommandViewController.h"

@interface MykRacCommandViewController ()

@end

@implementation MykRacCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test5];
}

-(void)test1{
    //创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input === %@",input);//11
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CGFloat num = [input floatValue];
            [subscriber sendNext:@(num * num)];
            return nil;
        }];
    }];
    //执行命令
    RACSignal *signal = [command execute:@(11)];// 这里其实用到的是replaySubject 可以先发送命令再订阅
    //订阅
    [signal subscribeNext:^(id x) {
        NSLog(@"x  === %@",x);//121
    }];
}

-(void)test2{
    //创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input === %@",input);//11
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CGFloat num = [input floatValue];
            [subscriber sendNext:@(num * num)];
            return nil;
        }];
    }];
    //必须先订阅信号 才能收到信号,此时接收的是信号
    [command.executionSignals subscribeNext:^(RACSignal *x) {
        [x subscribeNext:^(id x) {
            NSLog(@"xxx === %@",x);
        }];
        NSLog(@"x === %@",x);
    }];
    //发布信号
    [command execute:@"22"];
    [command execute:@"55"];
}

-(void)test3{
    //创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"input === %@",input);//11
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            CGFloat num = [input floatValue];
            [subscriber sendNext:@(num * num)];
            return nil;
        }];
    }];
    //订阅  switchToLatest获取最新发送的信号，只能用于信号中信号。
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"x   ==== %@",x);
    }];
    //发布信号
    [command execute:@"33"];
    [command execute:@"55"];
}

-(void)test4{
    RACSubject *signalSub = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    [signalSub.switchToLatest subscribeNext:^(id x) {
        NSLog(@"x  === %@",x);
    }];
    
    [signalSub sendNext:signal];
    [signal sendNext:@"4"];
    [signal sendNext:@"10"];
}

-(void)test5{
    //注意：当前命令内部发送数据完成，一定要主动发送完成
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令的时候就会调用
        NSLog(@"%@", input);
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            
            // *** 发送完成 **
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [command.executing subscribeNext:^(id x) {
        NSLog(@"x   ==== %@",x);
    }];
    
    [command execute:@1];
    [command execute:@2];
}

@end
