//
//  TFY_PageLoopView.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageLoopView.h"
#import "TFY_PageBaseController.h"

@interface TFY_PageLoopView ()<UIScrollViewDelegate,PageMunuDelegate> {
    TFY_PageNavBtn *_btnLeft ;
    TFY_PageNavBtn *_btnRight;
    CGFloat lastContentOffset;
    TFY_PageBaseController *page;
    NSInteger _currentTitleIndex;
    TFY_PageNavBtn *_fixLastBtn ;
}
//最底部下划线
@property(nonatomic,strong)UIView *bottomView;
//frame配置
@property(nonatomic,strong)NSDictionary *frameInfo;
//参数
@property(nonatomic,strong)TFY_PageParam  *param;

@end

@implementation TFY_PageLoopView

- (instancetype)initWithFrame:(CGRect)frame param:(TFY_PageParam*)param{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        self.currentTitleIndex = -1;
        self.backgroundColor = param.bgColor;
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.currentTitleIndex = NSNotFound;
    //菜单栏
    [self addSubview:self.mainView];
    self.mainView.frame = [self.frameInfo[@(self.param.menuPosition)] CGRectValue];
    self.mainView.menuDelegate = self;
    self.mainView.param = self.param;
    self.lineView = self.mainView.lineView;
    self.btnArr = self.mainView.btnArr;
    self.fixBtnArr = self.mainView.fixBtnArr;
    [self.fixBtnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        [self addSubview:obj];
    }];
    
    //视图层
    [self addSubview:self.dataView];
    self.dataView.scrollEnabled = self.param.scrollCanTransfer;
    self.dataView.contentSize = CGSizeMake(self.param.titleArr.count * PageVCWidth,0);
    self.dataView.delegate = self;
    self.dataView.totalCount = self.param.titleArr.count;

    //最底部固定线
    if (self.param.insertMenuLine) {
        self.bottomView = [UIView new];
        self.bottomView.backgroundColor = PageColor(0x999999);
        self.bottomView.frame = CGRectMake(0, CGRectGetHeight(self.mainView.frame) - PageK1px, CGRectGetWidth(self.mainView.frame), PageK1px);
        self.param.insertMenuLine(self.bottomView);
    }
    if (self.bottomView) {
        CGRect lineRect = self.bottomView.frame;
        lineRect.origin.y = CGRectGetHeight(self.mainView.frame) - lineRect.size.height;
        if (!lineRect.size.width) {
            lineRect.size.width = CGRectGetWidth(self.mainView.frame);
        }
        self.bottomView.frame = lineRect;
        [self addSubview:self.bottomView];
    }
    //布局frame
    if (self.param.menuPosition == PageMenuPositionBottom) {
        CGRect rect = self.frame;
        rect.origin.y -= CGRectGetHeight(self.frame);
        if (PageIsIphoneX) {
            rect.size.height += 15;
            rect.origin.y -= 15;
        }
        self.frame = rect;
    }
    
    if (!self.param.menuIndicatorY) {
        self.param.menuIndicatorY = 5;
    }
}


#pragma -mark menuDelegate
- (void)titleClick:(TFY_PageNavBtn *)btn fix:(BOOL)fixBtn{
    if (!fixBtn) {
        [self tap:btn];
    }else{
        [self fixTap:btn];
    }
}
//标题点击
- (void)tap:(TFY_PageNavBtn*)btn{
    NSInteger index = [self.btnArr indexOfObject:btn];
    if (index == NSNotFound) return;
    if (self.lastPageIndex != NSNotFound) {
        if (self.param.eventClick) {
            self.param.eventClick(btn, btn.tag);
        }
    }
    if (self.currentTitleIndex == index) return;
    
    if (!btn.onlyClick) {
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(selectBtnWithIndex:)]) {
            [self.loopDelegate selectBtnWithIndex:index];
        }
        if (self.currentTitleIndex == NSNotFound) {
            self.lastPageIndex = self.currentTitleIndex;
            self.nextPageIndex = index;
            self.currentTitleIndex = index;
            UIViewController *newVC = [self getVCWithIndex:index];
            self.currentVC = newVC;
            [newVC beginAppearanceTransition:YES animated:YES];
            [self addChildVC:index VC:newVC];
            [self.dataView setContentOffset:CGPointMake(index*PageVCWidth, 0) animated:NO];
            [newVC endAppearanceTransition];
            if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
                [self.loopDelegate setUpSuspension:newVC index:index end:YES];
            }
            [self.mainView scrollToIndex:index animal:NO];
        }else{
            [self beginAppearanceTransitionWithIndex:index withOldIndex:self.currentTitleIndex];
            self.lastPageIndex = self.currentTitleIndex;
            self.nextPageIndex = index;
            self.currentTitleIndex = index;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
            [self.dataView setContentOffset:CGPointMake(index*PageVCWidth, 0) animated:self.param.tapScrollAnimal];
            [self.mainView scrollToIndex:index];
        }
    }else{
        [self.mainView scrollToIndex:index];
    }
}
//固定标题点击
- (void)fixTap:(TFY_PageNavBtn*)btn{
    if (_fixLastBtn) {
//        if (_fixLastBtn != btn) return;
         _fixLastBtn.selected = NO;
    }
    btn.selected = YES;
    if (self.param.eventFixedClick) {
        self.param.eventFixedClick(btn, btn.tag);
    }
    _fixLastBtn = btn;
}
#pragma -mark- scrollerDeleagte
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    if (![scrollView isDecelerating]&&![scrollView isDragging]) return;
    if (scrollView.contentOffset.x>0 &&scrollView.contentOffset.x <= self.param.titleArr.count * PageVCWidth) {
         [self lifeCycleManage:scrollView];
         [self animalAction:scrollView lastContrnOffset:lastContentOffset];
    }
    
    if (scrollView.contentOffset.y == 0) return;
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y = 0.0;
    scrollView.contentOffset = contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView != self.dataView) return;
    if (!decelerate) {
        [self endAninamal];
        NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
        self.currentTitleIndex = newIndex;
        if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) {
            [self.loopDelegate pageScrollEndWithScrollView:scrollView];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView != self.dataView) return;
    [self endAninamal];
    NSInteger newIndex = scrollView.contentOffset.x/PageVCWidth;
    self.currentTitleIndex = newIndex;
    if (!self.hasEndAppearance) {
        [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
    }
    self.hasEndAppearance = NO;
    [self.mainView scrollToIndex:newIndex];
    
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) {
        [self.loopDelegate pageScrollEndWithScrollView:scrollView];
    }
}

//管理生命周期
- (void)lifeCycleManage:(UIScrollView*)scrollView{
    CGFloat diffX = scrollView.contentOffset.x - lastContentOffset;
    if (diffX < 0) {
        self.currentTitleIndex = ceil(scrollView.contentOffset.x/PageVCWidth);
    }else{
        self.currentTitleIndex = (scrollView.contentOffset.x/PageVCWidth);
    }
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageWithScrollView:left:)]) {
        [self.loopDelegate pageWithScrollView:scrollView left:(diffX < 0)];
    }
    self.dataView.left = (diffX < 0);
    if (diffX > 0) {
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentTitleIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex-1 isFlag:YES];
            [self endAninamal];
            return;
        }
        
        if (!self.hasDealAppearance || self.nextPageIndex != self.currentTitleIndex + 1) {
            self.hasDealAppearance = YES;
            if (self.nextPageIndex == self.currentTitleIndex - 1) {
               [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex isFlag:NO];
                self.hasDifferenrDirection = YES;
            }
            self.nextPageIndex = self.currentTitleIndex + 1;
            self.lastPageIndex = self.currentTitleIndex ;
            [self beginAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex];
        }
        
    }else if(diffX < 0){
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentTitleIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex+1 isFlag:YES];
            [self endAninamal];
            return;
        }
        
        if (!self.hasDealAppearance || self.nextPageIndex != self.currentTitleIndex - 1) {
            self.hasDealAppearance = YES;
            if (self.nextPageIndex == self.currentTitleIndex + 1) {
                [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex isFlag:NO];
                self.hasDifferenrDirection = YES;
            }
            self.nextPageIndex = self.currentTitleIndex - 1;
            self.lastPageIndex = self.currentTitleIndex ;
            [self beginAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex];
        }
    }
}

- (UIViewController*)getVCWithIndex:(NSInteger)index{
    UIViewController *controller = nil;
    if (index < 0|| index >= self.param.titleArr.count) {
        return controller;
    }
    
    controller = [[self findBelongViewControllerForView:self].cache objectForKey:@(index)];
    if (controller) {
        return controller;
    }
    
    if (self.param.controllers) {
        controller = self.param.controllers[index];
        if (controller) {
            return controller;
        }
    }else{
        if (self.param.viewController) {
            controller = self.param.viewController(index);
            if (controller) {
                return controller;
            }
        }
    }
    return controller;
}

- (void)beginAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    if (!newVC||!oldVC||(index==old)||(oldVC==newVC)) return;
    [newVC beginAppearanceTransition:YES animated:YES];
    [self addChildVC:index VC:newVC];
    [oldVC beginAppearanceTransition:NO  animated:YES];
    self.currentVC = newVC;
    
    if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
        [self.loopDelegate setUpSuspension:newVC index:index end:NO];
    }

    if (self.param.eventBeganTransferController) {
        self.param.eventBeganTransferController(oldVC, newVC, old, index);
    }
}

- (void)addChildVC:(NSInteger)index VC:(UIViewController*)newVC{
    if (!newVC) return;
    if (![[self findBelongViewControllerForView:self].childViewControllers containsObject:newVC]) {
        [[self findBelongViewControllerForView:self] addChildViewController:newVC];
        CGRect frame = CGRectMake(index * CGRectGetWidth(self.dataView.frame),0,CGRectGetWidth(self.dataView.frame),
                                  CGRectGetHeight(self.dataView.frame));
        newVC.view.frame = frame;
        [self.dataView addSubview:newVC.view];
        [newVC didMoveToParentViewController:[self findBelongViewControllerForView:self]];
        [[self findBelongViewControllerForView:self].cache setObject:newVC forKey:@(index)];
    }
}
- (void)endAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old isFlag:(BOOL)flag{
    UIViewController *newVC = [self getVCWithIndex:index];
    UIViewController *oldVC = [self getVCWithIndex:old];
    
    if (!newVC||!oldVC||(index==old))   return;
    if (self.currentTitleIndex == self.nextPageIndex) {
        [oldVC willMoveToParentViewController:nil];
        [oldVC.view removeFromSuperview];
        [oldVC removeFromParentViewController];
        
        [newVC endAppearanceTransition];
        [oldVC endAppearanceTransition];
        
        if (flag&&self.hasDifferenrDirection) {
            [newVC endAppearanceTransition];
            [oldVC endAppearanceTransition];
            self.hasDifferenrDirection = NO;
        }
        
        if (self.param.eventEndTransferController) {
            self.param.eventEndTransferController(oldVC, newVC, old, index);
        }
        
        self.currentVC = newVC;
        self.currentTitleIndex = index;
        
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
            [self.loopDelegate setUpSuspension:newVC index:index end:YES];
        }
    }else{
        [newVC willMoveToParentViewController:nil];
        [newVC.view removeFromSuperview];
        [newVC removeFromParentViewController];
        
        [oldVC beginAppearanceTransition:YES animated:YES];
        [oldVC endAppearanceTransition];
        [newVC beginAppearanceTransition:NO animated:YES];
        [newVC endAppearanceTransition];
        
        if (self.param.eventEndTransferController) {
            self.param.eventEndTransferController(newVC, oldVC, index, old);
        }
        
        self.currentVC = oldVC;
        self.currentTitleIndex = old;
        
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) {
            [self.loopDelegate setUpSuspension:oldVC index:old end:YES];
        }
    }
    self.hasDealAppearance = NO;
    self.nextPageIndex = -999;
}

- (BOOL)canTopSuspension{
    if (!self.param.topSuspension
       ||self.param.menuPosition == PageMenuPositionBottom
       ||self.param.menuPosition == PageMenuPositionNavi){
          return NO;
    }
    if (!self.param.titleArr.count) {
        return NO;
    }
    return YES;
}

//动画管理
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat sWidth =  PageVCWidth;
    CGFloat content_X = (contentOffsetX / sWidth);
    NSArray *arr = [[NSString stringWithFormat:@"%f",content_X] componentsSeparatedByString:@"."];
    int num = [arr[0] intValue];
    CGFloat scale = content_X - num;
    int selectIndex = contentOffsetX/sWidth;
    BOOL left = false;
    // 拖拽
    if (contentOffsetX <= lastContentOffset ){
        left = YES;
        selectIndex = selectIndex+1;
        _btnRight = [self safeObjectAtIndex:selectIndex data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex-1 data:self.btnArr];
    } else if (contentOffsetX > lastContentOffset ){
        _btnRight = [self safeObjectAtIndex:selectIndex+1 data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex data:self.btnArr];
                
    }
    
    //跟随滑动
    if (self.param.menuAnimal == PageTitleMenuAiQY) {
        CGRect rect = self.mainView.lineView.frame;
        if (scale < 0.5 ) {
             rect.origin.x = _btnLeft.center.x -self.param.menuIndicatorWidth/2;
             rect.size.width = self.param.menuIndicatorWidth + ( _btnRight.center.x-_btnLeft.center.x) * scale*2;
         }else if(scale >= 0.5 ){
             rect.origin.x = _btnLeft.center.x +  2*(scale-0.5)*(_btnRight.center.x - _btnLeft.center.x)-self.param.menuIndicatorWidth/2;
             rect.size.width =  self.param.menuIndicatorWidth+(_btnRight.center.x-_btnLeft.center.x) * (1-scale)*2;
         }
        
        if (rect.size.height!= (self.param.menuIndicatorHeight?:PageK1px)) {
            rect.size.height = self.param.menuIndicatorHeight?:PageK1px;
        }
        if (rect.origin.y != ([self.mainView getMainHeight]-self.param.menuIndicatorY-rect.size.height/2)) {
            rect.origin.y = [self.mainView getMainHeight]-self.param.menuIndicatorY-rect.size.height/2;
        }
        self.mainView.lineView.frame = rect;
    }else if (self.param.menuAnimal == PageTitleMenuPDD) {
        CGRect rect = self.mainView.lineView.frame;
        rect.size.width = self.param.menuIndicatorWidth?:rect.size.width;
        self.mainView.lineView.frame = rect;
        CGPoint center = self.mainView.lineView.center;
        center.x = _btnLeft.center.x +  (scale)*(_btnRight.center.x - _btnLeft.center.x);
        self.mainView.lineView.center = center;
    }
    
    //渐变
    if (self.param.menuAnimalTitleGradient) {
        TFY_PageNavBtn *tempBtn = _btnLeft?:_btnRight;
        CGFloat difR = tempBtn.selectedColorR - tempBtn.unSelectedColorR;
        CGFloat difG = tempBtn.selectedColorG - tempBtn.unSelectedColorG;
        CGFloat difB = tempBtn.selectedColorB - tempBtn.unSelectedColorB;
        UIColor *leftItemColor  = [UIColor colorWithRed:tempBtn.unSelectedColorR+scale*difR green:tempBtn.unSelectedColorG+scale*difG blue:tempBtn.unSelectedColorB+scale*difB alpha:1];
        UIColor *rightItemColor = [UIColor colorWithRed:tempBtn.unSelectedColorR+(1-scale)*difR green:tempBtn.unSelectedColorG+(1-scale)*difG blue:tempBtn.unSelectedColorB+(1-scale)*difB alpha:1];
        
        _btnLeft.titleLabel.textColor = rightItemColor;
        _btnRight.titleLabel.textColor = leftItemColor;
    }
}

//结束动画处理
- (void)endAninamal{
//    return;
}

- (id)safeObjectAtIndex:(NSUInteger)index data:(NSArray*)data
{
    if (index < data.count) {
        return [data objectAtIndex:index];
    } else {
        return nil;
    }
}

- (nullable TFY_PageBaseController *)findBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[TFY_PageBaseController class]]) {
            return (TFY_PageBaseController *)responder;
        }
    return nil;
}
- (TFY_PageMunuView *)mainView {
    if (!_mainView) {
        _mainView = [TFY_PageMunuView new];
    }
    return _mainView;
}
- (TFY_PageScrollerView *)dataView{
    if (!_dataView) {
        _dataView = [[TFY_PageScrollerView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.mainView.frame),CGRectGetWidth(self.frame), 0)];
    }
    return _dataView;
}
- (NSDictionary *)frameInfo{
    if (!_frameInfo) {
        _frameInfo = @{
            @(PageMenuPositionLeft):[NSValue valueWithCGRect:CGRectMake(0, self.param.menuCellMarginY , self.param.menuWidth,self.param.menuHeight)],
            @(PageMenuPositionRight):[NSValue valueWithCGRect:CGRectMake(PageVCWidth-self.param.menuWidth, self.param.menuCellMarginY  , self.param.menuWidth,self.param.menuHeight)],
            @(PageMenuPositionCenter):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.menuWidth)/2, self.param.menuCellMarginY , self.param.menuWidth,self.param.menuHeight)],
            @(PageMenuPositionNavi):[NSValue valueWithCGRect:CGRectMake((PageVCWidth-self.param.menuWidth)/2, self.param.menuCellMarginY , self.param.menuWidth,self.param.menuHeight)],
            @(PageMenuPositionBottom):[NSValue valueWithCGRect:CGRectMake(0, PageVCHeight, self.param.menuWidth,PageIsIphoneX?(self.param.menuHeight + 15):self.param.menuHeight)],
        };
    }
    return _frameInfo;
}
- (void)setCurrentTitleIndex:(NSInteger)currentTitleIndex{
    _currentTitleIndex = currentTitleIndex;
    self.dataView.currentIndex = currentTitleIndex;
}

@end
