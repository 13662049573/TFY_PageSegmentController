//
//  TFY_PageLoopView.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageLoopView.h"
#import "TFY_PageBaseController.h"
#import "TFY_PageProtocol.h"

@interface TFY_PageLoopView ()<UIScrollViewDelegate,PageMunuDelegate>{
    CGFloat lastContentOffset;
    NSInteger _currentTitleIndex;
}
/// frame配置
@property (nonatomic, strong, nullable) NSDictionary *frameInfo;
/// 参数
@property (nonatomic, strong) TFY_PageParam  *param;
@end

@implementation TFY_PageLoopView

- (instancetype)initWithFrame:(CGRect)frame param:(TFY_PageParam *)param parentReponder:(UIResponder *)parentReponder{
    if (self = [super initWithFrame:frame]) {
        self.parentResponder = parentReponder;
        self.param = param;
        self.currentTitleIndex = NSNotFound;
        self.backgroundColor = param.BgColor;
        [self loadUI:frame.size.width clear:YES];
    }
    return self;
}

- (void)loadUI:(CGFloat)width clear:(BOOL)clear{
    CGFloat lastPageWidth = self.pageWidth;
    self.pageWidth = width?:self.frame.size.width;
    [self setUp:clear];
    ///适配横竖屏
    if (self.param.DeviceChange &&
        self.dataView.subviews.count &&
        lastPageWidth) {
        for (int i = 0; i < self.dataView.subviews.count; i++) {
            UIView *temp = self.dataView.subviews[i];
            int num = temp.frame.origin.x / lastPageWidth;
            [temp page_x:num * self.pageWidth];
        }
        NSInteger current = self.currentTitleIndex != NSNotFound ? self.currentTitleIndex : self.param.MenuDefaultIndex;
        [self.dataView setContentOffset:CGPointMake(current * self.pageWidth, 0) animated:NO];
        [self.mainView scrollToIndex:current animal:NO];
    }
}

- (void)setUp:(BOOL)clear{
    CGFloat addh = 0;
    if (self.param.MenuAddSubView) {
        UIView *insertView = self.param.MenuAddSubView();
        if ([insertView isKindOfClass:UIView.class]) {
            [self.insertView layoutIfNeeded];
            self.insertView = insertView;
            addh = self.insertView.frame.size.height + self.param.MenuInsets.bottom ;
            self.param.MenuInsets = UIEdgeInsetsMake(self.param.MenuInsets.top, self.param.MenuInsets.left, self.param.MenuInsets.bottom + CGRectGetMaxY(self.insertView.frame), self.param.MenuInsets.right);
        }
    }
    /// 菜单栏
    [self addSubview:self.mainView];
    self.mainView.frame = [self.frameInfo[@(self.param.MenuPosition)] CGRectValue];
    self.mainView.menuDelegate = self;
    if (clear) {
        self.mainView.param = self.param;
    }else{
        if (self.mainView.btnArr.count)
            [self.mainView resetMainViewContenSize:self.mainView.btnArr.lastObject];
        
        [self.mainView setUpFixRightBtn:self.mainView.btnArr.lastObject];
    }
    self.lineView = self.mainView.lineView;
    self.btnArr = self.mainView.btnArr;
    self.fixBtnArr = self.mainView.fixBtnArr;
    [self.fixBtnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        [self addSubview:obj];
    }];
    /// 视图层
    [self addSubview:self.dataView];
    [self.dataView page_width:self.pageWidth];
    self.dataView.scrollEnabled = self.param.ScrollCanTransfer;
    self.dataView.contentSize = CGSizeMake(self.param.TitleArr.count * self.pageWidth,0);
    self.dataView.delegate = self;
    self.dataView.totalCount = self.param.TitleArr.count;
    self.dataView.respondGuestureType = self.param.RespondGuestureType;
    self.dataView.globalTriggerOffset = self.param.GlobalTriggerOffset;
    /// 布局frame
    if (self.param.MenuPosition == PageMenuPositionBottom) {
        CGRect rect = self.frame;
        rect.origin.y -= self.frame.size.height;
        if (PageIsIphoneX) {
            rect.size.height += 15;
            rect.origin.y -= 15;
        }
        self.frame = rect;
    }
    if (!self.param.MenuIndicatorY) self.param.MenuIndicatorY = 5;
    self.mainView.contentInset = UIEdgeInsetsMake(0, self.param.MenuInsets.left, 0, self.param.MenuInsets.right);
    if (self.insertView) {
        [self addSubview:self.insertView];
        [self.insertView page_y:CGRectGetMaxY(self.mainView.frame) - addh];
    }
}

#pragma -mark menuDelegate
- (void)titleClick:(TFY_PageNavBtn *)btn fix:(BOOL)fixBtn{
    if (!fixBtn) [self tap:btn];
}

- (void)tap:(TFY_PageNavBtn*)btn{
    NSInteger index = [self.btnArr indexOfObject:btn];
    if (index == NSNotFound  || index > self.btnArr.count) return;
    if (self.currentTitleIndex == index) return;
    if (!btn.tapType) {
        if (self.loopDelegate&&
            [self.loopDelegate respondsToSelector:@selector(selectBtnWithIndex:)])
            [self.loopDelegate selectBtnWithIndex:index];
        if (self.currentTitleIndex == NSNotFound) {
            self.lastPageIndex = self.currentTitleIndex;
            self.nextPageIndex = index;
            self.currentTitleIndex = index;
            UIResponder *newVC = [self getVCWithIndex:index];
            self.currentVC = (id)newVC;
            [self viewProtocolAction:@"wa" view:newVC];
            [self addChildVC:index VC:newVC];
            [self viewProtocolAction:@"da" view:newVC];
            [self.dataView setContentOffset:CGPointMake(index * self.pageWidth, 0) animated:NO];
            if (self.param.EventEndTransferController)self.param.EventEndTransferController(nil, (id)newVC, 0, index);
            if (self.loopDelegate &&
                [self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)])
                [self.loopDelegate setUpSuspension:newVC index:index end:YES];
        }else{
            [self beginAppearanceTransitionWithIndex:index withOldIndex:self.currentTitleIndex];
            self.lastPageIndex = self.currentTitleIndex;
            self.nextPageIndex = index;
            self.currentTitleIndex = index;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
            [self.dataView setContentOffset:CGPointMake(index * self.pageWidth, 0) animated:self.param.TapScrollAnimal];
        }
    }
    
    if (!self.changeDevice) {
        if (self.param.EventClick) self.param.EventClick(btn, btn.tag);
    }else{
        self.changeDevice = NO;
    }
}

#pragma -mark- scrollerDeleagte
- (void)scrollViewWillBeginDragging:(TFY_PageDataView *)scrollView{
    if (scrollView != self.dataView) return;
    lastContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(TFY_PageDataView *)scrollView{
    if (scrollView != self.dataView) return;
    ///矫正
    if (self.dataView.totalCount != self.param.TitleArr.count)
        self.dataView.totalCount = self.param.TitleArr.count;

    if (scrollView.contentOffset.x < 0)
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    if (scrollView.contentOffset.x > self.pageWidth * (self.param.TitleArr.count - 1))
        [scrollView setContentOffset:CGPointMake(self.pageWidth * (self.param.TitleArr.count - 1), 0) animated:NO];
    
    if (scrollView.popGuestureOffset >= 0 && self.param.RespondGuestureType != PagePopNone){
        [scrollView setContentOffset:CGPointMake(scrollView.popGuestureOffset, 0) animated:NO]; return;
    }
    
    if (![scrollView isDecelerating]&&![scrollView isDragging]) return;
    if (scrollView.contentOffset.x>0 &&scrollView.contentOffset.x<=self.param.TitleArr.count * self.pageWidth ) {
         [self lifeCycleManage:scrollView];
         [self.mainView animalAction:scrollView lastContrnOffset:lastContentOffset];
    }
    if (scrollView.contentOffset.y == 0) return;
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y = 0.0;
    scrollView.contentOffset = contentOffset;
}

- (void)scrollViewDidEndDragging:(TFY_PageDataView *)scrollView illDecelerate:(BOOL)decelerate{
    if (scrollView != self.dataView) return;
    if (self.dataView.popGuestureOffset != -1) self.dataView.popGuestureOffset = -1;
    if (!decelerate) {
        NSInteger newIndex = scrollView.contentOffset.x / self.pageWidth;
        self.currentTitleIndex = newIndex;
        if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) [self.loopDelegate pageScrollEndWithScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(TFY_PageDataView *)scrollView{
    if (scrollView != self.dataView) return;
    if (self.dataView.popGuestureOffset != -1) self.dataView.popGuestureOffset = -1;
    NSInteger newIndex = scrollView.contentOffset.x / self.pageWidth ;
    self.currentTitleIndex = newIndex;
    if (!self.hasEndAppearance) {
        [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.lastPageIndex isFlag:NO];
    }
    self.hasEndAppearance = NO;
    [self.mainView scrollToIndex:newIndex animal:YES];
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageScrollEndWithScrollView:)]) [self.loopDelegate pageScrollEndWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.dataView.popGuestureOffset != -1) self.dataView.popGuestureOffset = -1;
}

/// 管理生命周期
- (void)lifeCycleManage:(UIScrollView*)scrollView{
    CGFloat diffX = scrollView.contentOffset.x - lastContentOffset;
    NSInteger currentIndex = diffX < 0 ? ceil(scrollView.contentOffset.x / self.pageWidth) : (scrollView.contentOffset.x / self.pageWidth);
    if (self.currentTitleIndex != currentIndex &&
        self.param.MenuFollowSliding) {
        [self.mainView scrollToIndex:currentIndex animal:YES];
    }
    self.currentTitleIndex = currentIndex;
    
    if (self.loopDelegate && [self.loopDelegate respondsToSelector:@selector(pageWithScrollView:left:)]) [self.loopDelegate pageWithScrollView:scrollView left:(diffX < 0)];
    if (diffX > 0) {
        if (self.hasDealAppearance&&self.nextPageIndex == self.currentTitleIndex) {
            self.hasEndAppearance = YES;
            [self endAppearanceTransitionWithIndex:self.nextPageIndex withOldIndex:self.currentTitleIndex-1 isFlag:YES];
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

- (UIResponder*)getVCWithIndex:(NSInteger)index{
    UIResponder *controller = nil;
    if (index < 0 || index >= self.param.TitleArr.count)  return controller;
    controller = [self.cache objectForKey:@(index)];
    if (controller) return controller;
    if (self.param.Controllers) {
        controller = self.param.Controllers[index];
        if (controller)  return controller;
    }else{
        if (self.param.ViewController) {
            controller = self.param.ViewController(index);
            if (controller) return controller;
        }
    }
    return controller;
}

- (void)beginAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old{
    UIResponder *newVC = [self getVCWithIndex:index];
    UIResponder *oldVC = [self getVCWithIndex:old];
    if (!newVC || !oldVC || (index==old) || (oldVC==newVC)) return;
    [self appearanceTransition:YES end:NO controller:newVC];
    [self addChildVC:index VC:newVC];
    [self appearanceTransition:NO end:NO controller:oldVC];
    self.currentVC = (id)newVC;
    if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) [self.loopDelegate setUpSuspension:newVC index:index end:NO];
    if (self.param.EventBeganTransferController) self.param.EventBeganTransferController((id)oldVC, (id)newVC, old, index);
}

- (void)addChildVC:(NSInteger)index VC:(UIResponder*)newReponder{
    if (!newReponder) return;
    CGRect frame = CGRectMake(index * self.pageWidth,0,self.pageWidth,
                              self.dataView.frame.size.height);
    if ([self.parentResponder isKindOfClass:UIViewController.class]) {
        UIViewController *parentVC = (UIViewController*)self.parentResponder;
        
        if ([parentVC.parentViewController isKindOfClass:[TFY_PageBaseController class]]) {
            TFY_PageBaseController *parentViewController = (TFY_PageBaseController*)parentVC.parentViewController;
            self.dataView.level = parentViewController.upSc.dataView.level - 1;
        }
        
        if ([newReponder isKindOfClass:UIViewController.class]) {
            UIViewController *newVC = (UIViewController*)newReponder;
            if (![parentVC.childViewControllers containsObject:newVC]) {
                [parentVC addChildViewController:newVC];
                newVC.view.frame = frame;
                [self.dataView addSubview:newVC.view];
                [newVC didMoveToParentViewController:parentVC];
            }else{
                newVC.view.frame = frame;
            }
        }else if ([newReponder isKindOfClass:UIView.class]){
            UIView *tempView = (UIView*)newReponder;
            if ([self.dataView.subviews indexOfObject:tempView] == NSNotFound) {
                [self.dataView addSubview:tempView];
            }
            tempView.frame = frame;
        }
        [self.cache setObject:newReponder forKey:@(index)];
    }else if (([self.parentResponder isKindOfClass:UIView.class])){
        
    }
}

- (void)endAppearanceTransitionWithIndex:(NSInteger)index withOldIndex:(NSInteger)old  isFlag:(BOOL)flag{
    UIResponder *newResponer = [self getVCWithIndex:index];
    UIResponder *oldResponer = [self getVCWithIndex:old];
    if (!newResponer || !oldResponer || (index == old)) return;
    if (self.currentTitleIndex == self.nextPageIndex) {
        if ([oldResponer isKindOfClass:UIViewController.class]) {
            UIViewController *oldVC = (UIViewController*)oldResponer;
            [oldVC willMoveToParentViewController:nil];
            [oldVC.view removeFromSuperview];
            [oldVC removeFromParentViewController];
        }else if ([oldResponer isKindOfClass:UIView.class]) {
            UIView *tempView = (UIView*)oldResponer;
            [tempView removeFromSuperview];
        }
        [self appearanceTransition:YES end:YES controller:newResponer];
        [self appearanceTransition:NO end:YES controller:oldResponer];
        if (flag && self.hasDifferenrDirection) {
            [self appearanceTransition:YES  end:YES controller:newResponer];
            [self appearanceTransition:NO  end:YES controller:oldResponer];
            self.hasDifferenrDirection = NO;
        }
        if (self.param.EventEndTransferController) self.param.EventEndTransferController((id)oldResponer, (id)newResponer, old, index);
        self.currentVC = (id)newResponer;
        self.currentTitleIndex = index;
        if (self.loopDelegate &&
            [self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)])
            [self.loopDelegate setUpSuspension:newResponer index:index end:YES];
    }else{
        if ([newResponer isKindOfClass:UIViewController.class]) {
            UIViewController *newVC = (UIViewController*)newResponer;
            [newVC willMoveToParentViewController:nil];
            [newVC.view removeFromSuperview];
            [newVC removeFromParentViewController];
        }else if ([newResponer isKindOfClass:UIView.class]) {
            UIView *tempView = (UIView*)newResponer;
            [tempView removeFromSuperview];
        }
        [self appearanceTransition:YES end:NO controller:oldResponer];
        [self appearanceTransition:YES end:YES controller:oldResponer];
        [self appearanceTransition:NO end:NO controller:newResponer];
        [self appearanceTransition:NO end:YES controller:newResponer];
        if (self.param.EventEndTransferController) self.param.EventEndTransferController((id)newResponer, (id)oldResponer, index, old);
        self.currentVC = (id)oldResponer;
        self.currentTitleIndex = old;
        if (self.loopDelegate&&[self.loopDelegate respondsToSelector:@selector(setUpSuspension:index:end:)]) [self.loopDelegate setUpSuspension:oldResponer index:old end:YES];
    }
    self.hasDealAppearance = NO;
    self.nextPageIndex = -999;
}

/// 控制器生命周期
- (void)appearanceTransition:(BOOL)isAppearing end:(BOOL)end controller:(UIResponder*)responer{
    if (!responer) return;;
    if (end) {
        if ([responer isKindOfClass:UIViewController.class])
            [(UIViewController*)responer endAppearanceTransition];
            
        [self viewProtocolAction: isAppearing?@"da":@"dd" view:responer];
    }else{
        if ([responer isKindOfClass:UIViewController.class])
            [(UIViewController*)responer beginAppearanceTransition:isAppearing animated:NO];
        
        [self viewProtocolAction: isAppearing?@"wa":@"wd" view:responer];
    }
}

/// 协议生命周期方法
- (void)viewProtocolAction:(NSString*)tag view:(id)view{
    if (!tag && ![tag isKindOfClass:NSString.class]) return;
    if (![view conformsToProtocol:@protocol(TFY_PageProtocol)]) return;
    if ([tag isEqualToString:@"wa"] && [view respondsToSelector:@selector(pageViewWillAppear)]) [view pageViewWillAppear];
    if ([tag isEqualToString:@"da"] && [view respondsToSelector:@selector(pageViewDidAppear)]) [view pageViewDidAppear];
    if ([tag isEqualToString:@"wd"] && [view respondsToSelector:@selector(pageViewWillDisappear)]) [view pageViewWillDisappear];
    if ([tag isEqualToString:@"dd"] && [view respondsToSelector:@selector(pageViewDidDisappear)]) [view pageViewDidDisappear];
}

- (nullable TFY_PageBaseController *)findBelongViewControllerForView:(UIView *)view {
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[TFY_PageBaseController class]]) {
            return (TFY_PageBaseController *)responder;
        }
    return nil;
}


- (BOOL)canTopSuspension{
    if (!self.param.TopSuspension
       ||self.param.MenuPosition == PageMenuPositionBottom
        ||self.param.MenuPosition == PageMenuPositionNavi) return NO;
    if (!self.param.TitleArr.count) return NO;
    return YES;
}

- (TFY_PageMunuView *)mainView{
    return _mainView ?: ({ _mainView = TFY_PageMunuView.new;});
}

- (TFY_PageDataView *)dataView{
    return _dataView ?: ({ _dataView = [[TFY_PageDataView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mainView.frame),self.bounds.size.width, 0)];});
}

- (NSDictionary *)frameInfo{
    CGFloat menuCellMarginY = self.param.MenuCellMarginY;
    if (!UIEdgeInsetsEqualToEdgeInsets(self.param.MenuInsets, UIEdgeInsetsZero)) menuCellMarginY = self.param.MenuInsets.top;
    _frameInfo = @{
        @(PageMenuPositionLeft):[NSValue valueWithCGRect:CGRectMake(0, menuCellMarginY , self.param.MenuWidth,self.param.MenuHeight + self.param.MenuInsets.bottom)],
        @(PageMenuPositionRight):[NSValue valueWithCGRect:CGRectMake(self.pageWidth-self.param.MenuWidth, menuCellMarginY , self.param.MenuWidth,self.param.MenuHeight + self.param.MenuInsets.bottom )],
        @(PageMenuPositionCenter):[NSValue valueWithCGRect:CGRectMake((self.pageWidth - self.param.MenuWidth)/2, menuCellMarginY , self.param.MenuWidth,self.param.MenuHeight + self.param.MenuInsets.bottom )],
        @(PageMenuPositionNavi):[NSValue valueWithCGRect:CGRectMake((self.pageWidth - self.param.MenuWidth)/2, menuCellMarginY , self.param.MenuWidth,self.param.MenuHeight + self.param.MenuInsets.bottom )],
        @(PageMenuPositionBottom):[NSValue valueWithCGRect:CGRectMake(menuCellMarginY, self.pageWidth , self.param.MenuWidth,(PageIsIphoneX?(self.param.MenuHeight + 34):self.param.MenuHeight) + self.param.MenuInsets.bottom )],
    };
    return _frameInfo;
}

- (void)setPageWidth:(CGFloat)pageWidth{
    _pageWidth = pageWidth;
    self.mainView.pageWidth = self.dataView.pageWidth = pageWidth;
}

- (void)setCurrentTitleIndex:(NSInteger)currentTitleIndex{
    _currentTitleIndex = currentTitleIndex;
    self.dataView.currentIndex = currentTitleIndex;
}

@end
