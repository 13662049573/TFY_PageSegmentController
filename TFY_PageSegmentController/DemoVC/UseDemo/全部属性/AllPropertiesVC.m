

//
//  AllPropertiesVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "AllPropertiesVC.h"
#import "TestVC.h"
@implementation AllPropertiesVC

-(void)viewDidLoad{
    [super viewDidLoad];
       TFY_PageParam *param =
       //初始化
       PageParam()
        //设置控制器数组 必传
       .ViewControllerSet(^UIViewController *(NSInteger index) {
           return [TestVC new];
       })
       //设置标题数组 必传
       .TitleArrSet(@[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV"])
       //设置指示器和动画样式
       .MenuAnimalSet(PageTitleMenuAiQY)
       //是否开启滑动标题颜色渐变
       .MenuAnimalTitleGradientSet(NO)
       //标题font
       .MenuTitleUIFontSet([UIFont systemFontOfSize:15.0f])
       //标题菜单栏的宽度 默认屏幕宽度
       .MenuWidthSet(PageVCWidth)
       //指示器的宽度
       .MenuIndicatorWidthSet(10)
       //指示器的高度
       .MenuIndicatorHeightSet(2)
       //指示器的圆角
       .MenuIndicatorRadioSet(0)
       //指示器图片
//       .MenuIndicatorImageSet(@"")
       //菜单内部按钮的内左右间距
       .MenuCellMarginSet(20)
       //菜单内部按钮的外间距
       .MenuTitleOffsetSet(5)
       //菜单的位置
       .MenuPositionSet(PageMenuPositionLeft)
       //默认选中第几个标题
       .MenuDefaultIndexSet(1)
       //菜单标题图文的位置
       .MenuImagePositionSet(PageBtnPositionRight)
       //菜单标题图文的间距
       .MenuImageMarginSet(10)
       //菜单标题颜色
       .MenuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
       //菜单标题选中的颜色
       .MenuTitleSelectColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
       //指示器颜色
       .MenuIndicatorColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
       //菜单背景颜色
       .MenuBgColorSet(PageDarkColor(PageColor(0xffffff), PageColor(0x666666)))
       //右边固定标题
       .MenuFixRightDataSet(@"≡")
       //右边固定标题宽度
       .MenuFixWidthSet(45)
       //右边固定标题开启阴影
       .MenuFixShadowSet(YES)
       //最右边固定内容
        .MenuFixRightDataSet(@"+")
       //导航栏透明度变化
        .NaviAlphaSet(NO)
        //视图从导航栏开始
        .FromNaviSet(YES)
        //开启悬浮
        .TopSuspensionSet(YES)
          //自定义静态标题
        .CustomMenuTitleSet(^(NSArray *titleArr) {
            [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {}];
          })
        //自定义滑动后标题的变化
        .CustomMenuSelectTitleSet(^(NSArray *titleArr) {
            [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.isSelected) {
                     
                }else{
                      
                }
            }];
          })
          //背景层
//          .InsertHeadAndMenuBgSet(^(UIView *bgView) {
//              //全局背景示例
//              bgView.layer.contents = (id)[UIImage imageNamed:@"11111"].CGImage;
//          })
         //底部线
          .InsertMenuLineSet(^(UIView *bgView) {
              //修改内置线
              CGRect rect = bgView.frame;
              rect.size.height = 5;
              rect.origin.y -= 5;
              bgView.frame = rect;
              bgView.backgroundColor = UIColor.redColor;
          })
       //控制器开始切换
       .EventBeganTransferControllerSet(^(UIViewController *oldVC, UIViewController *newVC, NSInteger oldIndex, NSInteger newIndex) {
           NSLog(@"开始切换 %ld %ld",oldIndex,newIndex);
        })
       //控制器结束切换
       .EventEndTransferControllerSet(^(UIViewController *oldVC, UIViewController *newVC, NSInteger oldIndex, NSInteger newIndex) {
          NSLog(@"结束切换 %ld %ld",oldIndex,newIndex);
        })
       //标题点击
       .EventClickSet(^(id anyID, NSInteger index) {
           NSLog(@"标题点击%ld",index);
       })
       //右边固定标题点击
       .EventFixedClickSet(^(id anyID, NSInteger index) {
           NSLog(@"固定标题点击%ld",index);
       })
       /// 自定义固定视图
       .CustomMenufixTitleSet(^(NSArray<TFY_PageNavBtn *> * _Nullable titleArr) {
        
        })
       .EventChildVCDidSrollSet(^(UIViewController *pageVC, CGPoint oldPoint, CGPoint newPonit, UIScrollView *currentScrollView) {
//           NSLog(@"滚动");
       });
    self.param = param;
}

@end
