//
//  TFY_PageTitleModel.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageTitleModel : NSObject

@property(nonatomic,strong)UIViewController *_Nonnull controller;
//对应的下标
@property(nonatomic,assign)NSInteger index;
//对应的数据 字符串
@property(nonatomic,strong)NSString *_Nonnull title;
//对应的数据 字典 优先级高
@property(nonatomic,strong)NSDictionary *_Nonnull titleInfo;
//初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                        title:(NSString*_Nonnull)title;

//初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                    titleInfo:(NSDictionary*_Nonnull)titleInfo;

//初始化方法
- (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                        title:(NSString*_Nonnull)title;

//初始化方法
- (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                    titleInfo:(NSDictionary*_Nonnull)titleInfo;
@end

NS_ASSUME_NONNULL_END
