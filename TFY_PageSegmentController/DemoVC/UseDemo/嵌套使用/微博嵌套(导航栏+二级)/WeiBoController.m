//
//  WeiBoController.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WeiBoController.h"
#import "WeiBoSonController.h"
#import "TestVC.h"
#import "MJRefresh.h"
@interface WeiBoController ()

@end

@implementation WeiBoController

- (void)viewDidLoad {
    [super viewDidLoad];

    TFY_PageParam *headParam = PageParam()
    .titleArrSet(@[@"关注",@"推荐"])
    .viewControllerSet(^UIViewController *(NSInteger num) {
        if (num == 0) {  
            return [WeiBoSonController new];
        }
        return [TestVC new];
    })
    .menuPositionSet(PageMenuPositionNavi)
    .menuAnimalSet(PageTitleMenuPDD)
    .menuWidthSet(150);
    self.param = headParam;
    
    
    __weak WeiBoController* weakSelf = self;
    self.downSc.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    __strong WeiBoController *strongSelf = weakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.downSc.mj_header endRefreshing];
        });
    }];
}



@end
