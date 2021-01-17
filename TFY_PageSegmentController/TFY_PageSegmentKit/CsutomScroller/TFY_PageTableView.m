//
//  TFY_PageTableView.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageTableView.h"
#import "TFY_ConfigProtocol.h"

@implementation TFY_PageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.bounces = NO;
        self.estimatedRowHeight = 100;
        self.sectionHeaderHeight = 0.01;
        self.sectionFooterHeight = 0.01;
        if (@available(iOS 11.0, *)) {
            self.estimatedSectionFooterHeight = 0.01;
            self.estimatedSectionHeaderHeight = 0.01;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            self.automaticallyAdjustsScrollIndicatorInsets = NO;
        }
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (!self.canScroll) return NO;
    CGFloat naVi = self.fromNavi?PageVCNavBarHeight:0;
    CGFloat segmentViewContentScrollViewHeight = PageVCHeight - naVi - self.menuTitleHeight;
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    CGRect containRect = CGRectMake(0, self.contentSize.height - segmentViewContentScrollViewHeight, PageVCWidth, segmentViewContentScrollViewHeight);
    if (CGRectContainsPoint(containRect, currentPoint) ) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    } else if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"TFY_PageScrollerView"]) {
        return YES;
    } else if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
        if (self.contentOffset.x <= 0){
            return YES;
        }
    }
    return NO;
}


@end
