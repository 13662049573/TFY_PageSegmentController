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
    param.TitleArr = @[@"精选",@"好货",@"精选",@"好货"];
    param.ViewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    /// 首个响应
    param.RespondGuestureType = PagePopFirst;
//    /// 全部响应
//    param.RespondGuestureType = PagePopAll;
//    /// 不响应
//    param.RespondGuestureType = PagePopNone;
    
    ///type为PagePopAll时的响应范围
    param.GlobalTriggerOffset = PageVCWidth * 0.15;
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
    self.param.MenuDefaultIndex = sender.tag == 2 ? 1 : 0;
    
    /// 响应调用代码
    self.param.RespondGuestureType = sender.tag;
    [self updateMenuData];
}

@end
