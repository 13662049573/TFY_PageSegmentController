//
//  WMZUsePageVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2019/12/27.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZUsePageVC.h"
#import "CollectionViewPopDemo.h"
#import "topSuspensionVC.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface WMZUsePageVC ()<UITableViewDataSource>

@end

@implementation WMZUsePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是标题";
    __weak WMZUsePageVC *weakSelf = self;
    //默认标题透明度0
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:0]}];
    
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"热门",@"分类"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        /// 带滚动视图需实现协议
        if (index == 0) return [CollectionViewPopDemo new];
        return [topSuspensionVC new];
    })
    //悬浮开启
    .topSuspensionSet(YES)
    //等分
    .menuTitleWidthSet(PageVCWidth/2)
    //头视图y坐标从0开始
    .fromNaviSet(NO)
    //导航栏透明度变化
    .naviAlphaSet(YES)
    //顶部可下拉
    .bouncesSet(YES)
    //头部
    .menuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 300);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/9163368-02e26751674a3bc6.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"]];
        image.frame =back.bounds;
        [back addSubview:image];
        return back;
    })
    //导航栏标题透明度变化
     .eventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
          __strong WMZUsePageVC* strongSelf = weakSelf;
         [strongSelf.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:newPonit.y/(500+300-2*PageVCNavBarHeight)]}];
     });
    
    self.param = param;
    
    //实现tableview的协议
    self.downSc.dataSource = self;
    self.downSc.scrollEnabled = YES;
    self.downSc.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.downSc.mj_header endRefreshing];
            [weakSelf.downSc reloadData];
            weakSelf.param.titleArr = @[@"更新1",@"更新2"];
            [weakSelf updateMenuData];
            weakSelf.downSc.scrollEnabled = YES;
        });
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"自定义视图";
    cell.detailTextLabel.text = @"自定义cell";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
@end
