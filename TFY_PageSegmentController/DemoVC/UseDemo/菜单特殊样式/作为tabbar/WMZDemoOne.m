//
//  WMZDemoOne.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/6/4.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZDemoOne.h"
#import "WMZDemoOneSonVC.h"
@interface WMZDemoOne ()

@end

@implementation WMZDemoOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[
        @{TFY_PageKeyName:@"首页",TFY_PageKeyImage:@"B",TFY_PageKeyBadge:@(-1)} ,
        @{TFY_PageKeyName:@"收藏",TFY_PageKeyBadge:@"99+",TFY_PageKeyImage:@"C"},
        @{TFY_PageKeyName:@"消息",TFY_PageKeyBadge:@(99),TFY_PageKeyImage:@"D"},
        @{TFY_PageKeyName:@"我的",TFY_PageKeyImage:@"B"}
    ])
    //自定义红点
    .customRedViewSet(^(UILabel *redLa,NSDictionary *info) {

    })
     .customTabbarYSet(^CGFloat(CGFloat nowY) {
         return nowY;
     })
    /// 不自动隐藏红点
    .hideRedCircleSet(NO)
    //菜单标题颜色
    .menuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
    //菜单标题选中的颜色
    .menuTitleSelectColorSet(PageDarkColor(UIColor.orangeColor, [UIColor orangeColor]))
    //菜单背景颜色
    .menuBgColorSet(UIColor.whiteColor)
    .menuIndicatorWidthSet(self.view.frame.size.width / 9)
    .menuAnimalSet(PageTitleMenuNone)
    .menuHeightSet(PageVCTabBarHeight)
    .menuPositionSet(PageMenuPositionBottom)
    .menuTitleWidthSet(self.view.frame.size.width / 4)
    .controllersSet(@[[[UINavigationController alloc]initWithRootViewController:[WMZDemoOneSonVC new]],[WMZDemoOneSonVC new],[WMZDemoOneSonVC new],[WMZDemoOneSonVC new]]);
     self.param = param;
}

@end
