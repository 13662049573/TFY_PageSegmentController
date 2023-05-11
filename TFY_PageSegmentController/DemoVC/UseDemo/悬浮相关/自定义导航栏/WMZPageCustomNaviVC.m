//
//  WMZPageCustomNaviVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/9/7.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZPageCustomNaviVC.h"
#import "TopSuspensionVC.h"
#import "UIImageView+WebCache.h"
@interface WMZPageCustomNaviVC ()<UITableViewDataSource>
@property(nonatomic,strong)UIButton *customView;
@end

@implementation WMZPageCustomNaviVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     //标题数组
    NSArray *data = @[@"热门",@{TFY_PageKeyName:@"男装",TFY_PageKeyOnlyClickWithAnimal:@(YES)},
                      @"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    TFY_PageParam *param =
    PageParam()
    //控制器数组
    .ViewControllerSet(^UIViewController *(NSInteger index) {
        /// 带滚动视图需实现协议
        TopSuspensionVC *vc = [TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    .TitleArrSet(data)
    .MenuAnimalSet(PageTitleMenuPDD)
    .MenuDefaultIndexSet(3)
    //调整顶部悬浮的位置 可调到悬浮至状态栏的位置
    .CustomNaviBarYSet(^CGFloat(CGFloat nowY) {
       return PageVCNavBarHeight;
     })
    //调整距离底部的位置
     .CustomTabbarYSet(^CGFloat(CGFloat nowY) {
         return nowY;
     })
    //悬浮开启
    .TopSuspensionSet(YES)
    .BouncesSet(YES)
    //No为从自定义导航栏顶部开始 yes为从自定义导航栏底部开始
    .FromNaviSet(YES);
    self.param = param;
    
    //如果没有出现视图 就延时0.1秒加载
    [self.view addSubview:self.customView];
    
    self.downSc.dataSource = self;
    [self.downSc reloadData];
    
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, PageVCWidth, 40);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIButton *)customView{
    if (!_customView) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.backgroundColor = PageColor(0x4895ef);
        [view setTitle:@"我是自定义导航栏" forState:UIControlStateNormal];
        [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        view.frame = CGRectMake(0, 0, PageVCWidth, PageVCNavBarHeight);
        _customView = view;
              
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setTitle:@"返回>" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.customView addSubview:back];
        [back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        back.frame = CGRectMake(20, PageVCStatusBarHeight, 60, 30);
    }
    return _customView;
}

@end
