//
//  WeiBoSonController.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WeiBoSonController.h"
#import "TopSuspensionVC.h"
@interface WeiBoSonController ()
@end

@implementation WeiBoSonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TFY_PageParam *param = PageParam()
    .TitleArrSet(@[@"热门",@"同城",@"榜单",@"抽奖",@"新时代",@"电竞",@"游戏",@"汽车"])
    .MenuFixRightDataSet(@" + ")
    .ViewControllerSet(^UIViewController *(NSInteger index) {
        TopSuspensionVC *vc = [TopSuspensionVC new];
         vc.page = index;
         return vc;
     })
    .TopSuspensionSet(YES)
    .MenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 200);
        back.backgroundColor = UIColor.redColor;
        return back;
    })
    /// 如果设为NO 则自己需要根据实际场景手动调整 wCustomTabbarY wCustomNaviY 默认YES
    .LazyLoadingSet(NO)
    .MenuTitleSelectColorSet([UIColor orangeColor])
    .MenuAnimalSet(PageTitleMenuNone);
    /// 根据实际情况设置
    param.CustomTabbarY = ^CGFloat(CGFloat nowY) {
        return PageVCTabBarHeight;
    };
    /// 根据实际情况设置
    param.CustomNaviBarY  = ^CGFloat(CGFloat nowY) {
        return 0;
    };
    self.param = param;
}

@end
