//
//  TFY_PageScrollerView.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageScrollerView.h"

@interface TFY_PageScrollerView ()<UIGestureRecognizerDelegate>
@end

@implementation TFY_PageScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.level = 100000;
        self.bounces = NO;
        self.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([NSStringFromClass([gestureRecognizer.view class]) isEqualToString:@"TFY_PageScrollerView"]&&[NSStringFromClass([otherGestureRecognizer.view class]) isEqualToString:@"TFY_PageScrollerView"]) {
        TFY_PageScrollerView *firstView = (TFY_PageScrollerView*)gestureRecognizer.view;
        TFY_PageScrollerView *secondView = (TFY_PageScrollerView*)otherGestureRecognizer.view;
        if (firstView!=secondView) {
            if (firstView.level - secondView.level == abs(1) ) {
                if (firstView.level>secondView.level) {
                    
                    if (firstView.level == 100000  && secondView.level == 99999) {
                        if (firstView.currentIndex>0&&secondView.currentIndex == 0) {
                            return YES;
                        }
                        if (firstView.currentIndex< (firstView.totalCount - 1)&&
                            secondView.currentIndex == (secondView.totalCount - 1)) {
                            return YES;
                        }
                    }else {
                        if (firstView.currentIndex< (firstView.totalCount - 1)&&
                            secondView.currentIndex == (secondView.totalCount - 1)&&!firstView.left&&!secondView.left) {
                            return YES;
                        }
                        if (firstView.currentIndex>0&&secondView.currentIndex == 0&&firstView.left&&secondView.left) {
                            return YES;
                        }
                    }
                }else{
                    if (firstView.currentIndex == 0 && secondView.currentIndex>0) { //左
                        return YES;
                    }else if (firstView.currentIndex == (firstView.totalCount - 1) && secondView.currentIndex<(secondView.totalCount - 1)) {    //右
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

@end
