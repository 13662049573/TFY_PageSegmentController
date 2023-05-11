//
//  TFY_PageDataView.h
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageDataView : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) BOOL left;

@property (nonatomic, assign) CGFloat pageWidth;
/// 触发侧滑手势
@property (nonatomic, assign) CGFloat popGuestureOffset;
/// respondGuestureType为All时候的响应位置
@property (nonatomic, assign) int globalTriggerOffset;
///响应侧滑/全屏手势
@property (nonatomic, assign) PagePopType respondGuestureType;

@end

NS_ASSUME_NONNULL_END
