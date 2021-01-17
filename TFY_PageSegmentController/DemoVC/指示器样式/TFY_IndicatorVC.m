//
//  TFY_IndicatorVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_IndicatorVC.h"
#import "TFY_TestVC.h"

@interface TFY_IndicatorVC ()

@end

@implementation TFY_IndicatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //动画
    NSDictionary *animal = @{
        @(0):@(PageTitleMenuNone),
        @(1):@(PageTitleMenuLine),
        @(2):@(PageTitleMenuAiQY),
        @(3):@(PageTitleMenuTouTiao),
        @(4):@(PageTitleMenuCircle),
    };
       
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"推荐",@"LOOK直播",@"画画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        TFY_TestVC *vc = [TFY_TestVC new];
           vc.page = index;
            return vc;
    })
    .menuAnimalSet([animal[self.index] integerValue]);
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
