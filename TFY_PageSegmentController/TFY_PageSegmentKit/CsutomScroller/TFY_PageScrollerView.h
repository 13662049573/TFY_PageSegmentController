//
//  TFY_PageScrollerView.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageScrollerView : UIScrollView
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)NSInteger lastIndex;
@property(nonatomic,assign)NSInteger totalCount;
@property(nonatomic,assign)NSInteger level;
@property(nonatomic,assign)BOOL left;
@end

NS_ASSUME_NONNULL_END
