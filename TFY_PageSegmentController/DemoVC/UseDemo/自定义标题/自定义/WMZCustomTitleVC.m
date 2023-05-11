//
//  WMZCustomTitleVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/8/13.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZCustomTitleVC.h"

@interface WMZCustomTitleVC ()

@end

@implementation WMZCustomTitleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TFY_PageParam *param = TFY_PageParam.new;
    param
    .MenuBgColorSet(PageColor(0xf8f6f8))
    .MenuInsetsSet(UIEdgeInsetsMake(10, 10, 10, 10))
    .TitleArrSet(@[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"])
    .MenuTitleWidthSet(100)
    .BgColorSet(PageColor(0xf8f6f8))
    .MenuAnimalSet(PageTitleMenuPDD)
    .MenuImagePositionSet(PageBtnPositionTop);
    param.ViewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    //自定义静态标题 返回了显示的标题对象 可以自行改变
    param.CustomMenuTitle = ^(NSArray<TFY_PageNavBtn *> * _Nullable titleArr) {
        [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != titleArr.count-1)
                [obj viewPathWithColor:PageColor(0x666666) pathType:PageShadowPathRight pathWidth:PageK1px heightScale:0.4];
        }];
    };
    //自定义选中标题
    param.CustomMenuSelectTitle = ^(NSArray<TFY_PageNavBtn *> * _Nullable titleArr) {
        
    };
    
    self.param = param;
}

@end
