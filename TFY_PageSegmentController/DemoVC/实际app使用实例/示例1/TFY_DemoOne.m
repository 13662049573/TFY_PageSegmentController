//
//  TFY_DemoOne.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_DemoOne.h"
#import "TFY_DemoOneSonVC.h"

@interface TFY_DemoOne ()

@end

@implementation TFY_DemoOne

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[
        @{@"name":@"首页",@"image":@"B"} ,
        @{@"name":@"收藏",@"badge":@(99),@"image":@"C"},
        @{@"name":@"消息",@"badge":@(9),@"image":@"D"},
        @{@"name":@"我的",@"image":@"B"}
    ])
    //自定义红点
    .customRedViewSet(^(UILabel *redLa,NSDictionary *info) {
        NSString *num = [NSString stringWithFormat:@"%@",info[@"badge"]];
        redLa.text = num;
        redLa.backgroundColor = [UIColor clearColor];
        redLa.textColor = [UIColor redColor];
        CGRect rect = redLa.frame;
        rect.size.width = 25;
        rect.origin.x += (num.length*8);
        rect.size.height = 20;
        redLa.layer.masksToBounds = NO;
        redLa.frame = rect;
    })
     .customTabbarYSet(^CGFloat(CGFloat nowY) {
         return nowY;
     })
    //菜单标题颜色
    .menuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
    //菜单标题选中的颜色
    .menuTitleSelectColorSet(PageDarkColor(PageColor(0xffffff), [UIColor orangeColor]))
    //指示器颜色
    .menuIndicatorColorSet(PageDarkColor(PageColor(0xFFFAFA), PageColor(0xFFFAFA)))
    //菜单背景颜色
    .menuBgColorSet([UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5])
    //使用特殊样式1
    .menuSpecifialSet(PageSpecialTypeOne)
    .menuIndicatorWidthSet(self.view.frame.size.width / 9)
    .menuAnimalSet(PageTitleMenuAiQY)
    .menuPositionSet(PageMenuPositionBottom)
    .menuTitleWidthSet(self.view.frame.size.width / 4)
    .controllersSet(@[[[UINavigationController alloc]initWithRootViewController:[TFY_DemoOneSonVC new]],[TFY_DemoOneSonVC new],[TFY_DemoOneSonVC new],[TFY_DemoOneSonVC new]]);
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
