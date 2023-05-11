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
    .TitleArrSet(@[@"关注",@"推荐"])
    .ViewControllerSet(^UIViewController *(NSInteger num) {
        return [ReplaceParentSonVC new];
    })
    .MenuPositionSet(PageMenuPositionCenter)
    .MenuAnimalSet(PageTitleMenuPDD)
    .MenuWidthSet(150);
    self.param = headParam;
}

@end
