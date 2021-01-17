//
//  ViewController.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2021/1/17.
//

#import "ViewController.h"
#import "TFY_DemoOne.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *taData;
@property(nonatomic,strong)NSArray *titleData;
@property(nonatomic,strong)NSArray *VCData;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController interactivePopGestureRecognizer].delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *ta = [[UITableView alloc]initWithFrame:CGRectMake(0, PageVCNavBarHeight, self.view.frame.size.width,PageVCHeight -PageVCNavBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
       ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    ta.dataSource = self;
    ta.delegate = self;
    self.tableView = ta;
}

//MARK:-侧滑
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([[self.navigationController interactivePopGestureRecognizer] isEqual:gestureRecognizer]) {
            return YES;
        }
        return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.taData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.titleData[section];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taData[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.taData[indexPath.section][indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section  == 4) {
        NSArray *arr = @[@"TFY_CustomOnePage",@"TFY_CustomTwoPage",@"TFY_CustomThreePage",@"TFY_ZFixVC",@"TFY_PageCustomNaviVC"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section  == 5) {
        NSArray *arr = @[@"TFY_UsePageVC"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section  == 6) {
        NSArray *arr = @[@"TFY_DemoOne",];
        UIViewController *vc = [NSClassFromString(arr[indexPath.row]) new];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.section  == 7) {
        NSArray *arr = @[@"TFY_DemoTwo"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section  == 8) {
        NSArray *arr = @[@"TFY_TaoBaoDemo",@"TFY_MeiTuanVC"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section  == 9) {
        NSArray *arr = @[@"TFY_WeiBoController",@"TFY_WangZheController"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section  == 10) {
        NSArray *arr = @[@"TFY_BackGroundMenuVC",@"TFY_PageRadiosVC"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section  == 11) {
        NSArray *arr = @[@"TFY_DynamicOperatVC"];
        UIViewController *VC = [NSClassFromString(arr[indexPath.row]) new];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        TFY_PageBaseController *VC = (TFY_PageBaseController*)[NSClassFromString(self.VCData[indexPath.section]) new];
        [VC setValue:@(indexPath.row) forKey:@"index"];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (NSArray *)taData{
    if (!_taData) {
        _taData = @[
        @[@"链式语法展示所有属性"],
        @[@"普通标题",@"换行标题",@"带红点普通标题",@"富文本标题",@"图文标题(图上文下)",@"图文标题(图左文右),标题在底部",
          @"导航栏标题",@"居中标题",@"固定最右边标题",@"固定最右边图片+标题",@"固定宽度标题",@"自定义标题内容"],
        @[@"无样式",@"下划线不跟随移动",@"下划线跟随移动",@"字体变大",@"背景框"],
        @[@"爱奇艺",@"拼多多",@"今日头条",@"京东",@"简书",@"适配暗黑模式"],
        @[@"悬浮效果(导航栏不隐藏+刷新在中间)",@"悬浮效果(添加全局背景色)",@"悬浮效果(导航栏透明度变化+刷新在顶部)",@"子控制器有子视图固定底部/尾视图固定在全局底部",@"自定义导航栏"],
        @[@"实现tableviewDataSource协议写复杂UI"],
        @[@"实际使用demoOne(作为tabbar)"],
        @[@"实际使用demoTwo(动态富文本)"],
        @[@"淘宝滑动动态改变菜单栏",@"美团商家详情两层联调"],
        @[@"微博两层嵌套",@"三层"],
        @[@"菜单视图带背景",@"标题背景圆角"],
        @[@"动态增删菜单标题"]
        ];
    }
    return _taData;
}

- (NSArray *)titleData{
    if (!_titleData) {
        _titleData = @[@"完整手动管理控制器生命周期",@"标题样式",@"指示器样式",@"实际使用",@"悬浮使用(+继承使用示范)",@"综合使用",@"PageSpecialType",@"PageSpecialType",@"复杂使用",@"swift",@"嵌套使用",@"其他使用",@"动态修改"];
    }
    return _titleData;
}

- (NSArray *)VCData{
    if (!_VCData) {
        _VCData = @[@"TFY_AllPropertiesVC",@"TFY_TitleVC",@"TFY_IndicatorVC",@"TFY_UseVC",];
    }
    return _VCData;
}


@end
