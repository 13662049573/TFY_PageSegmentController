//
//  TFY_PageParam.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageParam.h"

@implementation TFY_PageParam

TFY_PageParam * PageParam(void){
    return  [TFY_PageParam new];
}
TFY_PagePropertyImplementation(TFY_PageParam, NSArray*,               titleArr)
TFY_PagePropertyImplementation(TFY_PageParam, NSArray*,               controllers)
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
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuWidth)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuPosition,       menuPosition)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleOffset)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleWidth)
TFY_PagePropertyImplementation(TFY_PageParam, NSInteger,              menuDefaultIndex)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleRightColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCellMargin)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCellPadding)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleSelectColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleSelectRightColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuIndicatorColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorHeight)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorRadio)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       customDataViewHeight)
TFY_PagePropertyImplementation(TFY_PageParam, NSString*,              menuIndicatorImage)
TFY_PagePropertyImplementation(TFY_PageParam, PageBtnPosition,        menuImagePosition)
TFY_PagePropertyImplementation(TFY_PageParam, PageSpecialType,        menuSpecifial)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuImageMargin)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuImageRightMargin)
TFY_PagePropertyImplementation(TFY_PageParam, PageBtnPosition,        menuImageRightPosition)
TFY_PagePropertyImplementation(TFY_PageParam, id,                     menuFixRightData)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuTitleBackground)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuBgColor)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               bgColor)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuFixWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuFixRightWidth)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCellMarginY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                topChangeHeight)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuBottomMarginY)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadViewBlock,      menuHeadView)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuTitle,    customMenufixTitle)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleWeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  customMenuView)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomRedText,      customRedView)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  insertHeadAndMenuBg)
TFY_PagePropertyImplementation(TFY_PageParam, PageHeadAndMenuBgView,  insertMenuLine)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuTitle,    customMenuTitle)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomMenuSelectTitle,customMenuSelectTitle)
TFY_PagePropertyImplementation(TFY_PageParam, PageClickBlock,         eventFixedClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageClickBlock,         eventClick)
TFY_PagePropertyImplementation(TFY_PageParam, PageVCChangeBlock,      eventBeganTransferController)
TFY_PagePropertyImplementation(TFY_PageParam, PageVCChangeBlock,      eventEndTransferController)
TFY_PagePropertyImplementation(TFY_PageParam, PageChildVCScroll,      eventChildVCDidSroll)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuChangeHeight,   eventMenuChangeHeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageMenuNormalHeight,   eventMenuNormalHeight)
TFY_PagePropertyImplementation(TFY_PageParam, PageViewControllerIndex,viewController)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       customNaviBarY)
TFY_PagePropertyImplementation(TFY_PageParam, PageCustomFrameY,       customTabbarY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuIndicatorY)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuCircilRadio)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuHeight)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                menuTitleUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                menuTitleSelectUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIFont*,                menuTitleRightUIFont)
TFY_PagePropertyImplementation(TFY_PageParam, UIColor*,               menuSelectTitleBackground)
TFY_PagePropertyImplementation(TFY_PageParam, CGFloat,                menuTitleRadios)
- (instancetype)init{
    if (self = [super init]) {
        self.menuAnimal = PageTitleMenuNone;
        self.menuTitleRightColor = self.menuTitleColor = PageColor(0x333333);
        self.menuTitleSelectRightColor = self.menuTitleSelectColor = PageColor(0xE5193E);
        self.menuIndicatorColor = PageColor(0xE5193E);
        self.menuBgColor = PageColor(0xffffff);
        self.menuIndicatorHeight = 3.0f;
        self.menuWidth = PageVCWidth;
        self.menuAnimalTitleGradient = YES;
        self.menuTitleUIFont = [UIFont systemFontOfSize:17.0f];
        self.menuTitleSelectUIFont = [UIFont systemFontOfSize:18.5f];
        self.menuTitleRightUIFont = [UIFont systemFontOfSize:17];
        self.menuImageRightPosition = self.menuImagePosition = PageBtnPositionTop;
        self.menuImageRightMargin = self.menuImageMargin = 5.0f;
        self.menuCellMargin = 30.0f;
        self.menuCellPadding = 30.0f;
        self.menuFixRightWidth = self.menuFixWidth = 45.0f;
        self.menuFixShadow = YES;
        self.fromNavi = YES;
        self.scrollCanTransfer = YES;
        self.bgColor = PageColor(0xffffff);
        self.menuHeight = 55.0f;
        self.lazyLoading = YES;
        self.menuTitleBackground = [UIColor clearColor];
        self.menuSelectTitleBackground = [UIColor clearColor];
    }
    return self;
}


@end
