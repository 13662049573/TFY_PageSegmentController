//
//  NSObject+ListenKVO.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ListenKVO)
/**
  移除所有观察的keypath
 */
- (void)removeAllObserverdKeyPath:(NSObject*_Nonnull)VC withKey:(NSString*_Nonnull)key;
/**
 安全增加观察者
*/
- (void)pageAddObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
/**
 安全删除观察者
*/
- (void)paegRemoveObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)context;

@end


@interface UIView (PageRect)

- (void)page_y:(CGFloat)y;
- (void)page_x:(CGFloat)y;
- (void)page_width:(CGFloat)width;
- (void)page_height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
