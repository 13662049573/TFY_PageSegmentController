//
//  TFY_PageRadiosVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageRadiosVC.h"
#import "TFY_TestVC.h"

@interface TFY_PageRadiosVC ()

@end

@implementation TFY_PageRadiosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .menuAnimalSet(PageTitleMenuCircleBg)
       //圆角
    .menuTitleRadiosSet(5)
//       标题背景颜色
    .menuTitleBackgroundSet([UIColor clearColor])
//       标题选中背景
    .menuSelectTitleBackgroundSet([UIColor blueColor])
    .menuTitleColorSet([UIColor orangeColor])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        return [TFY_TestVC new];
    })
    .menuHeightSet(40)
    .menuWidthSet(PageVCWidth*0.75)
    .menuPositionSet(PageMenuPositionCenter)
    .menuTitleWidthSet(PageVCWidth/4*0.75)
    .titleArrSet(@[
                    @"热门",
                    @"男装",
                    @"女装",
                    @"推荐",
    ]);
    self.param = param;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.upScHerder.mainView.layer.masksToBounds = YES;
        self.upScHerder.mainView.layer.cornerRadius = 20;
        self.upScHerder.mainView.layer.borderWidth = PageK1px;
        self.upScHerder.mainView.layer.borderColor = [UIColor orangeColor].CGColor;
    });
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
