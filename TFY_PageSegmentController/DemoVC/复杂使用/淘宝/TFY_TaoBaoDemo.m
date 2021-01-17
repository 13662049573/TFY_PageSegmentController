//
//  TFY_TaoBaoDemo.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_TaoBaoDemo.h"
#import "TFY_CollectionViewPop.h"

@interface TFY_TaoBaoDemo ()

@end

@implementation TFY_TaoBaoDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题数组
       __weak TFY_TaoBaoDemo *weakSelf = self;
       NSArray *data = @[@"全部\n猜你喜欢",@"直播\n新品搭配购",@"便宜好货\n低价抢购",@"买家秀\n真实晒单"];
       TFY_PageParam *param =
       PageParam()
       .titleArrSet(data)
       .viewControllerSet(^UIViewController *(NSInteger index) {
          return [TFY_CollectionViewPop new];
        })
       .menuHeightSet(80)
       //⚠️此为改变菜单栏高度的属性  传入正数为高度减少的数值 负数为高度增加的数值
       .topChangeHeightSet(20)
       //悬浮开启
       .topSuspensionSet(YES)
       .menuIndicatorColorSet([UIColor orangeColor])
       .menuAnimalSet(PageTitleMenuAiQY)
       .menuTitleWidthSet(self.view.frame.size.width / 4)
       //顶部可下拉
       .bouncesSet(YES)
       .menuAnimalTitleGradientSet(NO)
       //头视图y坐标从0开始
       .fromNaviSet(NO)
       .naviAlphaSet(YES)
       //头部
       .menuHeadViewSet(^UIView *{
           UIView *back = [UIView new];
           back.frame = CGRectMake(0, 0, PageVCWidth, 300);
           UIImageView *image = [UIImageView new];
           [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
           image.frame =back.bounds;
           [back addSubview:image];
           return back;
       })
        //自定义常态富文本
        .customMenuTitleSet(^(NSArray *titleArr) {
             __strong TFY_TaoBaoDemo *strongSelf = weakSelf;
            [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
                [strongSelf customBtn:btn];
            }];
        })
        //⚠️自定义改变高度的UI变化
       .eventMenuChangeHeightSet(^(NSArray<TFY_PageNavBtn *> *titleArr, CGFloat offset) {
            __strong TFY_TaoBaoDemo *strongSelf = weakSelf;
           if (offset >= 20) {
               [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   [strongSelf changeBtn:obj];
               }];
               [strongSelf.upScHerder.lineView setHidden:NO];
           }
        })
        //⚠️自定义恢复高度的UI变化
       .eventMenuNormalHeightSet(^(NSArray<TFY_PageNavBtn *> *titleArr) {
            __strong TFY_TaoBaoDemo *strongSelf = weakSelf;
           [titleArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               [strongSelf customBtn:obj];
           }];
           [strongSelf.upScHerder.lineView setHidden:YES];
       });
       self.param = param;
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           self.upScHerder.lineView.hidden = YES;
       });
}

//正常富文本
- (void)customBtn:(TFY_PageNavBtn*)btn{
    //闲置
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.normalText];
    //选中
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.normalText];
    NSArray *array = [btn.normalText componentsSeparatedByString:@"\n"];
      
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[btn.normalText rangeOfString:btn.normalText]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[btn.normalText rangeOfString:array[0]]];
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x333333) range:[btn.normalText rangeOfString:array[0]]];
    [mStr addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:[btn.normalText rangeOfString:btn.normalText]];
    
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[btn.normalText rangeOfString:array[0]]];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[btn.normalText rangeOfString:array[0]]];
    
    if (!btn.attributedSelectImage) {
        btn.attributedSelectImage = [btn setImageWithStr:array[1] font:[UIFont boldSystemFontOfSize:15.0f] textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] height:18.0f backgroundColor:[UIColor orangeColor] cornerRadius:9];
    }
    if (!btn.attributedImage) {
        btn.attributedImage = [btn setImageWithStr:array[1] font:[UIFont boldSystemFontOfSize:15.0f] textAlignment:NSTextAlignmentCenter textColor:PageColor(0x333333) height:18.0f backgroundColor:nil cornerRadius:0];
    }
    
    [mStr replaceCharactersInRange:[btn.normalText rangeOfString:array[1]] withAttributedString:btn.attributedImage];
    [mSelectStr replaceCharactersInRange:[btn.normalText rangeOfString:array[1]] withAttributedString:btn.attributedSelectImage];
    [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
    
}

//改变高度富文本
- (void)changeBtn:(TFY_PageNavBtn*)btn{
    NSArray *array = [btn.normalText componentsSeparatedByString:@"\n"];
    NSString *str = [NSString stringWithFormat:@"%@\n%@",array[0],@" "];
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:[str rangeOfString:str]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[str rangeOfString:str]];
    [mSelectStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:20] range:[str rangeOfString:str]];
    [mStr addAttribute:NSForegroundColorAttributeName value:PageColor(0x333333) range:[str rangeOfString:str]];
    [mSelectStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[str rangeOfString:str]];
    [mStr addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:[str rangeOfString:str]];
    [btn setAttributedTitle:mStr forState:UIControlStateNormal];
    [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];
}

@end
