//
//  ReplaceParentVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/8/11.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "ReplaceParentVC.h"
#import "ReplaceParentSonVC.h"
@interface ReplaceParentVC ()

@end

@implementation ReplaceParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *headParam = PageParam()
    .titleArrSet(@[@"关注",@"推荐"])
    .viewControllerSet(^UIViewController *(NSInteger num) {
        return [ReplaceParentSonVC new];
    })
    .menuPositionSet(PageMenuPositionCenter)
    .menuAnimalSet(PageTitleMenuPDD)
    .menuWidthSet(150);
    self.param = headParam;
}

@end
