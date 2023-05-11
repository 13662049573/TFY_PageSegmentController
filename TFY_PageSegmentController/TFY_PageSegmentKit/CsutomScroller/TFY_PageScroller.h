//
//  TFY_PageScroller.h
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageConfig.h"
#import "TFY_PageParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageScroller : UITableView<UIGestureRecognizerDelegate>

/// 能否滚动
@property (nonatomic, assign) BOOL canScroll;
/// 当前滚动子视图
@property (nonatomic, strong) UIScrollView* currentScroll;
/// 子视图能否滚动
@property (nonatomic, assign) BOOL sonCanScroll;
/// param
@property (nonatomic, strong) TFY_PageParam *param;

@end

NS_ASSUME_NONNULL_END
