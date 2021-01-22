//
//  TFY_PageParam.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import <Foundation/Foundation.h>
#import "TFY_ConfigProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageParam : NSObject

/* =========================================required==============================================*/
//标题数组 必传
/*可传带字典的数组
 badge            红点提示    @(YES) 或者 带数字 @(99)
 name             标题        @""
 selectName       选中后的标题  @""
 indicatorColor   指示器颜色   [UIColor redColor]
 titleSelectColor 选中字体颜色 [UIColor redColor]
 titleColor       未选中字体颜色 [UIColor redColor]
 backgroundColor  选中背景颜色 [UIColor redColor] (如果是数组则是背景色渐变色) @[[UIColor redColor],[UIColor orangeColor]]
 onlyClick        仅点击页面不加载 @(YES)
 firstColor       富文本 第一行标题颜色  [UIColor redColor]
 wrapColor        富文本 第二行标题颜色  [UIColor redColor]
 image            图片    @""
 selectImage      选中图片 @""
 width            自定义标题宽度(优先级最高)   @(100)
 height           自定义标题高度(优先级最高)   @(100)
 marginX          自定义标题margin          @(100)
 y                自定义标题y坐标(优先级最高)  @(100)
 canTopSuspension 当前子控制器不悬浮固定在顶部  @(NO)  NO表示不悬浮
 */
TFY_PagePropertyStatement(strong, TFY_PageParam, NSArray*,              titleArr)


//VC数据 必传(二选一) 1.1.6新增
TFY_PagePropertyStatement(copy,   TFY_PageParam,  PageViewControllerIndex,              viewController)
//VC数组 必传(二选一) (如果要做标题内容动态增删操作的必须使用此属性 )
TFY_PagePropertyStatement(strong, TFY_PageParam, NSArray*,              controllers)

/* =========================================required==============================================*/

/* =========================================customFrame===============================================*/

//自定义整体距离顶部的位置(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomFrameY,        customNaviBarY)
//自定义整体距离底部的位置(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomFrameY,        customTabbarY)
//自定义底部滚动视图的高度(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomFrameY,        customDataViewHeight)

/* =========================================customFrame===============================================*/

/* =========================================special==============================================*/
//特殊属性 菜单滑动到顶部悬浮 default NO 需要实现协议
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  topSuspension)
//导航栏透明度变化 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  naviAlpha)
//滑动切换 default YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  scrollCanTransfer)
//头部视图frame从导航栏下方开始 default YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  fromNavi)
//菜单最右边固定内容是否开启左边阴影 defaulf YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  menuFixShadow)
//开启渐变色 default yes
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  menuAnimalTitleGradient)
//顶部可下拉 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  bounces)
//导航栏整个透明 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  naviAlphaAll)
//点击滑动带动画 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  tapScrollAnimal)
//特殊属性 固定在所有子控制器的底部 需要在第一个子控制器实现固定底部协议
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  fixFirst)
//延迟加载 default YES 注意如果此属性为NO 则无法准确获取控制器的显示frame 需要自己调用customNaviBarY/customTabbarY/customDataViewHeight 调试
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  lazyLoading)


/* =========================================special==============================================*/


/* =========================================Menu==================================================*/


//菜单栏高度 default 60
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,                  menuHeight)
//给菜单栏和headView加个背景层 default -
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadAndMenuBgView,                  insertHeadAndMenuBg)
//给菜单栏加个下划线 default -
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadAndMenuBgView,                  insertMenuLine)
//自定义菜单栏 default -
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadAndMenuBgView,                  customMenuView)
//自定义菜单右上角红点
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomRedText,                  customRedView)
//自定义菜单栏上的标题
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomMenuTitle,                  customMenuTitle)
//自定义选中后菜单栏上的标题
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomMenuSelectTitle,customMenuSelectTitle)
//自定义固定标题
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomMenuTitle,                  customMenufixTitle)
//默认选中 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, NSInteger,             menuDefaultIndex)
//菜单最右边固定内容 default nil (可传字符串/字典/数组)
TFY_PagePropertyStatement(strong, TFY_PageParam, id,                    menuFixRightData)
//菜单最右边固定内容宽度 defaulf 45
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuFixWidth)
//菜单最左侧独立按钮固定内容宽度 defaulf 45
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuFixRightWidth)
//菜单标题动画效果 default  PageTitleMenuMove
TFY_PagePropertyStatement(assign, TFY_PageParam, PageTitleMenu,         menuAnimal)
//头部视图 default nil
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadViewBlock,     menuHeadView)
//菜单宽度 default 屏幕宽度
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuWidth)
//菜单背景颜色 default ffffff
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuBgColor)
//整体视图背景颜色 default ffffff
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              bgColor)
//菜单按钮的左右间距 default 20
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuCellMargin)
//菜单按钮的上下间距 default 20 (可根据此属性改变菜单栏的高度)
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuCellPadding)
//菜单按钮距离顶部的y值 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuCellMarginY)
//菜单按钮距离底部部的y值 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuBottomMarginY)
//菜单的位置 default PageMenuPositionLeft
TFY_PagePropertyStatement(assign, TFY_PageParam, PageMenuPosition,      menuPosition)
//菜单标题左右间距 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuTitleOffset)
//菜单标题字体 default [UIFont 15]
TFY_PagePropertyStatement(strong, TFY_PageParam, UIFont*,               menuTitleUIFont)
//左侧按钮文字大小 默认 17
TFY_PagePropertyStatement(strong, TFY_PageParam, UIFont*,               menuTitleRightUIFont)
//菜单标题字体 default [UIFont MenuTitleFont+1.5]
TFY_PagePropertyStatement(strong, TFY_PageParam, UIFont*,               menuTitleSelectUIFont)
//菜单标题固定宽度 default 文本内容宽度+MenuCellMargin
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuTitleWidth)
//菜单标题字体粗体 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuTitleWeight)
//菜单字体颜色 default 333333
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuTitleColor)
//左侧独立菜单字体颜色 default 333333
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuTitleRightColor)
//菜单字体选中颜色 default E5193E
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuTitleSelectColor)
//左侧菜单字体选中颜色 default E5193E
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuTitleSelectRightColor)
//菜单图文位置 default PageBtnPositionTop
TFY_PagePropertyStatement(assign, TFY_PageParam, PageBtnPosition,       menuImagePosition)
//左侧菜单图文位置 default PageBtnPositionTop
TFY_PagePropertyStatement(assign, TFY_PageParam, PageBtnPosition,       menuImageRightPosition)
//菜单图文位置间距 default 5
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuImageMargin)
//左侧菜单图文位置间距 default 5
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuImageRightMargin)
//指示器颜色 default E5193E
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuIndicatorColor)
//指示器宽度 default 标题宽度+10
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuIndicatorWidth)
//指示器图片 default nil
TFY_PagePropertyStatement(strong, TFY_PageParam, NSString*,             menuIndicatorImage)
//指示器高度 default k1px
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuIndicatorHeight)
//指示器圆角 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuIndicatorRadio)
//指示器距离按钮的y值(AQY) default 菜单视图的高度-指示器高度-4/MenuCellPadding
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuIndicatorY)
//背景圆圈的圆角 默认高度的一半
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuCircilRadio)


//菜单标题背景颜色 default clear
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuTitleBackground)
//菜单标题选中背颜色 default clear
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              menuSelectTitleBackground)
//菜单标题圆角 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               menuTitleRadios)


/* =========================================Menu===============================================*/

/* =========================================Events==================================================*/
TFY_PageParam * PageParam(void);
//右边固定标题点击
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageClickBlock,        eventFixedClick)

//标题点击
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageClickBlock,        eventClick)
//控制器开始切换
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageVCChangeBlock,     eventBeganTransferController)
//控制器结束切换
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageVCChangeBlock,     eventEndTransferController)
//子控制器滚动(做滚动时候自己的操作)  =>开启悬浮有效
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageChildVCScroll,     eventChildVCDidSroll)
/* =========================================Events==================================================*/


/* =========================================special==================================================*/
//特殊样式实际demo 实际效果看demo
TFY_PagePropertyStatement(assign, TFY_PageParam, PageSpecialType,       menuSpecifial)
/* =========================================special==================================================*/


/* =========================================changeMenu===============================================*/

//滑动到顶部改变菜单栏的高度 可传入正负值 改变的高度为当前的titleHeight+传入TopChangeHeight default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               topChangeHeight)

//改变高度的block 可在此做标题的操作
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageMenuChangeHeight,  eventMenuChangeHeight)

//恢复原来高度的block 可在此做标题的操作
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageMenuNormalHeight,  eventMenuNormalHeight)


/* =========================================changeMenu===============================================*/


/* =========================================开放的属性==================================================*/
//标题高度
@property(nonatomic,assign)CGFloat titleHeight;
@end

NS_ASSUME_NONNULL_END
