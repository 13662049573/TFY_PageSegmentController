//
//  TFY_WeiBoSonController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_WeiBoSonController.h"
#import "TFY_TestVC.h"

@interface TFY_WeiBoSonController ()

@end

@implementation TFY_WeiBoSonController

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"热门",@"同城",@"榜单",@"抽奖",@"新时代",@"电竞",@"游戏",@"汽车"])
    .menuFixRightDataSet(@" + ")
    .viewControllerSet(^UIViewController *(NSInteger index) {
        TFY_TestVC *vc = [TFY_TestVC new];
         vc.page = index;
         return vc;
     })
    .menuTitleSelectColorSet([UIColor orangeColor])
//    //减掉导航栏高度+tabbar高度(根据实际情况)
    .customDataViewHeightSet(^CGFloat(CGFloat nowY) {
        return nowY ;
    })
    .menuAnimalSet(PageTitleMenuNone);
    self.param = param;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
