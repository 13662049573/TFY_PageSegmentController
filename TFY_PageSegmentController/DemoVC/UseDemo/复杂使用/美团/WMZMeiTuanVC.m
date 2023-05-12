//
//  WMZMeiTuanVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/7/23.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZMeiTuanVC.h"
#import "UIImageView+WebCache.h"
#import "WMZMeiTuanSonVC.h"
@interface WMZMeiTuanVC ()
@end

@implementation WMZMeiTuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
       NSArray *data = @[@"点菜",@"评价",@"商家"];
       TFY_PageParam *param = PageParam()
       .titleArrSet(data)
       .viewControllerSet(^UIViewController *(NSInteger index) {
          return [WMZMeiTuanSonVC new];
        })
       //悬浮开启
       .topSuspensionSet(YES)
       .menuAnimalSet(PageTitleMenuAiQY)
       .menuTitleWidthSet(self.view.frame.size.width / 5)
       //头视图y坐标从0开始
       .fromNaviSet(NO)
       .naviAlphaSet(YES)
       //头部
       .menuHeadViewSet(^UIView *{
           UIView *back = [UIView new];
           back.frame = CGRectMake(0, 0, PageVCWidth, 300);
           UIImageView *image = [UIImageView new];
           [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
           image.frame =back.bounds;
           [back addSubview:image];
           return back;
       });
      self.param = param;

}



@end
