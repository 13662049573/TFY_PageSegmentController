//
//  GuestureViewController.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/10/14.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "GuestureViewController.h"

@interface GuestureViewController ()

@end

@implementation GuestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavi:@[@"不响应",@"首个响应",@"全部响应"]];
    
    TFY_PageParam *param = TFY_PageParam.new;
    param.titleArr = @[@"精选",@"好货",@"精选",@"好货"];
    param.viewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    /// 首个响应
    param.respondGuestureType = PagePopFirst;
//    /// 全部响应
//    param.respondGuestureType = PagePopAll;
//    /// 不响应
//    param.respondGuestureType = PagePopNone;
    
    ///type为PagePopAll时的响应范围
    param.globalTriggerOffset = PageVCWidth * 0.15;
    self.param = param;
    
}

- (void)customNavi:(NSArray*)arr{
    NSMutableArray *marr = NSMutableArray.new;
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [marr addObject:barItem];
    }
    self.navigationItem.rightBarButtonItems = marr;
}

- (void)onBtnAction:(UIButton*)sender{
    self.param.menuDefaultIndex = sender.tag == 2 ? 1 : 0;
    
    /// 响应调用代码
    self.param.respondGuestureType = sender.tag;
    [self updateMenuData];
}

@end
