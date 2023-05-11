//
//  TFY_PageDataView.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageDataView.h"
#import "TFY_PageLoopView.h"

@implementation TFY_PageDataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.level = 100000;
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = NO;
        self.scrollsToTop = NO;
        self.pageWidth = PageVCWidth;
        self.popGuestureOffset = -1;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([NSStringFromClass([gestureRecognizer.view class]) isEqualToString:@"TFY_PageDataView"]&&
        [NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"TFY_PageDataView"]
        && [NSStringFromClass([gestureRecognizer class]) isEqualToString:@"UIScrollViewPanGestureRecognizer"]) {
        TFY_PageDataView *firstView = (TFY_PageDataView*)gestureRecognizer.view;
        TFY_PageDataView *secondView = (TFY_PageDataView*)otherGestureRecognizer.view;
        
        if (firstView.level - secondView.level == -1) {
            firstView.left = ([firstView.panGestureRecognizer translationInView:firstView.superview].x > 0);
            if (firstView.contentOffset.x <= 0) {
                if (firstView.left && secondView.currentIndex > 0) return YES;
                if (!firstView.left && firstView.currentIndex == (firstView.totalCount - 1)) return YES;
            }else if(firstView.contentOffset.x >= self.pageWidth * (firstView.totalCount - 1)){
                if (firstView.left && firstView.currentIndex == 0 && secondView.currentIndex > 0) return YES;
                if (!firstView.left && secondView.currentIndex < (secondView.totalCount - 1)) return YES;
            }
        }
    }

    if ([NSStringFromClass([gestureRecognizer class]) isEqualToString:@"UIScrollViewPanGestureRecognizer"] && self.respondGuestureType != PagePopNone){
        CGPoint point = [self.panGestureRecognizer translationInView:self.superview];
        if (point.x >= 0 &&
            (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged)) {
            if (self.respondGuestureType  == PagePopFirst ) {
                if (self.contentOffset.x <= 0) {
                    self.popGuestureOffset = self.contentOffset.x;
                    return YES;
                }
            }else if (self.respondGuestureType  == PagePopAll){
                int ges = [gestureRecognizer locationInView:self].x;
                int kw =[UIScreen mainScreen].bounds.size.width;
                NSInteger off = ges % kw;
                if (off < self.globalTriggerOffset) {
                    self.popGuestureOffset = self.contentOffset.x;
                    return YES;
                }
            }
        }
    }
    return NO;
}


@end
