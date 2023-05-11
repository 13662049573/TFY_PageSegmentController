//
//  TFY_PageTitleModel.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageTitleModel : NSObject

/// 对应的控制器
@property (nonatomic, strong, nonnull) UIResponder *controller;
/// 对应的下标
@property (nonatomic, assign) NSInteger index;
/// 对应的数据 字符串
@property (nonatomic, strong) NSString *title;
/// 对应的数据 字典 优先级高
@property (nonatomic, strong) NSDictionary <TFY_PageBTNKey,id>*titleInfo;

/// 初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                        title:(NSString*)title;
/// 初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                    titleInfo:(NSDictionary*)titleInfo;
/// 初始化方法
- (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                        title:(NSString*)title;
/// 初始化方法
- (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                    titleInfo:(NSDictionary*)titleInfo;
@end

NS_ASSUME_NONNULL_END
