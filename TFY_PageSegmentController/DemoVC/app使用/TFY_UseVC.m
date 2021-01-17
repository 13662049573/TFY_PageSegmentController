//
//  TFY_UseVC.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_UseVC.h"
#import "TFY_TestVC.h"

@interface TFY_UseVC ()

@end

@implementation TFY_UseVC

- (void)viewDidLoad {
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
       }
       TFY_PageParam *param = PageParam();
       switch (index) {
           //爱奇艺
           case 0:
           {
             param.titleArrSet(data)
            .viewControllerSet(^UIViewController *(NSInteger index) {
                TFY_TestVC *vc = [TFY_TestVC new];
                vc.page = index;
                return vc;
             })
             .menuDefaultIndexSet(3)
             .menuIndicatorYSet(5)
             .menuTitleUIFontSet([UIFont systemFontOfSize:17.0f])
             .menuTitleWeightSet(50)
             .menuTitleColorSet(PageColor(0xeeeeee))
             .menuTitleSelectColorSet(PageColor(0xffffff))
             .menuIndicatorColorSet(PageColor(0x00dea3))
             .menuIndicatorWidthSet(10.0f)
             .menuFixRightDataSet(@"≡")
             .menuAnimalTitleGradientSet(NO)
             .menuAnimalSet(PageTitleMenuAiQY);
           }
          break;
           //拼多多
           case 1:{
               param.titleArrSet(data)
               .viewControllerSet(^UIViewController *(NSInteger index) {
                   TFY_TestVC *vc = [TFY_TestVC new];
                    vc.page = index;
                    return vc;
                })
               .menuPositionSet(PageMenuPositionNavi)
               .menuAnimalTitleGradientSet(NO)
               .menuAnimalSet(PageTitleMenuPDD);
               }
          break;
         //今日头条
          case 2:{
               param.titleArrSet(data)
               .viewControllerSet(^UIViewController *(NSInteger index) {
                   TFY_TestVC *vc = [TFY_TestVC new];
                       vc.page = index;
                        return vc;
                })
               .menuFixRightDataSet(@"+")
               .menuAnimalSet(PageTitleMenuTouTiao);
           }
         break;
       //  京东
         case 3:{
             
             
               
               param.titleArrSet(data)
               .viewControllerSet(^UIViewController *(NSInteger index) {
                   TFY_TestVC *vc = [TFY_TestVC new];
                    vc.page = index;
                    return vc;
                })
               .menuTitleSelectColorSet(PageColor(0xFFFBF0))
               .menuBgColorSet(PageColor(0xff183b))
               .menuTitleColorSet(PageColor(0xffffff))
               .menuAnimalTitleGradientSet(NO)
               .menuIndicatorImageSet(@"E")
               .menuIndicatorHeightSet(15)
               .menuIndicatorWidthSet(20)
               .menuAnimalSet(PageTitleMenuLine);
           }
           break;
          //简书
           case 4:{
                     
           param.titleArrSet(data)
           .viewControllerSet(^UIViewController *(NSInteger index) {
               TFY_TestVC *vc = [TFY_TestVC new];
                vc.page = index;
                return vc;
            })
           .menuIndicatorColorSet(PageColor(0xfe6e5d))
           .menuTitleSelectColorSet(PageColor(0x333333))
           .menuTitleColorSet(PageColor(0x666666))
           .menuAnimalTitleGradientSet(NO)
           .menuFixRightDataSet(@{@"image":@"G"})
           .menuFixWidthSet(70)
           .menuFixShadowSet(NO)
           .menuIndicatorHeightSet(3)
           .menuTitleWeightSet(100)
           .menuIndicatorWidthSet(15)
           .menuAnimalSet(PageTitleMenuPDD);
           }
           break;
         case 5:{
             
           param.titleArrSet(data)
           .viewControllerSet(^UIViewController *(NSInteger index) {
               TFY_TestVC *vc = [TFY_TestVC new];
                vc.page = index;
                return vc;
            })
           .menuAnimalSet(PageTitleMenuAiQY)
           //菜单标题颜色
           .menuTitleColorSet(PageDarkColor(PageColor(0x333333), PageColor(0xffffff)))
           //菜单标题选中的颜色
           .menuTitleSelectColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
           //指示器颜色
           .menuIndicatorColorSet(PageDarkColor(PageColor(0xE5193E), [UIColor orangeColor]))
           //菜单背景颜色
           .menuBgColorSet(PageDarkColor(PageColor(0xffffff), PageColor(0x666666)));
             
             
           
         }
        break;
         default:
         break;
       }
    
       if (index == 1) {
           self.navigationItem.hidesBackButton = YES;
       }
       self.param = param;

       //更新
       if (index == 5) {
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               param
               .titleArrSet([self weiboData])
               .viewControllerSet(^UIViewController *(NSInteger index) {
                   TFY_TestVC *vc = [TFY_TestVC new];
                    vc.page = index;
                    return vc;
               });
               //更新
               [self updateMenuData];
           });
       }
       
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
       @"name":@"推荐",
       @"selectName":@"荐推",
       @"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)],
       @"width":@(50),
       @"marginX":@(10),
       @"height":@(55),
    },
    @{
       @"name":@"70年",
       @"backgroundColor":PageColor(0xd70022),
       @"indicatorColor":PageColor(0xfffcc6),
       @"titleSelectColor":PageColor(0xfffcc6),
     },
     @{
       @"name":@"VIP",
       @"backgroundColor":PageColor(0x3d4659),
       @"titleSelectColor":PageColor(0xe2c285),
       @"indicatorColor":PageColor(0xe2c285),
       @"titleSelectColor":PageColor(0x9297a5)
     },
     @{@"name":@"热点",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电视剧",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"电影",@"backgroundColor":PageColor(0x007e80)},
     @{@"name":@"儿童",@"backgroundColor":@[PageColor(0x15314b),PageColor(0x009a93)]},
     @{@"name":@"游戏",@"backgroundColor":PageColor(0x1c2c3b)},
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
        @{@"name":@"关注",@"badge":@(YES)},
        @{@"name":@"推荐",@"badge":@(YES)},@"广州",
        @{@"name":@"热点",@"badge":@(YES)},
        @"视频",@{@"name":@"图片",@"badge":@(YES)},@"问答",@"科技",
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
微博内容 @"onlyClick":@(YES) 仅点击不加载页面
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
      @{@"image":@"F"},
      @"榜单",
      @"5G",
      @"抽奖",
      @"新时代",
      @{@"name":@"哈哈",@"selectImage":@"D"},
      @"电竞",
      @"明星"];
}

- (NSArray*)JSData{
    return @[@"推荐",@"小岛",@"专题",@"连载"];
}

@end
