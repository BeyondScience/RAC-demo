//
//  MykBaseViewController.m
//  RACDemo
//
//  Created by 慕慕跃科 on 2020/5/3.
//  Copyright © 2020 myk. All rights reserved.
//

#import "MykBaseViewController.h"

@interface MykBaseViewController ()

@end

@implementation MykBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    NSLog(@"销毁了--%@",[self class]);
}

@end
