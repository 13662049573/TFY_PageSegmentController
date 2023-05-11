//
//  TFY_PageMunuView.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageNavBtn.h"

@protocol PageMunuDelegate <NSObject>
@optional
//标题点击
- (void)titleClick:(TFY_PageNavBtn*_Nonnull)btn fix:(BOOL)fixBtn;
@end

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageMunuView : UIScrollView
/// 当前index
@property (nonatomic, assign) NSInteger currentTitleIndex;
/// 配置
@property (nonatomic, strong) TFY_PageParam *param;
/// 下划线
@property (nonatomic, strong) TFY_PageNavBtn *lineView;
/// 下划线
@property (nonatomic, strong) UIView *containView;
/// 标题按钮
@property (nonatomic, strong) NSMutableArray <TFY_PageNavBtn*>*btnArr;
/// 固定按钮
@property (nonatomic, strong) NSMutableArray <TFY_PageNavBtn*>*fixBtnArr;
/// 代理
@property (nonatomic, weak) id <PageMunuDelegate> menuDelegate;
/// 上次选中左侧标题
@property (nonatomic, strong, nullable) TFY_PageNavBtn *lastBTN;
/// 上次选中右侧固定标题
@property (nonatomic, strong, nullable) TFY_PageNavBtn *fixLastBtn;
/// 最底部下划线
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) CGFloat pageWidth;
/// 滚动到index
/// @param animal 带动画
- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal;
/// 设置默认选中
- (void)setDefaultSelect:(NSInteger)index;
/// 获取菜单高度
- (CGFloat)getMainHeight;
/// 设置标题
- (void)setPropertiesWithBtn:(TFY_PageNavBtn*)btn withIndex:(NSInteger)i  withTemp:(TFY_PageNavBtn*)temp;
/// 重置contensize
- (void)resetMainViewContenSize:(TFY_PageNavBtn*)btn;
/// updateUI
- (void)updateUI;
/// 动画管理
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset;
/// 设置右边固定标题
- (void)setUpFixRightBtn:(TFY_PageNavBtn*)temp;

@end

NS_ASSUME_NONNULL_END
