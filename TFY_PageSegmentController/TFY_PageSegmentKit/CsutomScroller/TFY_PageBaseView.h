//
//  TFY_PageBaseView.h
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageScrollProcotol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageBaseView : UIView<TFY_PageScrollProcotol>

/// 响应父类
@property (nonatomic, weak, readonly) UIResponder *parentResponder;
/// 私有方法 不可调用
- (void)setUpUI:(BOOL)clear;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                        param:(TFY_PageParam*)param
               parentReponder:(UIResponder*)parentReponder;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                        param:(TFY_PageParam*)param
               parentReponder:(UIResponder*)parentReponder;

/// 初始化 仅供兼容TFY_PageBaseController类调用
- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                       source:(BOOL)pageController
                        param:(TFY_PageParam*)param
               parentReponder:(UIResponder*)parentReponder;

@end

NS_ASSUME_NONNULL_END
