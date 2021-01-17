//
//  TFY_PageLoopView.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_ConfigProtocol.h"
#import "TFY_PageTableView.h"
#import "TFY_PageScrollerView.h"
#import "TFY_PageMunuView.h"

@class TFY_PageBaseController;

NS_ASSUME_NONNULL_BEGIN

@protocol PageLoopDelegate <NSObject>
@optional

//选中按钮
- (void)selectBtnWithIndex:(NSInteger)index;

//底部左滑的代理
- (void)pageWithScrollView:(UIScrollView*)scrollView left:(BOOL)left;

//底部左滑结束的代理
- (void)pageScrollEndWithScrollView:(UIScrollView*)scrollView;

//获取子tableview
- (void)setUpSuspension:(UIViewController*)newVC index:(NSInteger)index end:(BOOL)end;

@end

@interface TFY_PageLoopView : UIView

//下划线 此列属性和pageMenuView中的是同个
@property(nonatomic,strong)UIButton *lineView;
//标题按钮
@property(nonatomic,strong)NSMutableArray <TFY_PageNavBtn*>*btnArr;
//固定按钮
@property(nonatomic,strong)NSMutableArray <TFY_PageNavBtn*>*fixBtnArr;


//菜单视图
@property(nonatomic,strong)TFY_PageMunuView *mainView;
//底部视图
@property(nonatomic,strong)TFY_PageScrollerView *dataView;
//当前index
@property(nonatomic,assign)NSInteger currentTitleIndex;
//可能的下一个视图
@property(nonatomic,assign)NSInteger nextPageIndex;
//上一个视图
@property(nonatomic,assign)NSInteger lastPageIndex;
//是否已经处理了生命周期
@property(nonatomic,assign)BOOL hasDealAppearance;
//是否已经运行了完整的生命周期
@property(nonatomic,assign)BOOL hasEndAppearance;
//是否往相反方向滑动
@property(nonatomic,assign)BOOL hasDifferenrDirection;
//当前显示VC
@property(nonatomic,strong,nullable)UIViewController *currentVC;
//代理
@property(nonatomic,weak)id <PageLoopDelegate> loopDelegate;

//初始化
- (instancetype)initWithFrame:(CGRect)frame param:(TFY_PageParam*)param;

//标题动画和scrollview联动
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset;

//结束动画处理
- (void)endAninamal;

//找寻view的父控制器
- (nullable TFY_PageBaseController *)findBelongViewControllerForView:(UIView *)view;

//添加
- (void)addChildVC:(NSInteger)index VC:(UIViewController*)newVC;

@end

NS_ASSUME_NONNULL_END
