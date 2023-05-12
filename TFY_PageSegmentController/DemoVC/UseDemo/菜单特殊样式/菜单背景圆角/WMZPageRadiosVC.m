//
//  WMZPageRadiosVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/12/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageRadiosVC.h"
#import "TestVC.h"
@interface WMZPageRadiosVC ()

@end

@implementation WMZPageRadiosVC

- (void)viewDidLoad {
    [super viewDidLoad];

    TFY_PageParam *param = PageParam()
    .menuAnimalSet(PageTitleMenuCircleBg)
       //圆角
//    .menuTitleRadiosSet(5)
      // 标题背景颜色
//    .menuTitleBackgroundSet([UIColor clearColor])
      // 标题选中背景
    .menuSelectTitleBackgroundSet([UIColor blueColor])
    .menuTitleColorSet([UIColor orangeColor])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        return [TestVC new];
    })
    .menuHeightSet(40)
    .menuWidthSet(PageVCWidth*0.75 + 8)
    .menuPositionSet(PageMenuPositionCenter)
    .menuTitleWidthSet(PageVCWidth/4*0.75)
    .titleArrSet(@[
        @{TFY_PageKeyName:@"男装",TFY_PageKeyTitleMarginY:@(4),TFY_PageKeyTitleMarginX:@(2)},
        @{TFY_PageKeyName:@"女装",TFY_PageKeyTitleMarginY:@(4)},
        @{TFY_PageKeyName:@"热门",TFY_PageKeyTitleMarginY:@(4)},
        @{TFY_PageKeyName:@"精选",TFY_PageKeyTitleMarginY:@(4)},
    ]);
    self.param = param;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *contailView = self.upSc.mainView.containView;

        /// 不贴着标题
        CGRect rect = contailView.frame;
        rect.origin.x -= 2;
        rect.origin.y -= 2;
        rect.size.width -= 2;
        rect.size.height += 4;
        contailView.frame = rect;

        contailView.layer.backgroundColor = UIColor.whiteColor.CGColor;
        contailView.layer.cornerRadius = 20;
        contailView.layer.borderWidth = PageK1px;
        contailView.layer.borderColor = [UIColor orangeColor].CGColor;
    });
}


@end
