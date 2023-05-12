//
//  WMZDemoTwo.m
//  TFY_PageBaseController
//
//  Created by wmz on 2020/7/7.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZDemoTwo.h"
#import "topSuspensionVC.h"
@interface WMZDemoTwo ()

@end

@implementation WMZDemoTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    TFY_PageParam *param = PageParam()
    .menuTitleSelectColorSet([UIColor redColor])
    .titleArrSet([self attributesData])
    .menuTitleWidthSet(PageVCWidth/4)
    .menuCellMarginYSet(10)
    .menuCircilRadioSet(20)
    .hideRedCircleSet(NO)
    .menuAnimalSet(PageTitleMenuCircle);
    param.viewController = ^UIViewController * _Nullable(NSInteger index) {
        return [topSuspensionVC new];
    };
    //也可以此处自定义富文本
    param.customMenuTitle = ^(NSArray<TFY_PageNavBtn *> * _Nullable titleArr) {
        
    };
    //自定义滑动后标题的变化 如有需要
    param.customMenuSelectTitle = ^(NSArray<TFY_PageNavBtn *> * _Nullable titleArr) {
        
    };
    
    self.param = param;
}

- (NSMutableAttributedString*)getNormalStr:(NSString*)str{
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[str rangeOfString:str]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:[str rangeOfString:array[0]]];
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x999999) range:[str rangeOfString:array[0]]];
    return mStr;
}

- (NSMutableAttributedString*)getSelectStr:(NSString*)str{
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[str rangeOfString:str]];
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0f] range:[str rangeOfString:array[1]]];
    return mSelectStr;
}

//带富文本
- (NSArray*)attributesData{
    return @[
        @{TFY_PageKeyName:[self getNormalStr:@"推荐1\n10"],TFY_PageKeySelectName:[self getSelectStr:@"推荐1\n10"]},
        @"LOOK直播\n10",
        @{TFY_PageKeyName:[self getNormalStr:@"画\n10"],TFY_PageKeyBadge:@(-1)},
        @"现场\n10",
        @{TFY_PageKeyName:@"翻唱\n10"},
        [self getNormalStr:@"推荐\n10"],
        @{TFY_PageKeyName:[self getNormalStr:@"推荐\n10"],TFY_PageKeySelectName:[self getSelectStr:@"推荐\n10"],TFY_PageKeyBadge:@(-1)},
    ];
}

@end
