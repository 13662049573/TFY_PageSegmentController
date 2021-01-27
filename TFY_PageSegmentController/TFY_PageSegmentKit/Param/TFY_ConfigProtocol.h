//
//  TFY_ConfigProtocol.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSObject+ListenKVO.h"
#import "TFY_PageTitleModel.h"

@class TFY_PageNavBtn;

#define   PageVCWidth   [UIScreen mainScreen].bounds.size.width
#define   PageVCHeight  [UIScreen mainScreen].bounds.size.height

#define PageDarkColor(light,dark)    \
({\
    UIColor *wMenuIndicator = nil; \
    if (@available(iOS 13.0, *)) {  \
        wMenuIndicator = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) { \
        if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {  \
            return light;  \
        }else {   \
            return dark;  \
        }}];  \
    }else{  \
        wMenuIndicator = light;  \
    }   \
    (wMenuIndicator); \
})\

#define PageColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define PageK1px (1 / UIScreen.mainScreen.scale)

#define  PageWindow \
({\
UIWindow *window = nil; \
if (@available(iOS 13.0, *)) \
{ \
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) { \
        if (windowScene.activationState == UISceneActivationStateForegroundActive) \
        { \
            for (UIWindow *currentWindow in windowScene.windows)\
            { \
                if (currentWindow.isKeyWindow)\
                { \
                    window = currentWindow; \
                    break; \
                }\
            }\
        }\
    }\
    if(!window){  \
        window =  [UIApplication sharedApplication].keyWindow; \
    }\
}\
else \
{ \
    window =  [UIApplication sharedApplication].keyWindow; \
}\
(window); \
})\


#define PageIsIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if (PageWindow.safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})


//状态栏高度
#define PageVCStatusBarHeight (PageIsIphoneX ? 44.f : 20.f)
//导航栏高度
#define PageVCNavBarHeight (44.f+PageVCStatusBarHeight)
//底部标签栏高度
#define PageVCTabBarHeight (PageIsIphoneX ? (49.f+34.f) : 49.f)

#define PageWSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define TFY_PagePropertyStatement(propertyModifier,className, propertyPointerType, propertyName)     \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                              \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;


#define TFY_PagePropertyImplementation(className, propertyPointerType, propertyName)                 \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                             \
PageWSelf(myself);                                                                                 \
return ^(propertyPointerType propertyName){\
    myself.propertyName = propertyName;\
    return myself;\
    };\
}


@protocol TFY_PageProtocol <NSObject>
@optional
/*
 *悬浮 可滑动的滚动视图
 */
- (UITableView*)getMyTableView;

/*
 *悬浮 两者一样 下面的只是为了减少非tableview的警告
 */
- (UIScrollView*)getMyScrollView;

/*
 *悬浮 数组 可滚动视图的数组 适用底部多个tableview的情况
 */
- (NSArray*)getMyScrollViews;

/*
 *子控制器需要固定的尾部视图
 */
- (UIView*)fixFooterView;

@end

typedef enum :NSInteger{
    PageBtnPositionLeft     = 0,            //图片在左，文字在右，默认
    PageBtnPositionRight    = 1,            //图片在右，文字在左
    PageBtnPositionTop      = 2,            //图片在上，文字在下
    PageBtnPositionBottom   = 3,            //图片在下，文字在上
}PageBtnPosition;

typedef enum :NSInteger{
    PageSpecialTypeOne     = 1,          //菜单栏可见底部子视图
    PageSpecialTypeScollTab     = 2,     //菜单栏跟随滚动
}PageSpecialType;


typedef enum :NSInteger{
    PageTitleMenuNone     = 0,            //无样式
    PageTitleMenuLine     = 1,            //带下划线
    PageTitleMenuCircle   = 2,            //背景圆角框
    PageTitleMenuAiQY     = 3,            //爱奇艺效果(指示器跟随移动)
    PageTitleMenuTouTiao  = 4,            //今日头条效果(变大加颜色渐变)
    PageTitleMenuPDD      = 5,            //拼多多效果(底部线条)
    PageTitleMenuCircleBg = 6,            //标题背景圆角
}PageTitleMenu;


typedef enum :NSInteger{
    PageMenuPositionLeft          = 0,            //上左
    PageMenuPositionRight         = 1,            //上右
    PageMenuPositionCenter        = 2,            //居中
    PageMenuPositionNavi          = 3,            //导航栏
    PageMenuPositionBottom        = 4,            //底部
}PageMenuPosition;

//设置阴影
typedef enum :NSInteger{
    PageShadowPathTop,
    PageShadowPathBottom,
    PageShadowPathLeft,
    PageShadowPathRight,
    PageShadowPathCommon,
    PageShadowPathAround
}PageShadowPathType;

//渐变色
typedef enum :NSInteger{
    PageGradientChangeDirectionLevel,                    //水平方向渐变
    PageGradientChangeDirectionVertical,                 //垂直方向渐变
    PageGradientChangeDirectionUpwardDiagonalLine,       //主对角线方向渐变
    PageGradientChangeDirectionDownDiagonalLine,         //副对角线方向渐变
}PageGradientChangeDirection;


/*
 * 点击
 */
typedef void (^PageClickBlock)(id anyID,NSInteger index);

/*
 * 控制器切换
 */
typedef void (^PageVCChangeBlock)(UIViewController* oldVC,UIViewController *newVC,NSInteger oldIndex,NSInteger newIndex);


/*
 * 子控制器滚动
 */
typedef void (^PageChildVCScroll)(UIViewController* pageVC,CGFloat totalH,CGPoint offsetPonit,id currentTabelView);

/*
 * 头视图
 */
typedef UIView* (^PageHeadViewBlock)(void);

/*
 * 固定尾视图
 */
typedef UIView* (^PageFootViewBlock)(void);

/*
 * 头视图和菜单栏的背景层
 */
typedef void (^PageHeadAndMenuBgView)(UIView *bgView);

/*
 * 自定义红点
 */
typedef void (^PageCustomRedText)(UILabel *redLa,NSDictionary *info);

/*
 * 自定义菜单栏
 */
typedef void (^PageCustomMenuTitle)(NSArray<TFY_PageNavBtn*> *titleArr);


/*
 * 滚动 后改变标题
 */
typedef void (^PageCustomMenuSelectTitle)(NSArray *titleArr);


/*
 * 切换高度block
 */
typedef void (^PageMenuChangeHeight)(NSArray<TFY_PageNavBtn*>*titleArr,CGFloat offset);

/*
 * 恢复原来高度block
 */
typedef void (^PageMenuNormalHeight)(NSArray<TFY_PageNavBtn*>*titleArr);


/*
 * vc数组
 */
typedef UIViewController* (^PageViewControllerIndex)(NSInteger index);

/*
 * 自定义Y
 */
typedef CGFloat (^PageCustomFrameY)(CGFloat nowY);

