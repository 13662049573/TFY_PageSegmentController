//
//  TFY_CustomOnePage.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_CustomOnePage.h"
#import "TFY_TopSuspensionVC.h"
#import "TFY_UseVC.h"

@interface TFY_CustomOnePage ()

@end

@implementation TFY_CustomOnePage

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    TFY_PageParam *param =
    PageParam()
    //控制器数组
    .viewControllerSet(^UIViewController *(NSInteger index) {
        TFY_TopSuspensionVC *vc = [TFY_TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    .titleArrSet(data)
    .menuAnimalSet(PageTitleMenuAiQY)
    .menuDefaultIndexSet(3)
    //悬浮开启
    .topSuspensionSet(YES)
    //头视图y坐标从导航栏开始
    .fromNaviSet(YES)
    //头部
    .menuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 270);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    ;

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
