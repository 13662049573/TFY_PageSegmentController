//
//  TFY_ZFixVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_ZFixVC.h"
#import "TFY_CollectionViewPop.h"
#import "TFY_FixSonVC.h"

@interface TFY_ZFixVC ()

@end

@implementation TFY_ZFixVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"热门",@"分类",@"推荐"])
     //控制器数组
     .viewControllerSet(^UIViewController *(NSInteger index) {
         if (index == 1) return [TFY_FixSonVC new] ;
         return [TFY_CollectionViewPop new];
     })
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
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
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
    [self downScrollViewSetOffset:CGPointZero animated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setDowmScContenOffset" object:nil];
}

@end
