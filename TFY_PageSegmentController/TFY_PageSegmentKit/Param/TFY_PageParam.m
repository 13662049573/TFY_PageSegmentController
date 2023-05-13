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
TFY_PagePropertyImplementation(TFY_PageParam, NSArray*,               titleArr)
TFY_PagePropertyImplementation(TFY_PageParam, NSArray*,               controllers)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomTitle,        customTitleContent)
TFY_PagePropertyImplementation(TFY_PageParam, PageTitleMenu,          menuAnimal)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   menuAnimalTitleGradient)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   tapScrollAnimal)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   menuFixShadow)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   topSuspension)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   fromNavi)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   naviAlpha)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   scrollCanTransfer)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   bounces)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   naviAlphaAll)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   fixFirst)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   lazyLoading)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   headScaling)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   hideRedCircle)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   avoidQuickScroll)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   headerScrollHide)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   deviceChange)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   didScrollMenuColorChange)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   menuAnimalTitleScale)
TFY_PagePropertyImplementation(TFY_PageParam, PagePopType,            respondGuestureType)
TFY_PagePropertyImplementation(TFY_PageParam, BOOL,                   menuFollowSliding)
TFY_PagePropertyImplementation(TFY_PageParam, int,                    globalTriggerOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuWidth)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuPosition,       menuPosition)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleWidth)
TFY_PagePropertyImplementation(TFY_PageParam, NSInteger,              menuDefaultIndex)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCellMargin)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleSelectColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuIndicatorColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorHeight)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorRadio)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       customDataViewHeight)
TFY_PagePropertyImplementation(TFY_PageParam, NSString*,              menuIndicatorImage)
TFY_PagePropertyImplementation(TFY_PageParam, PageBtnPosition,        menuImagePosition)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuImageMargin)
TFY_PagePropertyImplementation(TFY_PageParam, id,                     menuFixRightData)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleBackground)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuBgColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               bgColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuFixWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCellMarginY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                topChangeHeight)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuBottomMarginY)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadViewBlock,      menuHeadView)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuTitle,    customMenufixTitle)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleWeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadViewBlock,      menuAddSubView)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  customMenuView)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomRedText,      customRedView)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  insertHeadAndMenuBg)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  insertMenuLine)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuTitle,    customMenuTitle)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuSelectTitle,customMenuSelectTitle)
TFY_PagePropertyImplementation(TFY_PageParam, PageClickBlock,         eventFixedClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageClickBlock,         eventClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageDownRepeatClickBlock,eventDownRepeatClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageVCChangeBlock,      eventBeganTransferController)
TFY_PagePropertyImplementation(TFY_PageParam, PageVCChangeBlock,      eventEndTransferController)
TFY_PagePropertyImplementation(TFY_PageParam, PageChildVCScroll,      eventChildVCDidSroll)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuChangeHeight,   eventMenuChangeHeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuNormalHeight,   eventMenuNormalHeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageViewControllerIndex,viewController)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       customNaviBarY)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       customTabbarY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorTitleRelativeWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                customDataViewTopOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCircilRadio)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuHeight)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                menuTitleUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                menuTitleSelectUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuSelectTitleBackground)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleRadios)
TFY_PagePropertyImplementation(TFY_PageParam, PageFailureGestureRecognizer,customFailGesture)
TFY_PagePropertyImplementation(TFY_PageParam, PageSimultaneouslyGestureRecognizer,customSimultaneouslyGesture)
TFY_PagePropertyImplementation(TFY_PageParam, PageJDAnimalBlock,      eventCustomJDAnimal)
TFY_PagePropertyImplementation(TFY_PageParam, UIEdgeInsets,           menuInsets)
TFY_PagePropertyImplementation(TFY_PageParam, NSArray<NSString*>*,                  stopSimultaneouslyClassNameArray)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               themeColor)

- (instancetype)init{
    if (self = [super init]) {
        _themeColor = PageColor(0xFC2040);
        _menuAnimal = PageTitleMenuNone;
        _menuTitleColor = PageColor(0x333333);
        _menuTitleSelectColor = _themeColor;
        _menuIndicatorColor = _themeColor;
        _menuBgColor = PageColor(0xffffff);
        _menuIndicatorHeight = 3.1;
        _menuWidth = PageVCWidth;
        _menuAnimalTitleGradient = YES;
        _menuTitleUIFont = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
        _menuTitleSelectUIFont = [UIFont systemFontOfSize:20.0f weight:UIFontWeightMedium];
        _menuImagePosition = PageBtnPositionTop;
        _menuImageMargin = 5.0f;
        _menuCellMargin = 30.0f;
        _menuFixWidth = 45.0f;
        _menuFixShadow = YES;
        _fromNavi = YES;
        _scrollCanTransfer = YES;
        _bgColor = PageColor(0xffffff);
        _menuHeight = 55.0f;
        _lazyLoading = YES;
        _menuInsets = UIEdgeInsetsZero;
        _hideRedCircle = YES;
        _menuFollowSliding = YES;
        _customDataViewTopOffset = PageVCStatusBarHeight;
        _headerScrollHide = YES;
        _respondGuestureType = PagePopFirst;
        _globalTriggerOffset = UIScreen.mainScreen.bounds.size.width * 0.15;
        _avoidQuickScroll = YES;
        _menuIndicatorTitleRelativeWidth = 6;
        _didScrollMenuColorChange = YES;
    }
    return self;
}

- (void)defaultProperties{
    if (self.menuAnimal == PageTitleMenuAiQY && !self.menuIndicatorWidth) self.menuIndicatorWidth = 20;
    if (self.menuAnimal == PageTitleMenuNone||
        self.menuAnimal == PageTitleMenuCircleBg||
        self.menuAnimal == PageTitleMenuCircle||
        self.menuAnimal == PageTitleMenuPDD) self.menuAnimalTitleGradient = NO;
    if (self.menuAnimal == PageTitleMenuPDD && !self.menuIndicatorWidth) self.menuIndicatorWidth = 25;
    if (self.menuAnimal == PageTitleMenuCircle) {
        if (CGColorEqualToColor(self.menuIndicatorColor.CGColor, self.themeColor.CGColor))  self.menuIndicatorColor = PageColor(0xe1f9fe);
        if (CGColorEqualToColor(self.menuTitleSelectColor.CGColor, self.themeColor.CGColor)) self.menuTitleSelectColor = PageColor(0x00baf9);
        if (self.menuIndicatorHeight <= 15.0f)  self.menuIndicatorHeight = 0;
    }else if (self.menuAnimal == PageTitleMenuCircleBg) {
        if (CGColorEqualToColor(self.menuSelectTitleBackground.CGColor, [UIColor clearColor].CGColor) || !self.menuSelectTitleBackground)
            self.menuSelectTitleBackground = [UIColor orangeColor];
        if (CGColorEqualToColor(self.menuTitleSelectColor.CGColor,self.themeColor.CGColor))  self.menuTitleSelectColor = [UIColor whiteColor];
        if (!self.menuCellMarginY)  self.menuCellMarginY = 10.f;
        if (!self.menuBottomMarginY)  self.menuBottomMarginY = 10.f;
        if (UIEdgeInsetsEqualToEdgeInsets(self.menuInsets, UIEdgeInsetsZero)) {
            self.menuInsets = UIEdgeInsetsMake(self.menuCellMarginY, 0, self.menuBottomMarginY, 0);
        }
    }
    if (self.menuPosition == PageMenuPositionNavi) {
        if (CGColorEqualToColor(self.menuBgColor.CGColor, PageColor(0xffffff).CGColor)) self.menuBgColor = [UIColor clearColor];
        if (self.menuHeight >= 55.0f) self.menuHeight = 40.0f;
    }
}

@end
