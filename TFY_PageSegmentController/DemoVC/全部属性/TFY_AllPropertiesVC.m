//
//  TFY_AllPropertiesVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_AllPropertiesVC.h"
#import "TFY_TestVC.h"

@interface TFY_AllPropertiesVC ()

@end

@implementation TFY_AllPropertiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TFY_PageParam *param =
    //初始化
    PageParam()
     //设置控制器数组 必传
    .viewControllerSet(^UIViewController *(NSInteger index) {
        return [TFY_TestVC new];
    })
    //设置标题数组 必传
    .titleArrSet(@[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV"])
    //设置指示器和动画样式
    .menuAnimalSet(PageTitleMenuAiQY)
    //是否开启滑动标题颜色渐变
    .menuAnimalTitleGradientSet(NO)
    //标题font
    .menuTitleUIFontSet([UIFont systemFontOfSize:15.0f])
    //标题菜单栏的宽度 默认屏幕宽度
    .menuWidthSet(PageVCWidth)
    //指示器的宽度
    .menuIndicatorWidthSet(10)
    //指示器的高度
    .menuIndicatorHeightSet(2)
    //指示器的圆角
    .menuIndicatorRadioSet(0)
    //指示器图片
//       .wMenuIndicatorImageSet(@"")
    //菜单内部按钮的内左右间距
    .menuCellMarginSet(20)
    //菜单内部按钮的外间距
    .menuTitleOffsetSet(5)
    //菜单的位置
    .menuPositionSet(PageMenuPositionLeft)
    //默认选中第几个标题
    .menuDefaultIndexSet(1)
    //菜单标题图文的位置
    .menuImagePositionSet(PageBtnPositionRight)
    //菜单标题图文的间距
    .menuImageMarginSet(10)
    //菜单标题颜色
    .menuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
    //菜单标题选中的颜色
    .menuTitleSelectColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
    //指示器颜色
    .menuIndicatorColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
    //菜单背景颜色
    .menuBgColorSet(PageDarkColor(PageColor(0xffffff), PageColor(0x666666)))
    //右边固定标题
    .menuFixRightDataSet(@"≡")
    //右边固定标题宽度
    .menuFixWidthSet(45)
    //右边固定标题开启阴影
    .menuFixShadowSet(YES)
    //最右边固定内容
     .menuFixRightDataSet(@"+")
    //导航栏透明度变化
     .naviAlphaSet(NO)
     //视图从导航栏开始
     .fromNaviSet(YES)
     //开启悬浮
     .topSuspensionSet(YES)
       //自定义静态标题
     .customMenuTitleSet(^(NSArray *titleArr) {
         [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {}];
       })
     //自定义滑动后标题的变化
     .customMenuSelectTitleSet(^(NSArray *titleArr) {
         [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             if (obj.isSelected) {
                  
             }else{
                   
             }
         }];
       })
       //背景层
//          .wInsertHeadAndMenuBgSet(^(UIView *bgView) {
//              //全局背景示例
//              bgView.layer.contents = (id)[UIImage imageNamed:@"11111"].CGImage;
//          })
      //底部线
//          .wInsertMenuLineSet(^(UIView *bgView) {
//              //修改内置线
//              CGRect rect = bgView.frame;
//              rect.size.height = PageK1px;
//              bgView.frame = rect;
//              bgView.backgroundColor = PageColor(0x999999);
//          })
    //控制器开始切换
    .eventBeganTransferControllerSet(^(UIViewController *oldVC, UIViewController *newVC, NSInteger oldIndex, NSInteger newIndex) {
        NSLog(@"开始切换 %ld %ld",oldIndex,newIndex);
     })
    //控制器结束切换
    .eventEndTransferControllerSet(^(UIViewController *oldVC, UIViewController *newVC, NSInteger oldIndex, NSInteger newIndex) {
       NSLog(@"结束切换 %ld %ld",oldIndex,newIndex);
     })
    //标题点击
    .eventClickSet(^(id anyID, NSInteger index) {
        NSLog(@"标题点击%ld",index);
    })
    //右边固定标题点击
    .eventFixedClickSet(^(id anyID, NSInteger index) {
        NSLog(@"固定标题点击%ld",index);
    })
    .eventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
//           NSLog(@"滚动");
    });
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
