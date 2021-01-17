//
//  TFY_CustomTwoPage.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_CustomTwoPage.h"
#import "TFY_TopSuspensionVC.h"

@interface TFY_CustomTwoPage ()

@end

@implementation TFY_CustomTwoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    TFY_PageParam *param = PageParam()
    .titleArrSet(data)
    //控制器数组
    .viewControllerSet(^UIViewController *(NSInteger index) {
      return [TFY_TopSuspensionVC new];
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
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579081&di=29b77f2a5119755d3c1c3c7ce2595527&imgtype=0&src=http%3A%2F%2Fi2.bangqu.com%2Fr2%2Fnews%2F20180810%2F304a6c35725753744e48.jpg"]];
        image.frame = CGRectMake(100, 100, 100, 100);
        [back addSubview:image];
        return back;
    });
    
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
