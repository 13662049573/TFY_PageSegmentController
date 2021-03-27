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
    [self.view addSubview:self.customView];
    
    self.topheightsuction =  (2*PageVCStatusBarHeight-(PageIsIphoneX?44:0));
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
    //悬浮开启
    .topSuspensionSet(YES)
    //顶部可下拉
    .bouncesSet(YES)
    //头视图y坐标从导航栏开始
    .fromNaviSet(NO)
    .menuHeadViewSet(^UIView *{ //头部容器
        UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PageVCWidth, PageVCNavBarHeight)];
        nav.backgroundColor = UIColor.orangeColor;
        return nav;
    })
    .eventChildVCDidSrollSet(^(UIViewController* pageVC,CGFloat totalH,CGPoint offsetPonit,id currentTabelView) { //导航栏标题透明度变化
        if (offsetPonit.y > 0) {
            self.customView.hidden = NO;
            [self.view bringSubviewToFront:self.customView];
        } else {
            self.customView.hidden = YES;
        }
    });;
    self.param = param;

    self.upSctableView.dataSource = self;
    [self.upSctableView reloadData];
    
    
}

- (void)onBtnAction:(id)sender{
    [self downScrollViewSetOffset:CGPointZero animated:YES];

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
