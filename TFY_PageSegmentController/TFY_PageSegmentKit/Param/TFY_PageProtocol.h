//
//  TFY_PageProtocol.h
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TFY_PageProtocol <NSObject>

/// 悬浮 可滑动的滚动视图
- (UIScrollView*)getMyScrollView;
/// 悬浮 数组 可滚动视图的数组 适用底部多个scrollView的情况
- (NSArray <UIScrollView*>*)getMyScrollViews;

/// 子控制器需要固定的尾部视图
- (UIView*)fixFooterView;

/// 生命周期 和VC的生命周期用法一致
- (void)pageViewWillAppear;

- (void)pageViewWillDisappear;

- (void)pageViewDidAppear;

- (void)pageViewDidDisappear;

@end

NS_ASSUME_NONNULL_END
