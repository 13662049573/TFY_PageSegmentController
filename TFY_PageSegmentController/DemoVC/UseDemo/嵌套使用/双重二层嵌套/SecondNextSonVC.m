


//
//  SecondNextSonVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/1/7.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "SecondNextSonVC.h"
#import "topSuspensionVC.h"
@interface SecondNextSonVC ()

@end

@implementation SecondNextSonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        return [topSuspensionVC new];
    })
    .topSuspensionSet(YES)
    /// 设为NO 则需要手动调整
    .lazyLoadingSet(NO)
    .menuTitleSelectColorSet([UIColor orangeColor])
    .menuAnimalSet(PageTitleMenuCircle);
    param.customNaviBarY = ^CGFloat(CGFloat nowY) {
        return nowY;
    };
    param.customTabbarY = ^CGFloat(CGFloat nowY) {
        return nowY;
    };
    param.customDataViewHeight = ^CGFloat(CGFloat nowY) {
        /// 再减掉父类的菜单高度
        return nowY - PageVCTabBarHeight - 55;
    };
    self.param = param;
}


@end
