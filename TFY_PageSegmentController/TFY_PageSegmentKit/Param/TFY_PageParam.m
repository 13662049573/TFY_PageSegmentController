//
//  TFY_PageParam.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageParam.h"

TFY_PageBTNKey const TFY_PageKeyBadge = @"badge";
TFY_PageBTNKey const TFY_PageKeyName = @"name";
TFY_PageBTNKey const TFY_PageKeySelectName = @"selectName";
TFY_PageBTNKey const TFY_PageKeyIndicatorColor = @"indicatorColor";
TFY_PageBTNKey const TFY_PageKeyTitleColor = @"titleColor";
TFY_PageBTNKey const TFY_PageKeyTitleSelectColor = @"titleSelectColor";
TFY_PageBTNKey const TFY_PageKeyBackgroundColor = @"backgroundColor";
TFY_PageBTNKey const TFY_PageKeyOnlyClick = @"onlyClick";
TFY_PageBTNKey const TFY_PageKeyOnlyClickWithAnimal = @"onlyAnClick";
TFY_PageBTNKey const TFY_PageKeyImage = @"image";
TFY_PageBTNKey const TFY_PageKeySelectImage = @"selectImage";
TFY_PageBTNKey const TFY_PageKeyTitleWidth = @"width";
TFY_PageBTNKey const TFY_PageKeyTitleHeight = @"height";
TFY_PageBTNKey const TFY_PageKeyTitleMarginX = @"marginX" ;
TFY_PageBTNKey const TFY_PageKeyTitleMarginY = @"y";
TFY_PageBTNKey const TFY_PageKeyCanTopSuspension = @"canTopSuspension";
TFY_PageBTNKey const TFY_PageKeyTitleBackground = @"titleBackground";
TFY_PageBTNKey const TFY_PageKeyImageOffset = @"margin";


@implementation TFY_PageParam

TFY_PageParam * PageParam(void){
    return  [TFY_PageParam new];
}
TFY_PagePropertyImplementation(TFY_PageParam, NSArray*,               TitleArr)
TFY_PagePropertyImplementation(TFY_PageParam, NSArray*,               Controllers)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomTitle,        CustomTitleContent)
TFY_PagePropertyImplementation(TFY_PageParam, PageTitleMenu,          MenuAnimal)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   MenuAnimalTitleGradient)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   TapScrollAnimal)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   MenuFixShadow)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   TopSuspension)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   FromNavi)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   NaviAlpha)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   ScrollCanTransfer)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   Bounces)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   NaviAlphaAll)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   FixFirst)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   LazyLoading)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   HeadScaling)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   HideRedCircle)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   AvoidQuickScroll)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   HeaderScrollHide)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   DeviceChange)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   DidScrollMenuColorChange)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   MenuAnimalTitleScale)
TFY_PagePropertyImplementation(TFY_PageParam, PagePopType,            RespondGuestureType)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   MenuFollowSliding)
TFY_PagePropertyImplementation(TFY_PageParam, int,                    GlobalTriggerOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuWidth)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuPosition,       MenuPosition)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuTitleOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuTitleWidth)
TFY_PagePropertyImplementation(TFY_PageParam, NSInteger,              MenuDefaultIndex)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               MenuTitleColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuCellMargin)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               MenuTitleSelectColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               MenuIndicatorColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuIndicatorWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuIndicatorHeight)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuIndicatorRadio)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       CustomDataViewHeight)
TFY_PagePropertyImplementation(TFY_PageParam, NSString*,              MenuIndicatorImage)
TFY_PagePropertyImplementation(TFY_PageParam, PageBtnPosition,        MenuImagePosition)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuImageMargin)
TFY_PagePropertyImplementation(TFY_PageParam, id,                     MenuFixRightData)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               MenuTitleBackground)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               MenuBgColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               BgColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuFixWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuCellMarginY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                TopChangeHeight)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuBottomMarginY)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadViewBlock,      MenuHeadView)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuTitle,    CustomMenufixTitle)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuTitleWeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadViewBlock,      MenuAddSubView)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  CustomMenuView)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomRedText,      CustomRedView)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  InsertHeadAndMenuBg)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  InsertMenuLine)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuTitle,    CustomMenuTitle)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuSelectTitle,CustomMenuSelectTitle)
TFY_PagePropertyImplementation(TFY_PageParam, PageClickBlock,         EventFixedClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageClickBlock,         EventClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageVCChangeBlock,      EventBeganTransferController)
TFY_PagePropertyImplementation(TFY_PageParam, PageVCChangeBlock,      EventEndTransferController)
TFY_PagePropertyImplementation(TFY_PageParam, PageChildVCScroll,      EventChildVCDidSroll)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuChangeHeight,   EventMenuChangeHeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuNormalHeight,   EventMenuNormalHeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageViewControllerIndex,ViewController)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       CustomNaviBarY)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       CustomTabbarY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuIndicatorTitleRelativeWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                CustomDataViewTopOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuIndicatorY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuCircilRadio)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuHeight)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                MenuTitleUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                MenuTitleSelectUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               MenuSelectTitleBackground)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                MenuTitleRadios)
TFY_PagePropertyImplementation(TFY_PageParam, PageFailureGestureRecognizer,CustomFailGesture)
TFY_PagePropertyImplementation(TFY_PageParam, PageSimultaneouslyGestureRecognizer,CustomSimultaneouslyGesture)
TFY_PagePropertyImplementation(TFY_PageParam, PageJDAnimalBlock,      EventCustomJDAnimal)
TFY_PagePropertyImplementation(TFY_PageParam, UIEdgeInsets,           MenuInsets)
TFY_PagePropertyImplementation(TFY_PageParam, NSArray<NSString*>*,                  StopSimultaneouslyClassNameArray)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               ThemeColor)

- (instancetype)init{
    if (self = [super init]) {
        _ThemeColor = PageColor(0xFC2040);
        _MenuAnimal = PageTitleMenuNone;
        _MenuTitleColor = PageColor(0x333333);
        _MenuTitleSelectColor = _ThemeColor;
        _MenuIndicatorColor = _ThemeColor;
        _MenuBgColor = PageColor(0xffffff);
        _MenuIndicatorHeight = 3.1;
        _MenuWidth = PageVCWidth;
        _MenuAnimalTitleGradient = YES;
        _MenuTitleUIFont = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
        _MenuTitleSelectUIFont = [UIFont systemFontOfSize:20.0f weight:UIFontWeightMedium];
        _MenuImagePosition = PageBtnPositionTop;
        _MenuImageMargin = 5.0f;
        _MenuCellMargin = 30.0f;
        _MenuFixWidth = 45.0f;
        _MenuFixShadow = YES;
        _FromNavi = YES;
        _ScrollCanTransfer = YES;
        _BgColor = PageColor(0xffffff);
        _MenuHeight = 55.0f;
        _LazyLoading = YES;
        _MenuInsets = UIEdgeInsetsZero;
        _HideRedCircle = YES;
        _MenuFollowSliding = YES;
        _CustomDataViewTopOffset = PageVCStatusBarHeight;
        _HeaderScrollHide = YES;
        _RespondGuestureType = PagePopFirst;
        _GlobalTriggerOffset = UIScreen.mainScreen.bounds.size.width * 0.15;
        _AvoidQuickScroll = YES;
        _MenuIndicatorTitleRelativeWidth = 6;
        _DidScrollMenuColorChange = YES;
    }
    return self;
}

- (void)defaultProperties{
    if (self.MenuAnimal == PageTitleMenuAiQY && !self.MenuIndicatorWidth) self.MenuIndicatorWidth = 20;
    if (self.MenuAnimal == PageTitleMenuNone||
        self.MenuAnimal == PageTitleMenuCircleBg||
        self.MenuAnimal == PageTitleMenuCircle||
        self.MenuAnimal == PageTitleMenuPDD) self.MenuAnimalTitleGradient = NO;
    if (self.MenuAnimal == PageTitleMenuPDD && !self.MenuIndicatorWidth) self.MenuIndicatorWidth = 25;
    if (self.MenuAnimal == PageTitleMenuCircle) {
        if (CGColorEqualToColor(self.MenuIndicatorColor.CGColor, self.ThemeColor.CGColor))  self.MenuIndicatorColor = PageColor(0xe1f9fe);
        if (CGColorEqualToColor(self.MenuTitleSelectColor.CGColor, self.ThemeColor.CGColor)) self.MenuTitleSelectColor = PageColor(0x00baf9);
        if (self.MenuIndicatorHeight <= 15.0f)  self.MenuIndicatorHeight = 0;
    }else if (self.MenuAnimal == PageTitleMenuCircleBg) {
        if (CGColorEqualToColor(self.MenuSelectTitleBackground.CGColor, [UIColor clearColor].CGColor) || !self.MenuSelectTitleBackground)
            self.MenuSelectTitleBackground = [UIColor orangeColor];
        if (CGColorEqualToColor(self.MenuTitleSelectColor.CGColor,self.ThemeColor.CGColor))  self.MenuTitleSelectColor = [UIColor whiteColor];
        if (!self.MenuCellMarginY)  self.MenuCellMarginY = 10.f;
        if (!self.MenuBottomMarginY)  self.MenuBottomMarginY = 10.f;
        if (UIEdgeInsetsEqualToEdgeInsets(self.MenuInsets, UIEdgeInsetsZero)) {
            self.MenuInsets = UIEdgeInsetsMake(self.MenuCellMarginY, 0, self.MenuBottomMarginY, 0);
        }
    }
    if (self.MenuPosition == PageMenuPositionNavi) {
        if (CGColorEqualToColor(self.MenuBgColor.CGColor, PageColor(0xffffff).CGColor)) self.MenuBgColor = [UIColor clearColor];
        if (self.MenuHeight >= 55.0f) self.MenuHeight = 40.0f;
    }
}

@end
