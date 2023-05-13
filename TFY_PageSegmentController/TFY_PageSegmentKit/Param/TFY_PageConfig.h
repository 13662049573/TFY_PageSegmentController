//
//  TFY_PageConfig.h
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#ifndef TFY_PageConfig_h
#define TFY_PageConfig_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "TFY_PageProtocol.h"

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

///判断ipad
#define PageIsIpad ({\
BOOL isIpad = NO;\
if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {\
    isIpad =  YES;\
}\
isIpad;\
})

///状态栏高度
#define PageVCStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
///导航栏高度
#define PageVCNavBarHeight ((PageIsIpad?50.f:44.f)+ PageVCStatusBarHeight)
///底部标签栏高度
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


/// 按钮图文位置
typedef enum :NSInteger{
    ///图片在左，文字在右，默认
    PageBtnPositionLeft     = 0,
    ///图片在右，文字在左
    PageBtnPositionRight    = 1,
    ///图片在上，文字在下
    PageBtnPositionTop      = 2,
    ///图片在下，文字在上
    PageBtnPositionBottom   = 3,
}PageBtnPosition;

///指示器的效果
typedef enum :NSInteger{
    ///无样式
    PageTitleMenuNone     = 0,
    ///带下划线
    PageTitleMenuLine     = 1,
    ///背景圆角框
    PageTitleMenuCircle   = 2,
    ///爱奇艺效果(指示器跟随移动)
    PageTitleMenuAiQY     = 3,
    ///今日头条效果(变大加颜色渐变)
    PageTitleMenuTouTiao  = 4,
    ///拼多多效果(底部线条)
    PageTitleMenuPDD      = 5,
    ///标题背景圆角
    PageTitleMenuCircleBg = 6,
    ///新爱奇艺效果(指示器跟随移动)
    PageTitleMenuNewAiQY  = 7,
    ///京东（动画下标）
    PageTitleMenuJD       = 8,
}PageTitleMenu;

///菜单栏的位置
typedef enum :NSInteger{
    ///上左
    PageMenuPositionLeft          = 0,
    ///上右
    PageMenuPositionRight         = 1,
    ///居中
    PageMenuPositionCenter        = 2,
    ///导航栏
    PageMenuPositionNavi          = 3,
    ///底部
    PageMenuPositionBottom        = 4,
}PageMenuPosition;

/// 响应侧滑或者全屏返回
typedef enum :NSInteger{
    ///不响应
    PagePopNone         = 0,
    ///第一个响应
    PagePopFirst        = 1,
    ///全部响应
    PagePopAll          = 2,
}PagePopType;

///设置阴影
typedef enum :NSInteger{
    ///上
    PageShadowPathTop,
    ///下
    PageShadowPathBottom,
    ///左
    PageShadowPathLeft,
    ///右
    PageShadowPathRight,
    ///普通
    PageShadowPathCommon,
    ///四边
    PageShadowPathAround
}PageShadowPathType;

///渐变色
typedef enum :NSInteger{
    ///水平方向渐变
    PageGradientChangeDirectionLevel,
    ///垂直方向渐变
    PageGradientChangeDirectionVertical,
    ///主对角线方向渐变
    PageGradientChangeDirectionUpwardDiagonalLine,
    ///副对角线方向渐变
    PageGradientChangeDirectionDownDiagonalLine,
}PageGradientChangeDirection;

///点击
typedef enum :NSInteger{
    ///常态
    PageBTNTapNormal = 0,
    ///仅点击
    PageBTNTapNone,
    ///仅点击且带动画
    PageBTNTapAnimalNone,
}PageBTNTapType;

///标题点击
typedef void (^PageClickBlock)(TFY_PageNavBtn *_Nullable btn,NSInteger index);

/// 切换再次点击按钮，实现下拉展开和关闭事件
typedef void (^PageDownRepeatClickBlock)(TFY_PageNavBtn *_Nullable btn,BOOL isSelected);

///控制器切换
typedef void (^PageVCChangeBlock)(UIViewController* _Nullable oldVC,UIViewController * _Nullable newVC,NSInteger oldIndex,NSInteger newIndex);

///子控制器滚动
typedef void (^PageChildVCScroll)(UIViewController* _Nullable pageVC,CGPoint oldPoint,CGPoint newPonit,UIScrollView * _Nullable currentScrollView);

///头视图
typedef UIView* _Nullable (^PageHeadViewBlock)(void);

///固定尾视图
typedef UIView* _Nullable (^PageFootViewBlock)(void);

///头视图和菜单栏的背景层
typedef void (^PageHeadAndMenuBgView)(UIView * _Nullable bgView);

///自定义红点
typedef void (^PageCustomRedText)(UILabel * _Nullable redLa,NSDictionary * _Nullable info);

///自定义菜单栏
typedef void (^PageCustomMenuTitle)(NSArray<TFY_PageNavBtn*> * _Nullable titleArr);

///滚动 后改变标题
typedef void (^PageCustomMenuSelectTitle)(NSArray <TFY_PageNavBtn*>* _Nullable titleArr);

///切换高度block
typedef void (^PageMenuChangeHeight)(NSArray<TFY_PageNavBtn*>* _Nullable titleArr,CGFloat offset);

///恢复原来高度block
typedef void (^PageMenuNormalHeight)(NSArray<TFY_PageNavBtn*>* _Nullable titleArr);

///vc数组
typedef UIViewController* _Nullable (^PageViewControllerIndex)(NSInteger index);

///自定义Y
typedef CGFloat (^PageCustomFrameY)(CGFloat nowY);

///自定义手势fail
typedef BOOL (^PageFailureGestureRecognizer)(UIGestureRecognizer * _Nullable  gestureRecognizer,UIGestureRecognizer * _Nullable otherGestureRecognizer);

///自定义手势Simultaneously
typedef BOOL (^PageSimultaneouslyGestureRecognizer)(UIGestureRecognizer *_Nullable gestureRecognizer,UIGestureRecognizer *_Nullable otherGestureRecognizer);

/// 自定义京东动画视图frame
typedef void (^PageJDAnimalBlock)(TFY_PageNavBtn *_Nullable sender,UIView *_Nullable jdLayer);

/// 自定义标题内容
typedef NSString* _Nullable(^PageCustomTitle)(id _Nullable model,NSInteger index);



#endif /* TFY_PageConfig_h */
