//
//  SecondNestVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/1/7.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "SecondNestVC.h"
#import "SecondNextSonVC.h"
@interface SecondNestVC ()

@end

@implementation SecondNestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .TitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏"])
    .ViewControllerSet(^UIViewController *(NSInteger index) {
        return [SecondNextSonVC new];
    })
    /// 设为NO 则需要手动调整
    .LazyLoadingSet(NO)
    .MenuTitleSelectColorSet([UIColor orangeColor])
    .MenuAnimalSet(PageTitleMenuCircle);
    
    self.param = param;
}

@end
