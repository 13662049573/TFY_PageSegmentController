//
//  TFY_DemoTwo.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_DemoTwo.h"
#import "TFY_TopSuspensionVC.h"
@interface TFY_DemoTwo ()

@end

@implementation TFY_DemoTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = PageColor(0x4895ef);
    
    TFY_PageParam *param = PageParam()
    .menuBgColorSet([UIColor redColor])
    .menuTitleSelectColorSet([UIColor redColor])
    .controllersSet(@[[TFY_TopSuspensionVC new],[TFY_TopSuspensionVC new],[TFY_TopSuspensionVC new],[TFY_TopSuspensionVC new],[TFY_TopSuspensionVC new],[TFY_TopSuspensionVC new],[TFY_TopSuspensionVC new]])
    .titleArrSet([self attributesData])
    .menuTitleWidthSet(PageVCWidth/4)
    .menuCellMarginYSet(10)
    .menuCircilRadioSet(20)
    .menuAnimalSet(PageTitleMenuCircle)
    //自定义富文本
    .customMenuTitleSet(^(NSArray *titleArr) {
        [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
            [self customBtn:btn];
        }];
    });
    //自定义滑动后标题的变化 如有需要
//    .wCustomMenuSelectTitleSet(^(NSArray *titleArr) {
//        [titleArr enumerateObjectsUsingBlock:^(WMZPageNaviBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self customBtn:btn];
//        }];
//    });
    self.param = param;
}

- (void)customBtn:(TFY_PageNavBtn*)btn{
    //闲置
     NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    //选中
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:self.param.menuTitleSelectColor range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
    
    NSArray *array = [btn.titleLabel.text componentsSeparatedByString:@"\n"];
    
     [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
     [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:[btn.titleLabel.text rangeOfString:array[0]]];
    
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x999999) range:[btn.titleLabel.text rangeOfString:array[0]]];
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:[btn.titleLabel.text rangeOfString:array[1]]];

    [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
}

//带富文本  wrapColor第二行标题  firstColor第一行标题
- (NSArray*)attributesData{
    return @[
        @{@"name":@"推荐\n10",@"wrapColor":[UIColor brownColor]},
        @"LOOK直播\n10",
        @{@"name":@"画\n10",@"badge":@(YES),@"wrapColor":[UIColor purpleColor]},
        @"现场\n10",
        @{@"name":@"翻唱\n10",@"wrapColor":[UIColor blueColor],@"firstColor":[UIColor cyanColor]},
        @"MV\n10",
        @{@"name":@"游戏\n10",@"badge":@(YES),@"wrapColor":[UIColor yellowColor]},
    ];
}

@end
