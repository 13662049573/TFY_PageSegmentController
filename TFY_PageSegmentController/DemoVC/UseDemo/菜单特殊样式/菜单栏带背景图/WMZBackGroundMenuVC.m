//
//  WMZBackGroundMenuVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/10/22.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZBackGroundMenuVC.h"
#import "topSuspensionVC.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface WMZBackGroundMenuVC ()
@end

@implementation WMZBackGroundMenuVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    TFY_PageParam *param =
    PageParam()
    .viewControllerSet(^UIViewController *(NSInteger index) {
        topSuspensionVC *vc = [topSuspensionVC new];
        vc.page = index;
        return vc;
    })
    .menuBgColorSet([UIColor colorWithRed:0 green:0 blue:0 alpha:0])
    .titleArrSet(data)
    .menuAnimalSet(PageTitleMenuPDD)
    .menuDefaultIndexSet(3)
    .menuInsetsSet(UIEdgeInsetsMake(PageVCStatusBarHeight + 20, 20, 0, 20))
    .menuHeightSet(60)
    .bouncesSet(YES)
    .fromNaviSet(NO);
    self.param = param;
    
    //延迟0.1秒加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImageView *image = [UIImageView new];
        [self.upSc insertSubview:image belowSubview:self.upSc.mainView];
        image.image = [UIImage imageNamed:@"11111"];
        image.frame = CGRectMake(0, 0, PageVCWidth, PageVCStatusBarHeight + 20 + 60);
        
        
        //返回按钮
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        back.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [back setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.upSc addSubview:back];
        [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(20, PageVCStatusBarHeight, 60, 20);
    });
}

@end
