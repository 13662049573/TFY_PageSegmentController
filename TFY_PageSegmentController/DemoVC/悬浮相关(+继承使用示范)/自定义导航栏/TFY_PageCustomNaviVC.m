//
//  TFY_PageCustomNaviVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageCustomNaviVC.h"
#import "TFY_TopSuspensionVC.h"

@interface TFY_PageCustomNaviVC ()<UITableViewDataSource>
@property(nonatomic,strong)UIButton *customView;
@end

@implementation TFY_PageCustomNaviVC

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
    NSArray *data = @[@"热门",@{@"name":@"男装",@"onlyClick":@(YES)},
                      @"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
    TFY_PageParam *param =
    PageParam()
    //控制器数组
    .viewControllerSet(^UIViewController *(NSInteger index) {
        TFY_TopSuspensionVC *vc = [TFY_TopSuspensionVC new];
        vc.page = index;
        return vc;
    })
    .titleArrSet(data)
    .menuAnimalSet(PageTitleMenuPDD)
    .menuDefaultIndexSet(3)
    //调整顶部悬浮的位置 可调到悬浮至状态栏的位置
    .customNaviBarYSet(^CGFloat(CGFloat nowY) {
       return PageVCNavBarHeight;
     })
    //调整距离底部的位置
     .customTabbarYSet(^CGFloat(CGFloat nowY) {
         return nowY;
     })
    // 正常的话是会悬浮到状态栏那里，改变这里减掉一部分就会自动悬浮到自定义导航栏那里)
    .customDataViewHeightSet(^CGFloat(CGFloat nowY) {
        return nowY + PageVCStatusBarHeight;
    })
    //悬浮开启
    .topSuspensionSet(YES)
    .bouncesSet(YES)
    //No为从自定义导航栏顶部开始 yes为从自定义导航栏底部开始
    .fromNaviSet(YES);
    self.param = param;
    
    //对于视图的操作需要延时0.1秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view addSubview:self.customView];
    });
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    
    
}

- (void)onBtnAction:(id)sender{
    [self downScrollViewSetOffset:CGPointZero animated:YES];

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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(PageVCWidth-100, 40, 60, 30);
        btn.tag = 111;
        [btn setTitleColor:PageColor(0xF4606C) forState:UIControlStateNormal];
        [btn setTitle:@"滚动到顶部" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        [self.customView addSubview:btn];
    }
    return _customView;
}


@end
