//
//  WMZCustomTwoPage.m
//  TFY_PageBaseController
//
//  Created by wmz on 2019/12/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZCustomTwoPage.h"
#import "topSuspensionVC.h"
#import "UIImageView+WebCache.h"
@interface WMZCustomTwoPage ()

@end

@implementation WMZCustomTwoPage

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor whiteColor];
    
        //标题数组
        NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
        TFY_PageParam *param = PageParam()
        .titleArrSet(data)
        //控制器数组
        .viewControllerSet(^UIViewController *(NSInteger index) {
            /// 带滚动视图需实现协议
          return [topSuspensionVC new];
        })
        //悬浮开启
        .topSuspensionSet(YES)
        //头视图y坐标从0开始
        .fromNaviSet(NO)
        //导航栏透明度变化
        .naviAlphaSet(YES)
        //背景层
        .insertHeadAndMenuBgSet(^(UIView *bgView) {
            //全局背景示例
            bgView.layer.contents = (id)[UIImage imageNamed:@"11111"].CGImage;
        })
        //头部
        .menuHeadViewSet(^UIView *{
            UIView *back = [UIView new];
            back.frame = CGRectMake(0, 0, PageVCWidth, 270+PageVCStatusBarHeight);
            UIImageView *image = [UIImageView new];
            [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
            image.frame = CGRectMake(100, 100, 100, 100);
            [back addSubview:image];
            return back;
        });
        
        self.param = param;
    
}
@end
