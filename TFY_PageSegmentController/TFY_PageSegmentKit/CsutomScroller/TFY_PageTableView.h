//
//  TFY_PageTableView.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageTableView : UITableView<UIGestureRecognizerDelegate>
@property(nonatomic,assign)CGFloat menuTitleHeight;
@property(nonatomic,assign)BOOL canScroll;
@property(nonatomic,assign)BOOL fromNavi;
@end

NS_ASSUME_NONNULL_END
