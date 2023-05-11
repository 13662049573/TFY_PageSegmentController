

//
//  UseVC.m
//  TFY_PageBaseController
//
//  Created by TFY_ on 2019/10/10.
//  Copyright © 2019 TFY_. All rights reserved.
//

#import "UseVC.h"
#import "TestVC.h"
@interface UseVC ()

@end

@implementation UseVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSInteger index = self.index.integerValue;
    
    //标题数组
       NSArray *data = @[];
       if (index == 0) {
           data = [self AQYData];
       }else if(index == 1){
           data = [self PDDData];
       }else if(index == 2){
           data = [self ToutiaoData];
       }else if(index == 3){
           data = [self JDData];
       }else if(index == 4){
           data = [self JSData];
       }else if(index == 5){
           data = [self PDDData];
       }else if(index == 6){
           data = [self PDDData];
       }else{
           data = [self PDDData];
       }
       TFY_PageParam *param = PageParam();
       switch (index) {
           //爱奇艺
           case 0:
           {
             param.TitleArrSet(data)
            .ViewControllerSet(^UIViewController *(NSInteger index) {
                TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
             })
             .MenuDefaultIndexSet(3)
             .MenuIndicatorYSet(5)
             .MenuTitleUIFontSet([UIFont systemFontOfSize:17.0f])
             .MenuTitleWeightSet(50)
             .MenuTitleColorSet(PageColor(0xeeeeee))
             .MenuTitleSelectColorSet(PageColor(0xffffff))
             .MenuIndicatorColorSet(PageColor(0x00dea3))
             .MenuIndicatorWidthSet(10.0f)
             .MenuFixRightDataSet(@"≡")
             .MenuAnimalTitleGradientSet(NO)
             .MenuAnimalSet(PageTitleMenuAiQY);
           }
          break;
           //拼多多
           case 1:{
               param.TitleArrSet(data)
               .ViewControllerSet(^UIViewController *(NSInteger index) {
                    TestVC *vc = [TestVC new];
                    vc.page = index;
                    return vc;
                })
               .MenuPositionSet(PageMenuPositionNavi)
               .MenuAnimalTitleGradientSet(NO)
               .MenuAnimalSet(PageTitleMenuPDD);
               }
          break;
         //今日头条
          case 2:{
               param.TitleArrSet(data)
               .ViewControllerSet(^UIViewController *(NSInteger index) {
                       TestVC *vc = [TestVC new];
                       vc.page = index;
                        return vc;
                })
               .MenuFixRightDataSet(@"+")
               .MenuAnimalSet(PageTitleMenuTouTiao);
           }
         break;
       //  京东
         case 3:{
             
             
               
               param.TitleArrSet(data)
               .ViewControllerSet(^UIViewController *(NSInteger index) {
                   TestVC *vc = [TestVC new];
                    vc.page = index;
                    return vc;
                })
               .MenuTitleSelectColorSet(PageColor(0xFFFBF0))
               .MenuBgColorSet(PageColor(0xff183b))
               .MenuTitleColorSet(PageColor(0xffffff))
               .MenuAnimalTitleGradientSet(NO)
               .MenuIndicatorImageSet(@"E")
               .MenuIndicatorHeightSet(15)
               .MenuIndicatorWidthSet(20)
               .MenuAnimalSet(PageTitleMenuLine);
           }
           break;
          //简书
           case 4:{
                     
           param.TitleArrSet(data)
           .ViewControllerSet(^UIViewController *(NSInteger index) {
               TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
            })
           .MenuIndicatorColorSet(PageColor(0xfe6e5d))
           .MenuTitleSelectColorSet(PageColor(0x333333))
           .MenuTitleColorSet(PageColor(0x666666))
           .MenuAnimalTitleGradientSet(NO)
           .MenuFixRightDataSet(@{TFY_PageKeyImage:@"G"})
           .MenuFixWidthSet(70)
           .MenuFixShadowSet(NO)
           .MenuIndicatorHeightSet(3)
           .MenuTitleWeightSet(100)
           .MenuIndicatorWidthSet(15)
           .MenuAnimalSet(PageTitleMenuPDD);
           }
           break;
           case 5:{
             param.TitleArrSet(data)
             .ViewControllerSet(^UIViewController *(NSInteger index) {
                 TestVC *vc = [TestVC new];
                  vc.page = index;
                  return vc;
              })
             .MenuAnimalSet(PageTitleMenuCircle);
           }
          break;
         case 6:{
           param.TitleArrSet(data)
           .ViewControllerSet(^UIViewController *(NSInteger index) {
               TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
            })
           .MenuAnimalSet(PageTitleMenuAiQY)
           //菜单标题颜色
           .MenuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
           //菜单标题选中的颜色
           .MenuTitleSelectColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
           //指示器颜色
           .MenuIndicatorColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
           //菜单背景颜色
           .MenuBgColorSet(PageDarkColor(PageColor(0xffffff), PageColor(0x666666)));
         }
        break;
        //新爱奇艺
        case 7:
        {
            param.TitleArrSet(data)
            .ViewControllerSet(^UIViewController *(NSInteger index) {
               TestVC *vc = [TestVC new];
                vc.page = index;
                return vc;
            })
            .MenuIndicatorWidthSet(17)
            .MenuIndicatorHeightSet(4)
            .MenuIndicatorYSet(5)
            .MenuAnimalSet(PageTitleMenuNewAiQY);
            break;
        }
        //新京东
        case 8:
        {
           param.TitleArrSet(data)
            /// 自定义jdlayer的frame
           .EventCustomJDAnimalSet(^(TFY_PageNavBtn * _Nullable sender, UIView * _Nullable jdLayer) {
               jdLayer.frame = CGRectMake(CGRectGetWidth(sender.frame) - 20, CGRectGetHeight(sender.frame) - 20, 13, 8);
            })
           .ViewControllerSet(^UIViewController *(NSInteger index) {
              TestVC *vc = [TestVC new];
               vc.page = index;
               return vc;
           })
           .MenuIndicatorColorSet(UIColor.orangeColor)
           .MenuAnimalSet(PageTitleMenuJD);
           break;
        }
         default:
         break;
       }
    
       if (index == 1) {
           self.navigationItem.hidesBackButton = YES;
       }
       self.param = param;
       
}
/*爱奇艺标题
  (滚动完改变颜色)
  name           标题
  selectName     选中后的标题
  indicatorColor 指示器颜色
  titleSelectColor 选中字体颜色
  titleColor 未选中字体颜色
  backgroundColor 选中背景颜色 (如果是数组则是背景色渐变色)
 */
- (NSArray*)AQYData{
    return @[
    @{
       TFY_PageKeyName:@"推荐",
       TFY_PageKeySelectName:@"荐推",
       TFY_PageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)],
       TFY_PageKeyTitleWidth:@(50),
       TFY_PageKeyTitleMarginX:@(10),
       TFY_PageKeyTitleHeight:@(55),
    },
    @{
       TFY_PageKeyName:@"70年",
       TFY_PageKeyBackgroundColor:PageColor(0xd70022),
       TFY_PageKeyIndicatorColor:PageColor(0xfffcc6),
       TFY_PageKeyTitleSelectColor:PageColor(0xfffcc6),
     },
     @{
       TFY_PageKeyName:@"VIP",
       TFY_PageKeyBackgroundColor:PageColor(0x3d4659),
       TFY_PageKeyTitleSelectColor:PageColor(0xe2c285),
       TFY_PageKeyIndicatorColor:PageColor(0xe2c285),
       TFY_PageKeyTitleSelectColor:PageColor(0x9297a5)
     },
     @{TFY_PageKeyName:@"热点",TFY_PageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{TFY_PageKeyName:@"电视剧",TFY_PageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{TFY_PageKeyName:@"电影",TFY_PageKeyBackgroundColor:PageColor(0x007e80)},
     @{TFY_PageKeyName:@"儿童",TFY_PageKeyBackgroundColor:@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{TFY_PageKeyName:@"游戏",TFY_PageKeyBackgroundColor:PageColor(0x1c2c3b)},
    ];
}



/*
 拼多多标题
 */
- (NSArray*)PDDData{
    return
    @[@"热门",@"男装",@"美妆",@"手机",@"食品",@"电器",@"鞋包",@"百货",@"女装",@"汽车",@"电脑"];
}


/*
 今日头条标题
 badge   红点提示
 */
- (NSArray*)ToutiaoData{
    return
    @[
        @{TFY_PageKeyName:@"关注",TFY_PageKeyBadge:@(-1)},
        @{TFY_PageKeyName:@"推荐",TFY_PageKeyBadge:@(-1)},@"广州",
        @{TFY_PageKeyName:@"热点",TFY_PageKeyBadge:@(-1)},
        @"视频",@{TFY_PageKeyName:@"图片",TFY_PageKeyBadge:@(-1)},@"问答",@"科技",
    ];
}


/*
微博
*/
- (NSArray*)weiboTitleData{
    return
    @[@"关注",@"热门"];
}

/*
微博内容 TFY_PageKeyOnlyClick:@(YES) 仅点击不加载页面
*/
- (NSArray*)weiboData{
    return
    @[@"推荐",@"同城",@"榜单",@"5G",@"抽奖",@"新时代",@"广州",@"电竞",@"明星"];
}

/*
京东内容
image 图片
selectImage 选中图片
*/
- (NSArray*)JDData{
    return
    @[
      @"推荐",
      @{TFY_PageKeyImage:@"F"},
      @"榜单",
      @"5G",
      @"抽奖",
      @"新时代",
      @{TFY_PageKeyName:@"哈哈",TFY_PageKeySelectImage:@"D"},
      @"电竞",
      @"明星"];
}

- (NSArray*)JSData{
    return @[@"推荐",@"小岛",@"专题",@"连载"];
}
@end
