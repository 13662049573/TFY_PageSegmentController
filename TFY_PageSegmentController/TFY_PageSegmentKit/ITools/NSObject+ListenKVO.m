//
//  NSObject+ListenKVO.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "NSObject+ListenKVO.h"

@implementation NSObject (ListenKVO)

- (void)pageAddObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    if (![self hasKey:keyPath withObserver:observer]) {
        [self addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)paegRemoveObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)context {
    if ([self hasKey:keyPath withObserver:observer]) {
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
}

- (void)removeAllObserverdKeyPath:(NSObject*)VC withKey:(NSString*)key{
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    NSArray *objArr = [info valueForKeyPath:@"_observances._observer"];
    if (arr) {
        for (int i = 0; i<arr.count; i++) {
            NSString *keyPath = arr[i];
            NSObject *obj = objArr[i];
            if ([keyPath isEqualToString:key]&&obj == VC) {
                [self removeObserver:VC forKeyPath:keyPath context:nil];
            }
        }
    }
    
}

- (BOOL)hasKey:(NSString *)kvoKey withObserver:(nonnull NSObject *)observer {
    BOOL hasKey = NO;
    id info = self.observationInfo;
    NSArray *arr = [info valueForKeyPath:@"_observances._property._keyPath"];
    NSArray *objArr = [info valueForKeyPath:@"_observances._observer"];
       if (arr) {
           for (int i = 0; i<arr.count; i++) {
               NSString *keyPath = arr[i];
               NSObject *obj = objArr[i];
               if ([keyPath isEqualToString:kvoKey]&&obj == observer) {
                   hasKey = YES;
                   break;
               }
           }
       }
    return hasKey;
}

@end


@implementation UIView (PageRect)

- (void)page_y:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)page_x:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)page_width:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)page_height:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

@end
