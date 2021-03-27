//
//  TFY_TopSuspensionVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_TopSuspensionVC.h"
#import <Masonry/Masonry.h>
@interface TFY_TopSuspensionVC ()<UITableViewDelegate,UITableViewDataSource,TFY_PageProtocol>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *bannerData;
@property(nonatomic,strong)TFY_BannerView *headView;
@property(nonatomic,strong)TFY_BannerParam *param;
@end

@implementation TFY_TopSuspensionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *ta = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    
    [ta mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-PageVCTabBarHeight);
    }];
    
    
//    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    ta.dataSource = self;
    ta.delegate = self;
    ta.tag = self.page;
    
    self.bannerData = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232578984&di=7170b5a1e3350fc3060db6929bc49a10&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn10109%2F217%2Fw641h376%2F20191211%2Fa46d-iknhexi8336167.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579069&di=d0ff7d27c7d65928aaa2a472094552a9&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farticle%2F5b13843d414928b145f37cf958c1dfdac6759cd3.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579067&di=c3ecf1fc284f48dd91464085a95db96d&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn12%2F328%2Fw640h488%2F20180612%2F0052-hcufqih6006139.jpg",
                    @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579067&di=c2441db655c6ffddb3fe0a04aba4d37b&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fca1349540923dd54ac050f37da09b3de9c82487f.jpg"];
    
    self.tableView = ta;
    
    self.param = paramModel()
    .tfy_FrameSet(CGRectMake(0, 0, BannerWitdh, BannerHeight/5))
    .tfy_DataSet(self.bannerData)
    .tfy_RepeatSet(YES);
    
    self.headView = [[TFY_BannerView alloc] initConfigureWithModel:self.param];
    
    __weak TFY_TopSuspensionVC *weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    
    // 上拉刷新
  self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          // 结束刷新
          [weakSelf.tableView.mj_footer endRefreshing];
      });
  }];
  // 设置自动切换透明度(在导航栏下面自动隐藏)
  self.tableView.mj_header.automaticallyChangeAlpha = YES;

}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    UIImage * icon = cell.imageView.image;
    CGSize itemSize = CGSizeMake(36, 36);//固定图片大小为36*36
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();//*2
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576232579066&di=f0c28d04cd4bfafcec7a23275a933836&imgtype=0&src=http%3A%2F%2Fk.zol-img.com.cn%2Fsjbbs%2F5870%2Fa5869130_s.jpg"]];
    UIGraphicsEndImageContext();//*3
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-路飞",self.page];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld-红发",self.page];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = @"TFY_PageBaseController";
    UIViewController *vc = [NSClassFromString(str) new];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

//实现协议 悬浮 必须实现
- (UITableView *)getMyTableView{
    return self.tableView;
}

@end
