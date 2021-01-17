//
//  TFY_CustomThreePage.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_CustomThreePage.h"
#import "TFY_TopSuspensionVC.h"
#import "TFY_CollectionViewPop.h"
@interface TFY_CustomThreePage ()

@end

@implementation TFY_CustomThreePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak TFY_CustomThreePage* weakSelf = self;
    self.navigationItem.title = @"导航栏标题";
    //默认标题透明度0
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:0]}];
     
    //标题数组
    NSArray *data = @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    TFY_PageParam *param = PageParam()
    .titleArrSet(data)
    //控制器数组
    .viewControllerSet(^UIViewController *(NSInteger index) {
        TFY_TopSuspensionVC *vc = [TFY_TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    //悬浮开启
    .topSuspensionSet(YES)
    //顶部可下拉
    .bouncesSet(YES)
    //头视图y坐标从导航栏开始
    .fromNaviSet(NO)
    //导航栏透明度变化
    .naviAlphaSet(YES)
    //头部
    .menuHeadViewSet(^UIView *{
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
        image.frame = CGRectMake(0, 0, PageVCWidth, 300);
        return image;
    })
    //导航栏标题透明度变化
    .eventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
        __strong TFY_CustomThreePage* strongSelf = weakSelf;
        [strongSelf.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:newPonit.y/(300-PageVCNavBarHeight)]}];
    });
    self.param = param;
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong TFY_CustomThreePage *strongSelf = weakSelf;
        //模拟更新数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSArray *data1 = @[@"热门",@"男装",@"美妆"];
                strongSelf.param.titleArrSet(data1)
                   //控制器数组
                .viewControllerSet(^UIViewController *(NSInteger index) {
                    TFY_CollectionViewPop *vc = [TFY_CollectionViewPop new];
                    return vc;
                });
                //模拟更新菜单数据
                [strongSelf updateMenuData];
                [strongSelf.tableView.mj_header endRefreshing];
            });
        }];
}



@end
