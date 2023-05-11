//
//  TFY_PageParam.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageParam : NSObject

/* =========================================required==============================================*/
/// 标题数组 必传
/// 可传带字典的数组  key值为TFY_PageBTNKey
typedef NSString *TFY_PageBTNKey NS_STRING_ENUM;
// 红点提示  @(-1)(显示红点) 或者 带数字 @(99)，@(1) @"99+"  CustomRedView使用这个属性可以调整角标的位置和样式
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyBadge;
/// 标题  NSString/NSAttributedString  支持传入富文本
/// 如果此处传入富文本则TFY_PageKeySelectName 也需要传入 此时设置的选中标题title font uicolor会失效
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyName;
/// 选中后标题 NSString/NSAttributedString  支持传入富文本
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeySelectName;
/// 指示器颜色 UIColor
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyIndicatorColor;
/// 字体颜色 UIColor
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleColor;
/// 选中字体颜色 UIColor
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleSelectColor;
/// 图片 NSString/UIImage
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyImage;
/// 选中后图片 NSString/UIImage
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeySelectImage;
/// 选中背景颜色 [UIColor redColor] (如果是数组则是背景色渐变色) @[[UIColor redColor],[UIColor orangeColor]]
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyBackgroundColor;
/// 标题背景颜色 UIColor
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleBackground;
/// 图文距离 @(5)
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyImageOffset;
/// 仅点击页面不加载 @(YES) 需要关闭滑动手势
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyOnlyClick;
/// 仅点击页面不加载附带指示器改变 @(YES)
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyOnlyClickWithAnimal;
/// 自定义标题宽度(优先级最高)   @(100)
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleWidth;
/// 自定义标题高度(优先级最高)   @(100)
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleHeight;
/// 自定义标题x间距(优先级最高)  @(100)
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleMarginX;
/// 自定义标题y坐标(优先级最高)  @(100)
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyTitleMarginY;
/// 当前子控制器不悬浮固定在顶部  @(NO)  NO表示不悬浮
FOUNDATION_EXPORT TFY_PageBTNKey const TFY_PageKeyCanTopSuspension;

TFY_PagePropertyStatement(strong, TFY_PageParam,NSArray*,              TitleArr)
/// 1.4.0之后 新增支持UIView 一样用法都是用这个属性 直接传入UIView即可 有警告的话用强转UIViewController
/// VC数据 必传(二选一) 1.1.6新增
TFY_PagePropertyStatement(copy, TFY_PageParam, PageViewControllerIndex,  ViewController)
/// VC数组 必传(二选一) (如果要做标题内容动态增删操作的必须使用此属性 )
TFY_PagePropertyStatement(copy, TFY_PageParam, NSArray*,    Controllers)
/// 自定义标题内容  v1.5.3
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomTitle,  CustomTitleContent)
/* =========================================required==============================================*/

/* =========================================customFrame===============================================*/

/// 自定义整体距离顶部的位置(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomFrameY,        CustomNaviBarY)
/// 自定义整体距离底部的位置(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomFrameY,        CustomTabbarY)
/// 自定义底部滚动视图的高度(如果默认算的不准确 或者需要修改) block内会传回当前的值 可对比自行返回最终需要的
TFY_PagePropertyStatement(copy, TFY_PageParam, PageCustomFrameY,        CustomDataViewHeight)
///悬浮开启且没有导航栏的时候 默认悬浮至状态栏下 CustomDataViewTopOffset = statusBar
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               CustomDataViewTopOffset)

/// 自定义Fail手势
TFY_PagePropertyStatement(copy, TFY_PageParam, PageFailureGestureRecognizer,CustomFailGesture)
/// 自定义Simultaneously手势
TFY_PagePropertyStatement(copy, TFY_PageParam, PageSimultaneouslyGestureRecognizer,CustomSimultaneouslyGesture)

/* =========================================customFrame===============================================*/

/* =========================================special==============================================*/
/// 特殊属性 菜单滑动到顶部悬浮 default NO 需要实现协议
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  TopSuspension)
/// 导航栏透明度变化 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  NaviAlpha)
/// 滑动切换 default YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  ScrollCanTransfer)
/// 头部视图frame从导航栏下方开始 default YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  FromNavi)
/// 菜单最右边固定内容是否开启左边阴影 defaulf YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  MenuFixShadow)
/// 开启渐变色 default yes
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  MenuAnimalTitleGradient)

/// 开启标题滑动根据字体大小自动缩放 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  MenuAnimalTitleScale)
/// 顶部可下拉 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  Bounces)
/// 导航栏整个透明 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  NaviAlphaAll)
/// 点击滑动带动画 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  TapScrollAnimal)
/// 特殊属性 固定在所有子控制器的底部 需要在第一个子控制器实现固定底部协议
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  FixFirst)
/// 延迟加载 default YES 延迟了0.1秒 所以在addsubview等操作的时候 需要延迟0.1秒去加载
/// 注意如果此属性为NO 则无法准确获取控制器的显示frame 需要自己调用CustomNaviBarY/CustomTabbarY/CustomDataViewHeight 调试
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  LazyLoading)
/// 头部下拉缩放效果 default NO
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  HeadScaling)
/// 点击隐藏红点 default YES
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  HideRedCircle)
/// 菜单栏跟随滑动 default YES  为NO则视图手势滑动结束菜单栏再滑动  v1.4.1
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  MenuFollowSliding)
/// 自动适配横竖屏  default NO v1.5.1 仅继承TFY_PageVieController有效 独立使用TFY_PageView需要自己适配
/// 子控制器需要使用自动布局 或者适配好布局
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  DeviceChange)

/// 悬浮状态下 防止快速滑动的时候直接从底部直接滚动到顶部 default NO v1.4.3
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  AvoidQuickScroll)
/// 悬浮和开启透明度变化下  置顶头部是否透明度置为0  default YES v1.5.0
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  HeaderScrollHide)

/// 响应侧滑或者全屏返回手势 default PagePopFirst 首个子视图/子控制器响应  v1.4.1
TFY_PagePropertyStatement(assign, TFY_PageParam, PagePopType,           RespondGuestureType)
/// 全部返回响应手势的位置 RespondGuestureType为PagePopAll有效 default pageWidth * 0.15  v1.4.1
TFY_PagePropertyStatement(assign, TFY_PageParam, int,                   GlobalTriggerOffset)
/// 不与下滑手势一起滑动的UIVie视图className数组 比如cell上的collectionView 则传入 @[@"UICollectionView"]
TFY_PagePropertyStatement(copy, TFY_PageParam, NSArray<NSString*>*,                  StopSimultaneouslyClassNameArray)
/* =========================================special==============================================*/


/* =========================================Menu==================================================*/
/// 主题色 default 0xFC2040
TFY_PagePropertyStatement(copy,   TFY_PageParam, UIColor*,                 ThemeColor)
/// 菜单栏高度 default 60
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,                  MenuHeight)
/// 给菜单栏和headView加个背景层 default -
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadAndMenuBgView,    InsertHeadAndMenuBg)
/// 给菜单栏加个下划线 default -
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadAndMenuBgView,    InsertMenuLine)
/// 自定义菜单栏 default -
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadAndMenuBgView,    CustomMenuView)
/// 自定义菜单右上角红点
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomRedText,        CustomRedView)
/// 自定义菜单栏上的标题
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomMenuTitle,      CustomMenuTitle)
/// 自定义选中后菜单栏上的标题
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomMenuSelectTitle,CustomMenuSelectTitle)
/// 自定义固定标题
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageCustomMenuTitle,      CustomMenufixTitle)
/// 头部视图 default nil
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadViewBlock,     MenuHeadView)
/// 菜单栏底部携带自定义视图 default nil  v1.4.3
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageHeadViewBlock,     MenuAddSubView)
/// 默认选中 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, NSInteger,             MenuDefaultIndex)
/// 菜单最右边固定内容 default nil (可传字符串/字典/数组)
TFY_PagePropertyStatement(strong, TFY_PageParam, id,                    MenuFixRightData)
/// 菜单最右边固定内容宽度 defaulf 45
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuFixWidth)
/// 菜单标题动画效果 default  PageTitleMenuMove
TFY_PagePropertyStatement(assign, TFY_PageParam, PageTitleMenu,         MenuAnimal)
/// 菜单宽度 default 屏幕宽度
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuWidth)
/// 菜单背景颜色 default ffffff
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              MenuBgColor)
/// 整体视图背景颜色 default ffffff
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              BgColor)
/// 菜单标题左右内边距 default 20
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuCellMargin)
/// 滑动的时候是否菜单背景颜色自动改变 default YES 1.5.4
TFY_PagePropertyStatement(assign, TFY_PageParam, BOOL,                  DidScrollMenuColorChange)
/// 菜单按钮距离顶部的y值 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuCellMarginY)
/// 菜单按钮距离底部部的y值 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuBottomMarginY)
/// 1.4.0新增 菜单外边距  default  zero top可替代 MenuCellMarginY  bottom可替代 MenuBottomMarginY 优先级最大
TFY_PagePropertyStatement(assign, TFY_PageParam, UIEdgeInsets,          MenuInsets)

/// 菜单的位置 default PageMenuPositionLeft
TFY_PagePropertyStatement(assign, TFY_PageParam, PageMenuPosition,      MenuPosition)
/// 菜单标题左右间距 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuTitleOffset)
/// 菜单标题字体 default [UIFont 15]
TFY_PagePropertyStatement(strong, TFY_PageParam, UIFont*,               MenuTitleUIFont)
/// 菜单标题字体 default [UIFont MenuTitleFont+1.5]
TFY_PagePropertyStatement(strong, TFY_PageParam, UIFont*,               MenuTitleSelectUIFont)
/// 菜单标题固定宽度 default 文本内容宽度+MenuCellMargin
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuTitleWidth)
/// 菜单标题字体粗体 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuTitleWeight)
/// 菜单字体颜色 default 333333
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              MenuTitleColor)
/// 菜单字体选中颜色 default E5193E
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              MenuTitleSelectColor)
/// 菜单图文位置 default PageBtnPositionTop
TFY_PagePropertyStatement(assign, TFY_PageParam, PageBtnPosition,       MenuImagePosition)
/// 菜单图文位置间距 default 5
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuImageMargin)
/// 背景圆圈的圆角 默认高度的一半
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuCircilRadio)
/// 菜单标题背景颜色 default nil
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              MenuTitleBackground)
/// 菜单标题选中背颜色 default nil
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              MenuSelectTitleBackground)
/// 菜单标题圆角 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuTitleRadios)

/// 指示器颜色 default E5193E
TFY_PagePropertyStatement(strong, TFY_PageParam, UIColor*,              MenuIndicatorColor)
/// 指示器宽度 default 标题宽度+10
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuIndicatorWidth)
/// 指示器图片 default nil
TFY_PagePropertyStatement(strong, TFY_PageParam, NSString*,             MenuIndicatorImage)
/// 指示器高度 default k1px
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuIndicatorHeight)
/// 指示器圆角 default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuIndicatorRadio)
/// 指示器距离按钮的y值(AQY) default 5
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuIndicatorY)
/// 指示器的相对菜单标题的宽度差值 default 6
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               MenuIndicatorTitleRelativeWidth)

/* =========================================Menu===============================================*/

/* =========================================Events==================================================*/
TFY_PageParam * PageParam(void);
/// 右边固定标题点击
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageClickBlock,        EventFixedClick)

/// 标题点击
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageClickBlock,        EventClick)
/// 控制器开始切换
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageVCChangeBlock,     EventBeganTransferController)
/// 控制器结束切换
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageVCChangeBlock,     EventEndTransferController)
/// 子控制器滚动(做滚动时候自己的操作)  =>开启悬浮有效
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageChildVCScroll,     EventChildVCDidSroll)

/// 自定义京东动画frame
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageJDAnimalBlock,     EventCustomJDAnimal)

/* =========================================Events==================================================*/

/* =========================================changeMenu===============================================*/

/// 滑动到顶部改变菜单栏的高度 可传入正负值 改变的高度为当前的titleHeight+传入TopChangeHeight default 0
TFY_PagePropertyStatement(assign, TFY_PageParam, CGFloat,               TopChangeHeight)
/// 改变高度的block 可在此做标题的操作
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageMenuChangeHeight,  EventMenuChangeHeight)
/// 恢复原来高度的block 可在此做标题的操作
TFY_PagePropertyStatement(copy,   TFY_PageParam, PageMenuNormalHeight,  EventMenuNormalHeight)

/* =========================================changeMenu===============================================*/

- (void)defaultProperties;

@end

NS_ASSUME_NONNULL_END
