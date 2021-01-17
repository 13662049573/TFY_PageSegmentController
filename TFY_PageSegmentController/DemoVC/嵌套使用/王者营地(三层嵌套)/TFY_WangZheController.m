//
//  TFY_WangZheController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_WangZheController.h"
#import "TFY_TestVC.h"
#import "TFY_WZSecondController.h"
@interface TFY_WangZheController ()

@end

@implementation TFY_WangZheController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"关注",@"推荐"])
    .menuFixShadowSet(NO)
    .menuFixRightDataSet(@[@{@"name":@"固定",@"selectName":@"固定1",@"titleColor":[UIColor redColor],@"titleSelectColor":[UIColor blueColor]},@{@"image":@"C"}])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 1) {
            return [TFY_WZSecondController new];
        }
        return [TFY_TestVC new];
     })
    .menuIndicatorColorSet([UIColor orangeColor])
    .menuTitleSelectColorSet([UIColor orangeColor])
    .menuAnimalSet(PageTitleMenuPDD);
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
