//
//  TFY_PageBaseController.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageBaseController : UIViewController<TFY_PageScrollProcotol>

@property (nonatomic, strong) TFY_PageBaseView *pageView;

@end

NS_ASSUME_NONNULL_END
