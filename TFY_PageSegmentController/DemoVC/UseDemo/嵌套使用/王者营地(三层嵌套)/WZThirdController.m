


//
//  WZThirdController.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WZThirdController.h"
#import "topSuspensionVC.h"
#import "UIImageView+WebCache.h"
@interface WZThirdController ()<TFY_PageProtocol>

@end

@implementation WZThirdController
- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"资讯",@"视频",@"其他"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        return [topSuspensionVC new];
    })
    ///如果第一层嵌套开启悬浮  二三层也要开启
    ///举一反三 只有第二层开启的话 第三层也要开启
    ///如果是最后一层开启则上级不需要开启
    .topSuspensionSet(YES)
    .menuIndicatorColorSet([UIColor orangeColor])
    .menuTitleSelectColorSet([UIColor orangeColor])
    .menuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

@end
