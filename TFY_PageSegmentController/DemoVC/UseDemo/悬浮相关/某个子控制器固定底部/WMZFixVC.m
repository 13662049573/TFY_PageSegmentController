//
//  WMZFixVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/1/6.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFixVC.h"
#import "CollectionViewPopDemo.h"
#import "FixSonVC.h"
#import "UIImageView+WebCache.h"
@interface WMZFixVC ()

@end

@implementation WMZFixVC

- (void)viewDidLoad {
    [super viewDidLoad];
      TFY_PageParam *param = PageParam()
      .titleArrSet(@[@"热门",@"分类",@"推荐"])
       //控制器数组
       .viewControllerSet(^UIViewController *(NSInteger index) {
           if (index == 1) return [FixSonVC new] ;
           /// 带滚动视图需实现协议
           return [CollectionViewPopDemo new];
       })

      //如果要固定在所有子控制器底部  需要放在第一个控制器里 例如此例子  建议看固定全局底部视图例子 wFixFirst已不推荐
//       .viewControllerSet(^UIViewController *(NSInteger index) {
//          if (index == 0) return [FixSonVC new] ;
//          return [CollectionViewPopDemo new];
//        })
//     .fixFirstSet(YES)
     
      //悬浮开启
      .topSuspensionSet(YES)
      //等分
      .menuTitleWidthSet(PageVCWidth/3)
      //头视图y坐标从0开始
      .fromNaviSet(NO)
      //导航栏透明度变化
      .naviAlphaSet(YES)
      //头部
      .menuHeadViewSet(^UIView *{
          UIView *back = [UIView new];
          back.frame = CGRectMake(0, 0, PageVCWidth, 370+PageVCStatusBarHeight);
          UIImageView *image = [UIImageView new];
          [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
          image.frame =back.bounds;
          [back addSubview:image];
          return back;
      });
      self.param = param;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:PageColor(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"滚动到顶部" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)onBtnAction:(id)sender{
    [self downScrollViewSetOffset:CGPointMake(0, CGFLOAT_MIN) animated:YES];
}
@end
