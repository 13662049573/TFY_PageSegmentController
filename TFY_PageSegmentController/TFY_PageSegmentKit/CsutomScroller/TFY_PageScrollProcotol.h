//
//  TFY_PageScrollProcotol.h
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageLoopView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TFY_PageScrollProcotol <UIScrollViewDelegate,PageLoopDelegate,UITableViewDelegate>
@optional
/// 导航栏透明视图
@property (nonatomic, weak) UIView *naviBarBackGround;
/// 头部视图
@property (nonatomic, strong) UIView *headView;
/// 头部视图block外部传入的视图
@property (nonatomic, strong) UIView *headViewSonView;
/// 底部全屏滚动视图
@property (nonatomic, strong, nullable) TFY_PageScroller *downSc;
/// 参数
@property (nonatomic, strong) TFY_PageParam *param;
/// 头部标题滚动视图
@property (nonatomic, strong) TFY_PageLoopView *upSc;
/// 缓存
@property (nonatomic, strong) NSMutableDictionary<NSNumber*, UIResponder*> *cache;
/// 子控制器中可以滚动的视图
@property (nonatomic, strong) NSMutableDictionary<NSNumber*,__kindof UIScrollView*> *sonChildScrollerViewDic;
/// 子控制器中固定底部的视图
@property (nonatomic, strong) NSMutableDictionary<NSNumber*,__kindof UIView*> *sonChildFooterViewDic;

///  更新全部(会全部重新渲染)
- (void)updatePageController;

///  更新头部
- (void)updateHeadView;

///  更新菜单栏和视图层
- (void)updateMenuData;

///  标题数量内容不变情况下 只更新标题 用于刷新头部数据 会重新初始化标题 属性不变 如果自定义了标题要重新设置一下
- (void)updateTitle;

///  底部手动滚动 传入CGPointZero则为吸顶临界点
///  point 滚动的坐标
///  animat 滚动动画
- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;

///  手动调用菜单到第index个
///  index 对应下标
- (void)selectMenuWithIndex:(NSInteger)index;

///⚠️使用动态的方法传入的控制器必须使用 wControllers
///  动态插入菜单数据
///  insertObject 插入对应model
- (BOOL)addMenuTitleWithObject:(TFY_PageTitleModel*)insertObject;

///  动态删除菜单数据
///  deleteObject 删除的对应下标 如@(1) 或者 传入的标题对象
- (BOOL)deleteMenuTitleIndex:(id)deleteObject;

///  动态插入菜单数组
///  insertArr 插入对应model的数组
- (BOOL)addMenuTitleWithObjectArr:(NSArray<TFY_PageTitleModel*>*)insertArr;

///  动态删除菜单数组
///  deleteArr @[ 如@(1) 或者 传入的标题对象]
- (BOOL)deleteMenuTitleIndexArr:(NSArray*)deleteArr;

///  动态交换菜单标题位置
///  index 需要交换的位置
///  replaceIndex 交换完的位置
- (BOOL)exchangeMenuDataAtIndex:(NSInteger)index withMenuDataAtIndex:(NSInteger)replaceIndex;

@end

NS_ASSUME_NONNULL_END
