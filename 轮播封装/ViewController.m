//
//  ViewController.m
//  轮播封装
//
//  Created by lc on 16/7/26.
//  Copyright © 2016年 lcnicky. All rights reserved.
//

#import "ViewController.h"
#import "LCScorllowView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}

#pragma mark - 页面搭建
- (void)createUI{
    
    
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:tableView ];
    
    //scrollview
    NSMutableArray *mArray = [NSMutableArray new];
    for (int i = 1 ; i <= 4; i ++) {
        NSString *name = [NSString stringWithFormat:@"一起去旅行%d.jpg",i] ;
        [mArray addObject:name ];
    }
    LCScorllowView *scrollowview = [[LCScorllowView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) images:mArray];
    scrollowview.timeInterval = 2 ;
    //设置前景颜色
    scrollowview.foregroundColor = [UIColor whiteColor];
    //设置后景颜色
    scrollowview.backgroundColor = [UIColor  lightGrayColor] ;
    
    [scrollowview addTarget:self action:@selector(onclick)];
    
    [tableView setTableHeaderView:scrollowview];
    //[self.view addSubview:scrollowview];
}

#pragma mark - 点击事件
- (void)onclick{
    NSLog(@"hahaha");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
