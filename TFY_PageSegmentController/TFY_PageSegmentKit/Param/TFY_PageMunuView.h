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
//当前index
@property(nonatomic,assign)NSInteger currentTitleIndex;
//配置
@property(nonatomic,strong)TFY_PageParam *_Nonnull param;
//下划线
@property(nonatomic,strong)UIButton *_Nonnull lineView;
//标题按钮
@property(nonatomic,strong)NSMutableArray <TFY_PageNavBtn*>* _Nonnull btnArr;
//固定按钮
@property(nonatomic,strong)NSMutableArray <TFY_PageNavBtn*>* _Nonnull fixBtnArr;
//代理
@property(nonatomic,weak)id <PageMunuDelegate> _Nullable menuDelegate;
//滚动到index
- (void)scrollToIndex:(NSInteger)newIndex;
- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal;
- (CGFloat)getMainHeight;
- (void)setPropertiesWithBtn:(TFY_PageNavBtn*_Nonnull)btn withIndex:(NSInteger)index  withTemp:(TFY_PageNavBtn*_Nonnull)temp;
- (void)resetMainViewContenSize:(TFY_PageNavBtn*_Nonnull)btn;

@end

NS_ASSUME_NONNULL_END
