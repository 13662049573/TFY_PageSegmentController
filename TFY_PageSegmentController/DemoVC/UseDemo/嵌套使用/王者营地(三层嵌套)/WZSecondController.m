//
//  WZSecondController.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WZSecondController.h"
#import "TopSuspensionVC.h"
#import "WZThirdController.h"
#import "UIImageView+WebCache.h"
@interface WZSecondController ()

@end

@implementation WZSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFY_PageParam *param = PageParam()
    .TitleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏",@"新时代",@"电竞",@"游戏",@"汽车"])
    .TopSuspensionSet(YES)
    .ViewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 1) {
            return [WZThirdController new];
        }
        return [TopSuspensionVC new];
    })
    .MenuTitleSelectColorSet([UIColor orangeColor])
    .MenuAnimalSet(PageTitleMenuCircle);
    self.param = param;
}

@end
