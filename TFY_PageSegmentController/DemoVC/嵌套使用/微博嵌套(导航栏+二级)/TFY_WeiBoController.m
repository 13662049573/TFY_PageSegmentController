//
//  TFY_WeiBoController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_WeiBoController.h"
#import "TFY_WeiBoSonController.h"
#import "TFY_TestVC.h"
@interface TFY_WeiBoController ()

@end

@implementation TFY_WeiBoController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger random = arc4random() % 2;
    TFY_PageParam *headParam = PageParam()
    .titleArrSet(@[@"关注",@"推荐"])
    .viewControllerSet(^UIViewController *(NSInteger num) {
        if (num == random) {
            return [TFY_WeiBoSonController new];
        }
        return [TFY_TestVC new];
    })
    .menuPositionSet(PageMenuPositionNavi)
    .menuAnimalSet(PageTitleMenuPDD)
    .menuWidthSet(150);
    self.param = headParam;
    

    self.upSctableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.upSctableView.mj_header endRefreshing];
        });
    }];
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
