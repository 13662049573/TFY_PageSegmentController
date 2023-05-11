//
//  WangZheController.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/10/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WangZheController.h"
#import "TestVC.h"
#import "WZSecondController.h"
#import "UIImageView+WebCache.h"
@interface WangZheController ()

@end

@implementation WangZheController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .TitleArrSet(@[@"关注",@"推荐"])
    .MenuWidthSet(PageVCWidth - 40)
    .MenuPositionSet(PageMenuPositionCenter)
    .MenuFixShadowSet(NO)
    .MenuFixRightDataSet(@[@{TFY_PageKeyName:@"固定",TFY_PageKeySelectName:@"固定1",TFY_PageKeyTitleColor:[UIColor redColor],TFY_PageKeyTitleSelectColor:[UIColor blueColor]},@{TFY_PageKeyImage:@"C"}])
    .ViewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 1) {
            return [WZSecondController new];
        }
        return [TestVC new];
     })
    ///如果第一层嵌套开启悬浮  二三层也要开启
    ///举一反三 只有第二层开启的话 第三层也要开启
    ///如果是最后一层开启则上级不需要开启
    .TopSuspensionSet(YES)
    .MenuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 200);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    .MenuIndicatorColorSet([UIColor orangeColor])
    .MenuTitleSelectColorSet([UIColor orangeColor])
    .MenuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

@end
