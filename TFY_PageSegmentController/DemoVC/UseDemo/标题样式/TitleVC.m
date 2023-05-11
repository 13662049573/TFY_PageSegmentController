


//
//  TitleVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2019/10/10.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TitleVC.h"
#import "TestVC.h"
#import "UIButton+WebCache.h"
@implementation TitleVC


- (void)viewDidLoad{
    [super viewDidLoad];
    
      NSInteger index = self.index.integerValue; 
    
     //数据
        NSDictionary *dic = @{
              @(0):@"redTipData",
              @(1):@"imageData",
              @(2):@"imageData",
              @(3):@"textData",
              @(4):@"fixData",
              @(5):@"textData",
              @(6):@"textData",
              @(7):@"fixData",
          };
        //位置
        NSDictionary *position = @{
              @(0):@(PageMenuPositionLeft),
              @(1):@(PageMenuPositionLeft),
              @(2):@(PageMenuPositionBottom),
              @(3):@(PageMenuPositionNavi),
              @(4):@(PageMenuPositionCenter),
              @(5):@(PageMenuPositionLeft),
              @(6):@(PageMenuPositionLeft),
              @(7):@(PageMenuPositionLeft),
          };
        NSArray *data = [self performSelector:NSSelectorFromString(dic[@(index)]) withObject:nil];
        TFY_PageParam *param =
        PageParam()
        .TitleArrSet(data)
        .ViewControllerSet(^UIViewController *(NSInteger index) {
            TestVC *vc = [TestVC new];
            vc.page = index;
            return vc;
        })
        .CustomMenuViewSet(^(UIView *bgView) {
    //        bgView.alpha = 0.5;
        })
        .MenuWidthSet(PageVCWidth)
        .MenuDefaultIndexSet(1)
       //自定义红点 调整颜色 位置等
       .CustomRedViewSet(^(UILabel *redLa,NSDictionary *info) {

        })
        .MenuPositionSet([position[@(index)] intValue]);
        /// 右侧标题
        if (index == 5) {
            param.MenuFixRightDataSet(@"≡");
        }
    
        /// 右侧图文标题
        if (index == 6) {
            param.MenuImagePositionSet(PageBtnPositionLeft)
                 .MenuFixRightDataSet(@{TFY_PageKeyName:@"金币",TFY_PageKeyImage:@"B"})
            .EventFixedClickSet(^(id anyID, NSInteger index) {
                NSLog(@"固定标题点击%ld",(long)index);
                //模拟更新
                [self.upSc.btnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.tag == 10086) {
                        [obj setTitle:@"更新" forState:UIControlStateNormal];
                        *stop = YES;
                    }
                }];
            });
        }
    
        /// 固定标题宽度
        if (index == 7) {
            param.MenuTitleWidthSet(PageVCWidth/3);
        }

        self.param = param;
}


- (void)action{
    
}

//普通标题
- (NSArray*)textData{
    return @[@"推荐",@"LOOK直播",@"画",@"现场",@"翻唱",@"MV",@"广场",@"游戏"];
}

//带红点普通标题   badge红点   
- (NSArray*)redTipData{
    return @[
        @{TFY_PageKeyName:@"推荐",TFY_PageKeyBadge:@(10)},
        @"LOOK直播",
        @{TFY_PageKeyName:@"翻唱",TFY_PageKeyBadge:@"99+"},
        @"MV",
        @"广场",
        @{TFY_PageKeyName:@"游戏",TFY_PageKeyBadge:@(-1)},
    ];
}

//图片  image图片  selectImage选中图片
- (NSArray*)imageData{
    return @[
        @{TFY_PageKeyName:@"推荐",TFY_PageKeyImage:@"B",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"LOOK直播",TFY_PageKeyImage:@"C",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"画",TFY_PageKeyImage:@"B",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"现场",TFY_PageKeyImage:@"C",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"翻唱",TFY_PageKeyBadge:@(9),TFY_PageKeyImage:@"B",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"MV",TFY_PageKeyImage:@"C",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"游戏",TFY_PageKeyBadge:@(-1),TFY_PageKeyImage:@"B",TFY_PageKeySelectImage:@"D"},
        @{TFY_PageKeyName:@"广场",TFY_PageKeyImage:@"C",TFY_PageKeySelectImage:@"D"},
    ];
}
//固定宽度标题
- (NSArray*)fixData{
    return @[@"推荐",@"热点",@"关注"];
}

@end
