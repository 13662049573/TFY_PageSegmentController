//
//  TFY_PageScroller.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageScroller.h"
#import "TFY_PageConfig.h"
#import "TFY_PageDataView.h"

@implementation TFY_PageScroller

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.sectionHeaderHeight = 0;
        self.estimatedRowHeight = 100;
        self.sectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            self.estimatedSectionFooterHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            self.automaticallyAdjustsScrollIndicatorInsets = false;
        }
       #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 150000
        if (@available(iOS 15.0, *)) {
            self.sectionHeaderTopPadding = 0;
        }
       #endif
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.param.customSimultaneouslyGesture) return self.param.customSimultaneouslyGesture(gestureRecognizer, otherGestureRecognizer);
    if (([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"TFY_PageDataView"] ||
         [NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UIScrollView"]) &&
        [NSStringFromClass([otherGestureRecognizer class]) isEqualToString:@"UIScrollViewPanGestureRecognizer"]){
        return NO;
    }
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UILayoutContainerView"] &&
        [NSStringFromClass([otherGestureRecognizer class]) isEqualToString:@"_UIParallaxTransitionPanGestureRecognizer"]) {
        return NO;
    }
    if([self.param.stopSimultaneouslyClassNameArray isKindOfClass:NSArray.class] &&
       self.param.stopSimultaneouslyClassNameArray.count &&
       [self.param.stopSimultaneouslyClassNameArray indexOfObject:NSStringFromClass(otherGestureRecognizer.view.class)] != NSNotFound){
        return NO;
    }
    if (self.sonCanScroll || !self.canScroll || self.contentOffset.y < 0) return NO;
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.param.customFailGesture)  return  self.param.customFailGesture(gestureRecognizer, otherGestureRecognizer);
    if (!self.currentScroll) return NO;
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] &&
        [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) return YES;
    return NO;
}


@end
