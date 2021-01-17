//
//  TFY_WZSecondController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_WZSecondController.h"
#import "TFY_WZThirdController.h"
#import "TFY_TestVC.h"
@interface TFY_WZSecondController ()

@end

@implementation TFY_WZSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"推荐",@"赛事",@"短视频",@"专栏",@"新时代",@"电竞",@"游戏",@"汽车"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 1) {
            return [TFY_WZThirdController new];
        }
        return [TFY_TestVC new];
    })
    .menuTitleSelectColorSet([UIColor orangeColor])
    .menuAnimalSet(PageTitleMenuCircle);
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
