//
//  MykCommonMacroViewController.m
//  RACDemo
//
//  Created by 慕慕跃科 on 2020/5/3.
//  Copyright © 2020 myk. All rights reserved.
//

#import "MykCommonMacroViewController.h"

@interface MykCommonMacroViewController ()

@property (nonatomic) UILabel *lbl;
@property (nonatomic) UITextField *txf;

@property (nonatomic) RACSignal *signal;

@end

@implementation MykCommonMacroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"常用宏定义";
    
    self.lbl = [[UILabel alloc] init];
    self.lbl.numberOfLines = 0;
    self.lbl.backgroundColor = [UIColor cyanColor];
    self.lbl.textColor = [UIColor whiteColor];
    [self.view addSubview:self.lbl];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_offset(10);
        make.trailing.mas_offset(-10);
        make.top.mas_offset(80);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.txf = [[UITextField alloc] init];
    self.txf.backgroundColor = [UIColor orangeColor];
    self.txf.textColor = [UIColor whiteColor];
    [self.view addSubview:self.txf];
    [self.txf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.lbl);
        make.top.equalTo(self.lbl.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self test4];
}

-(void)text1{
    //输入内容改变就会发出信号
    //把label的text属性绑定了输入框的输入信号
    RAC(self.lbl, text) = self.txf.rac_textSignal;
    //label的值放生变化，会发出信号
    [RACObserve(self.lbl, text) subscribeNext:^(id x) {
        NSLog(@"x ==== %@",x);
    }];
//    [self.txf.rac_textSignal subscribeNext:^(NSString *x) {
//        self.lbl.text = x;
//    }];
}

-(void)text2{
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"x   ==== %@",x);
    }];
}

//元祖
-(void)text3{
    RACTuple *tuple = RACTuplePack(@(1),@(2),@(3));
    NSLog(@"first === %@",tuple.first);
    RACTupleUnpack(NSNumber *first,NSNumber *second, NSNumber *third) = tuple;
    NSLog(@"%@--%@--%@",first,second,third);
}

//解决循环引用
-(void)test4{
    @weakify(self)
    self.signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSLog(@"--%@",self.view);
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
