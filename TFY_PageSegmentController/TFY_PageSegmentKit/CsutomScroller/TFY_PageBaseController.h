//
//  TFY_PageBaseController.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageLoopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageBaseController : UIViewController<UIScrollViewDelegate,PageLoopDelegate,UITableViewDelegate>
//参数
@property(nonatomic,strong)TFY_PageParam *param;
//头部标题滚动视图
@property(nonatomic,strong)TFY_PageLoopView *upScHerder;
//底部全屏滚动视图
@property(nonatomic,strong,nullable)TFY_PageTableView *tableView;
//缓存
@property(nonatomic,strong)NSMutableDictionary *cache;
//子控制器中可以滚动的视图
@property(nonatomic,strong)NSMutableDictionary *sonChildScrollerViewDic;
//子控制器中固定底部的视图
@property(nonatomic,strong)NSMutableDictionary *sonChildFooterViewDic;
//子控制器固定底部如果不是位于最左边  可设置此属性 默认为0
@property(nonatomic,assign)CGFloat footViewOrginX;
//子控制器固定底部宽度如果不是整个屏幕  可设置此属性 默认为底部滚动视图的宽度
@property(nonatomic,assign)CGFloat footViewSizeWidth;
//子控制器固定底部y值 default 最底部-height
@property(nonatomic,assign)CGFloat footViewOrginY;
//透明视图
@property (nonatomic, strong) UIView *naviBarBackGround;
/**
 更新全部(会全部重新渲染)
*/
- (void)updatePageController;

/**
 更新头部
*/
- (void)updateHeadView;

/**
 更新菜单栏
*/
- (void)updateMenuData;

/**
 标题数量内容不变情况下只更新内容
*/
- (void)updateTitle;

/**
 底部手动滚动 传入CGPointZero则为吸顶临界点
 point 滚动的坐标
 animat 滚动动画
*/
- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;

/**
 手动调用菜单到第index个
 index 对应下标
*/
- (void)selectMenuWithIndex:(NSInteger)index;

/**
 动态插入菜单数据
 insertObject 插入对应model
*/
- (BOOL)addMenuTitleWithObject:(TFY_PageTitleModel*)insertObject;

/**
 动态删除菜单数据
 deleteObject 删除的对应下标 如@(1) 或者 传入的标题对象
*/
- (BOOL)deleteMenuTitleIndex:(id)deleteObject;


/**
 动态插入菜单数组
 insertArr 插入对应model的数组
*/
- (BOOL)addMenuTitleWithObjectArr:(NSArray<TFY_PageTitleModel*>*)insertArr;

/**
 动态删除菜单数组
 deleteArr @[ 如@(1) 或者 传入的标题对象]
*/
- (BOOL)deleteMenuTitleIndexArr:(NSArray*)deleteArr;

@end

NS_ASSUME_NONNULL_END
