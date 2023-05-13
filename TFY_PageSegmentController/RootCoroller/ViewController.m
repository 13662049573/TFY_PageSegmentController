//
//  viewController.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2021/1/17.
//

#import "viewController.h"

@interface viewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *ta;
@property (nonatomic, strong) NSArray *taData;
@end

@implementation viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *ta = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:ta];
    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 150000
 if (@available(iOS 15.0, *)) {
     ta.sectionHeaderTopPadding = 0;
 }
#endif
    ta.dataSource = self;
    ta.delegate = self;
    self.ta = ta;
    [self.ta mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PageVCNavBarHeight);
        make.left.bottom.right.mas_equalTo(0);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController interactivePopGestureRecognizer].delegate = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.taData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *info = self.taData[section];
    return info[@"title"]?:@"";
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *info = self.taData[section];
    NSArray *data = info[@"data"];
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.taData[indexPath.section];
    NSArray *data = info[@"data"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = data[indexPath.row][@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.taData[indexPath.section];
    NSArray *data = info[@"data"];
    NSDictionary *vcInfo = data[indexPath.row];
    UIViewController *VC = NSClassFromString(vcInfo[@"vc"]).new;
    if ([vcInfo[@"vc"] isEqualToString:@"UseVC"] && [vcInfo[@"index"] isEqual:@(1)]) {
        [self.navigationController interactivePopGestureRecognizer].delegate = self;
    }
    if (!vcInfo[@"showTabbar"]) VC.hidesBottomBarWhenPushed = YES;
    if (vcInfo[@"index"]) [VC setValue:vcInfo[@"index"] forKey:@"index"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (NSArray *)taData{
    if (!_taData) {
        _taData = @[
            @{@"title":@"完全生命周期",@"data":@[@{@"name":@"链式语法展示所有属性",@"vc":@"AllPropertiesVC"}]},
            @{@"title":@"标题",@"data":@[
               @{@"name":@"带红点普通标题",@"vc":@"TitleVC",@"index":@(0)},
               @{@"name":@"图文标题(图上文下)",@"vc":@"TitleVC",@"index":@(1)},
               @{@"name":@"图文标题(图左文右),标题在底部",@"vc":@"TitleVC",@"index":@(2)},
               @{@"name":@"导航栏标题",@"vc":@"TitleVC",@"index":@(3)},
               @{@"name":@"居中标题",@"vc":@"TitleVC",@"index":@(4)},
               @{@"name":@"固定最右边标题",@"vc":@"TitleVC",@"index":@(5)},
               @{@"name":@"固定最右边图片+标题",@"vc":@"TitleVC",@"index":@(6)},
               @{@"name":@"固定宽度标题",@"vc":@"TitleVC",@"index":@(7)},
            ]},
            @{@"title":@"App使用",@"data":@[
               @{@"name":@"爱奇艺",@"vc":@"UseVC",@"index":@(0)},
               @{@"name":@"拼多多",@"vc":@"UseVC",@"index":@(1)},
               @{@"name":@"今日头条",@"vc":@"UseVC",@"index":@(2)},
               @{@"name":@"京东",@"vc":@"UseVC",@"index":@(3)},
               @{@"name":@"简书",@"vc":@"UseVC",@"index":@(4)},
               @{@"name":@"背景框",@"vc":@"UseVC",@"index":@(5)},
               @{@"name":@"新爱奇艺",@"vc":@"UseVC",@"index":@(7)},
               @{@"name":@"新京东",@"vc":@"UseVC",@"index":@(8)},
            ]},
            @{@"title":@"自定义标题",@"data":@[
                @{@"name":@"富文本(更新标题)",@"vc":@"WMZAttVC"},
                @{@"name":@"改变样式",@"vc":@"WMZCustomTitleVC"},
            ]},
            @{@"title":@"悬浮使用(+继承使用示范)",@"data":@[
               @{@"name":@"悬浮效果(导航栏不隐藏+刷新在中间)",@"vc":@"WMZCustomOnePage"},
               @{@"name":@"悬浮效果(添加全局背景色)",@"vc":@"WMZCustomTwoPage"},
               @{@"name":@"悬浮效果(导航栏透明度变化+刷新在顶部)",@"vc":@"WMZCustomThreePage"},
               @{@"name":@"子控制器有子视图固定底部",@"vc":@"WMZFixVC"},
               @{@"name":@"尾视图固定在全局底部",@"vc":@"WMZPageFixAllVC"},
               @{@"name":@"自定义导航栏",@"vc":@"WMZPageCustomNaviVC"},
               @{@"name":@"头部下拉缩放效果",@"vc":@"WMZHeadScalingVC"},
               @{@"name":@"实现tableviewDataSource协议写复杂UI",@"vc":@"WMZUsePageVC"},
               @{@"name":@"悬浮不带滚动视图",@"vc":@"WMZCustomNormalVC"},
            ]},
            @{@"title":@"复杂使用",@"data":@[
                @{@"name":@"淘宝滑动动态改变菜单栏",@"vc":@"WMZTaoBaoDemo",@"showTabbar":@(YES)},
                @{@"name":@"美团商家详情两层联调",@"vc":@"WMZMeiTuanVC",@"showTabbar":@(YES)},
            ]},
            @{@"title":@"嵌套使用",@"data":@[
               @{@"name":@"微博两层嵌套",@"vc":@"WeiBoController"},
               @{@"name":@"三层",@"vc":@"WangZheController"},
               @{@"name":@"双重",@"vc":@"SecondNestVC"},
               @{@"name":@"悬浮顶掉父菜单",@"vc":@"ReplaceParentVC"},
            ]},
            @{@"title":@"其他使用",@"data":@[
               @{@"name":@"菜单视图带背景",@"vc":@"WMZBackGroundMenuVC",@"showTabbar":@(YES)},
               @{@"name":@"标题背景圆角",@"vc":@"WMZPageRadiosVC",@"showTabbar":@(YES)},
               @{@"name":@"作为tabbar",@"vc":@"WMZDemoOne"},
               @{@"name":@"动态富文本",@"vc":@"WMZDemoTwo",@"showTabbar":@(YES)},
            ]},
            @{@"title":@"动态修改",@"data":@[
               @{@"name":@"动态增删菜单标题",@"vc":@"WMZDynamicOperatVC"},
            ]},
            @{@"title":@"菜单栏单独使用",@"data":@[
               @{@"name":@"菜单栏单独使用（标题跟随子表头滑动）",@"vc":@"WMZPageTitleRightVC"},
            ]},
            @{@"title":@"使用UIView作为子视图(如果子控制器类型风格都一致的话可以使用来减少内存)",@"data":@[
               @{@"name":@"使用UIView作为子视图(同时实现协议具备完整生命周期)",@"vc":@"WMZPageUseViewVC"},
            ]},
            @{@"title":@"响应侧滑/全屏手势",@"data":@[
               @{@"name":@"响应侧滑/全屏手势",@"vc":@"GuestureViewController"},
            ]},
            @{@"title":@"菜单栏带自定义视图（筛选等）",@"data":@[
                @{@"name":@"菜单栏带自定义视图（筛选等）",@"vc":@"WMZCustomAddMenuVC"}]},
            @{@"title":@"使用TFY_PageBaseView（无须继承），加在任意地方",@"data":@[
               @{@"name":@"使用TFY_PageBaseView（无须继承）",@"vc":@"UsePageViewController"},
            ]},
        ];
    }
    return _taData;
}


@end
