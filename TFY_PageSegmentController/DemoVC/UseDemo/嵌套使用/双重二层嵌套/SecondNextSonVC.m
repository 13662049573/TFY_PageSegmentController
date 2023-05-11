


//
//  SecondNextSonVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/1/7.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "SecondNextSonVC.h"
#import "TopSuspensionVC.h"
@interface SecondNextSonVC ()

@end

@implementation SecondNextSonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .TitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏"])
    .ViewControllerSet(^UIViewController *(NSInteger index) {
        return [TopSuspensionVC new];
    })
    .TopSuspensionSet(YES)
    /// 设为NO 则需要手动调整
    .LazyLoadingSet(NO)
    .MenuTitleSelectColorSet([UIColor orangeColor])
    .MenuAnimalSet(PageTitleMenuCircle);
    param.CustomNaviBarY = ^CGFloat(CGFloat nowY) {
        return nowY;
    };
    param.CustomTabbarY = ^CGFloat(CGFloat nowY) {
        return nowY;
    };
    param.CustomDataViewHeight = ^CGFloat(CGFloat nowY) {
        /// 再减掉父类的菜单高度
        return nowY - PageVCTabBarHeight - 55;
    };
    self.param = param;
}


@end
