//
//  ViewController.m
//  RACDemo
//
//  Created by 慕慕跃科 on 2020/5/3.
//  Copyright © 2020 myk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tabView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    NSLog(@"111");
    [self.view addSubview:self.tabView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

@end
