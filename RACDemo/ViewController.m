//
//  ViewController.m
//  RACDemo
//
//  Created by 慕慕跃科 on 2020/5/3.
//  Copyright © 2020 myk. All rights reserved.
//

#import "ViewController.h"
#import "MykCommonMacroViewController.h"//常见宏定义
#import "MykRacSignalViewController.h"
#import "MykRacCommandViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tabView;

@property (nonatomic, copy) NSArray <NSString *>*arrData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrData = @[@"常见宏",@"RacSignal",@"RACCommand"];
    
    self.tabView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabView.dataSource = self;
    self.tabView.delegate = self;
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tabView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.arrData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[MykCommonMacroViewController new] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[MykRacSignalViewController new] animated:YES];
    }else if (indexPath.row == 2){
        [self.navigationController pushViewController:[MykRacCommandViewController new] animated:YES];
    }
}



@end
