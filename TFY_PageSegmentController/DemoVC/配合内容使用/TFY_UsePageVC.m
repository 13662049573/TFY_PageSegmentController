//
//  TFY_UsePageVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_UsePageVC.h"
#import "TFY_CollectionViewPop.h"
#import "TFY_TopSuspensionVC.h"

@interface TFY_UsePageVC ()<UITableViewDataSource>
@property(nonatomic , strong)UIScrollView *scrollView;
@end

@implementation TFY_UsePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是标题";
    __weak TFY_UsePageVC *weakSelf = self;
    //默认标题透明度0
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:0]}];
    
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"热门",@"分类"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        if (index == 0) return [TFY_CollectionViewPop new];
        return [TFY_TopSuspensionVC new];
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
        back.frame = CGRectMake(0, 0, PageVCWidth, 250+PageVCStatusBarHeight);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
        image.frame =back.bounds;
        [back addSubview:image];
        return back;
    })
    //导航栏标题透明度变化
     .eventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
          __strong TFY_UsePageVC* strongSelf = weakSelf;
         if (newPonit.y/(-160) >= 1) {
             NSLog(@"显示下一个界面");
         }
        
         NSLog(@"---:%.2f------:%.2f",newPonit.y,oldPoint.y);

         [strongSelf.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:10/255.0 green:10/255.0 blue:20/255.0 alpha:newPonit.y/(500+250-2*PageVCNavBarHeight)]}];
     });
    
    //实现tableview的协议
    self.tableView.dataSource = self;
    self.param = param;
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
