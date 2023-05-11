//
//  TFY_PageBaseView.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2023/5/11.
//

#import "TFY_PageBaseView.h"
#import "TFY_PageBaseController.h"

@interface TFY_PageBaseView (){
    BOOL hadWillDisappeal;
    NSInteger footerViewIndex;
    CGFloat sonChildVCHeight;
    CGRect pageDataFrame;
}
/// 当前子控制器中的滚动视图
@property (nonatomic, strong) UIScrollView *currentScroll;
/// 子控制器中的滚动视图数组(底部有多层的情况)
@property (nonatomic, strong) NSArray *currentScrollArr;
/// 当前子控制器中需要固定的底部视图
@property (nonatomic, strong) UIView *currentFootView;
/// 头部视图菜单栏底部的占位视图(如有需要)
@property (nonatomic, strong) UIView *head_MenuView;
/// 底部tableView是否可以滚动
@property (nonatomic, assign) BOOL canScroll;
/// onTableView是否可以滚动
@property (nonatomic, assign) BOOL sonCanScroll;
/// 到达顶部
@property (nonatomic, assign) BOOL scrolTotop;
/// 到达底部
@property (nonatomic, assign) BOOL scrolToBottom;
/// headSize
@property (nonatomic, assign) CGSize headSize;
///headHeight
@property (nonatomic, assign) CGFloat headHeight;
/// mainLastOffset
@property (nonatomic, assign) int mainLastOffset;
/// footOriginY
@property (nonatomic, assign) CGFloat footOriginY;
/// 响应父类
@property (nonatomic, weak, readwrite) UIResponder *parentResponder;
/// 自动适配
@property (nonatomic, assign) BOOL autoFit;
/// 初始menuInsets
@property (nonatomic, assign) UIEdgeInsets originMenuInsets;

@end

@implementation TFY_PageBaseView

@synthesize param = _param ;
@synthesize upSc = _upSc;
@synthesize downSc = _downSc;
@synthesize cache = _cache;
@synthesize sonChildScrollerViewDic = _sonChildScrollerViewDic;
@synthesize sonChildFooterViewDic = _sonChildFooterViewDic;
@synthesize headView = _headView;
@synthesize headViewSonView = _headViewSonView;
@synthesize naviBarBackGround = _naviBarBackGround;

- (instancetype)initWithFrame:(CGRect)frame
                        param:(TFY_PageParam*)param
               parentReponder:(UIResponder*)parentReponder{
    return [self initWithFrame:frame autoFix:YES param:param parentReponder:parentReponder];
}

- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                        param:(TFY_PageParam*)param
               parentReponder:(UIResponder*)parentReponder{
    return [self initWithFrame:frame autoFix:autoFix source:NO param:param parentReponder:parentReponder];
}

- (instancetype)initWithFrame:(CGRect)frame
                      autoFix:(BOOL)autoFix
                       source:(BOOL)pageController
                        param:(TFY_PageParam*)param
               parentReponder:(UIResponder*)parentReponder{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoFit = autoFix;
        self.parentResponder = parentReponder;
        self.param = param;
        self.originMenuInsets = UIEdgeInsetsMake(-1, -1, -1, -1);
        if (!pageController) {
            [self showData];
        }
    }
    return self;
}

///布局
- (void)setUpUI:(BOOL)clear{
    if (!UIEdgeInsetsEqualToEdgeInsets(self.originMenuInsets, self.param.MenuInsets) &&
        !UIEdgeInsetsEqualToEdgeInsets(self.originMenuInsets, UIEdgeInsetsMake(-1, -1, -1, -1))) {
        self.param.MenuInsets = self.originMenuInsets;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(self.originMenuInsets, UIEdgeInsetsMake(-1, -1, -1, -1))) {
        self.originMenuInsets = self.param.MenuInsets;
    }
    self.backgroundColor = UIColor.whiteColor;
    footerViewIndex = -1;
    CGFloat headY = 0;
    CGFloat tabbarHeight = 0;
    CGFloat statusBarHeight = 0;
    if ([self.parentResponder isKindOfClass:UIViewController.class] && self.autoFit) {
        UIViewController *parentVC = (UIViewController*)self.parentResponder;
        if (parentVC.presentingViewController) {
            if (!parentVC.navigationController) statusBarHeight = PageVCStatusBarHeight;
        } else if (parentVC.tabBarController) {
            tabbarHeight = !parentVC.tabBarController.tabBar.translucent ? 0 : PageVCTabBarHeight;
        } else if (parentVC.navigationController){
            headY = (!self.param.FromNavi&&
                      self.param.MenuPosition != PageMenuPositionBottom)?
            0:(!parentVC.navigationController.navigationBar.translucent? 0 : PageVCNavBarHeight);
        }
        if (parentVC.parentViewController) {
            if ([parentVC.parentViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *naPar = (UINavigationController*)parentVC.parentViewController;
                headY = (!self.param.FromNavi&&
                self.param.MenuPosition != PageMenuPositionBottom)?0:
                (!naPar.navigationBar.translucent ?
                 0: (naPar.isNavigationBarHidden ? PageVCStatusBarHeight : PageVCNavBarHeight));
                
                if (parentVC.parentViewController.tabBarController)
                    tabbarHeight = !parentVC.parentViewController.tabBarController.tabBar.translucent ? 0 : PageVCTabBarHeight;
    
            }else if ([parentVC.parentViewController isKindOfClass:[UITabBarController class]]) {
                UITabBarController *ta = (UITabBarController*)parentVC.parentViewController;
                
                if (!ta.tabBar.translucent)
                    tabbarHeight = !ta.tabBar.translucent ? 0 : PageVCTabBarHeight;
                
                if (parentVC.parentViewController.navigationController) {
                    headY = (!self.param.FromNavi&&
                    self.param.MenuPosition != PageMenuPositionBottom)?0:(!parentVC.parentViewController.navigationController.navigationBar.translucent?0:PageVCNavBarHeight);
                }else if(parentVC.parentViewController.presentingViewController){
                    statusBarHeight = PageVCStatusBarHeight;
                }
            }else if ([parentVC.parentViewController isKindOfClass:[TFY_PageBaseController class]]) {
                headY = 0;
                tabbarHeight = 0;
                statusBarHeight = 0;
            }
        }
        if (parentVC.hidesBottomBarWhenPushed && tabbarHeight >= PageVCTabBarHeight)
            tabbarHeight -= PageVCTabBarHeight;
    }
   
    if (self.param.CustomNaviBarY) headY = self.param.CustomNaviBarY(headY);
    if (self.param.CustomTabbarY) tabbarHeight  = self.param.CustomTabbarY(tabbarHeight);
    self.downSc.bounces = self.param.Bounces;
    self.clipsToBounds = YES;
    if ([self.parentResponder isKindOfClass:TFY_PageBaseController.class]) {
        self.downSc.delegate = (id)self.parentResponder;
    }else{
        self.downSc.delegate = self;
    }
    self.downSc.frame = CGRectMake(0, headY, self.bounds.size.width , self.bounds.size.height - headY - tabbarHeight);
    BOOL scroll = [self canTopSuspension];
    if (scroll) {
        if ([self.parentResponder isKindOfClass:UIViewController.class]) {
            UIViewController *parentVC = (UIViewController*)self.parentResponder;
            if ([parentVC.parentViewController isKindOfClass:TFY_PageBaseController.class]) {
                UIViewController<TFY_PageScrollProcotol> *pageVC = (UIViewController<TFY_PageScrollProcotol>*)self.parentResponder;
                while ((pageVC = (TFY_PageBaseController*)[pageVC parentViewController])){
                    if ([pageVC isKindOfClass:[TFY_PageBaseController class]]) {
                        if (pageVC.param.TopSuspension &&
                            [pageVC.headViewSonView isKindOfClass:UIView.class] &&
                            pageVC.headViewSonView.frame.size.height) break;
                    }
                }
                if (pageVC && pageVC != self.parentResponder) scroll = NO;
            }
        }
    }
    self.downSc.canScroll = self.downSc.scrollEnabled = scroll;
    [self addSubview:self.downSc];
    /// 滚动和菜单视图
    if (self.param.DeviceChange) {
        if (clear) {
            self.upSc = [[TFY_PageLoopView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) param:self.param parentReponder:self.parentResponder];
        }else{
            self.upSc.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            [self.upSc loadUI:self.upSc.frame.size.width clear:NO];
        }
    }else{
        self.upSc = [[TFY_PageLoopView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) param:self.param parentReponder:self.parentResponder];
    }
    self.upSc.cache = self.cache;
    self.upSc.loopDelegate = self;
    self.downSc.tableFooterView = self.upSc;
    if (self.param.CustomMenuTitle)  self.param.CustomMenuTitle(self.upSc.btnArr);
    /// 底部
    [self setUpMenuAndDataViewFrame];
    [self setUpHead];
    self.downSc.param = self.param;
    self.canScroll = YES;
    self.scrolToBottom = YES;
    
    if (clear) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.downSc reloadData];
            [self.downSc layoutIfNeeded];
            [self selectMenuWithIndex:self.param.MenuDefaultIndex];
        });
    }
}

- (void)setUpMenuAndDataViewFrame{
    sonChildVCHeight = 0;
    CGFloat menuCellMarginY = self.param.MenuCellMarginY;
    if (!UIEdgeInsetsEqualToEdgeInsets(self.param.MenuInsets, UIEdgeInsetsZero)){
        menuCellMarginY = self.param.MenuInsets.top;
    }
    CGFloat titleMenuhHeight = self.upSc.mainView.frame.size.height + menuCellMarginY;
    if (self.param.MenuPosition == PageMenuPositionNavi) {
        sonChildVCHeight = self.downSc.bounds.size.height;
    }else if (self.param.MenuPosition == PageMenuPositionBottom) {
        sonChildVCHeight = self.downSc.bounds.size.height - titleMenuhHeight;
    }else{
        sonChildVCHeight = self.downSc.bounds.size.height - titleMenuhHeight;
    }
    CGFloat height = [self canTopSuspension]?
    sonChildVCHeight :(sonChildVCHeight-self.headHeight);
    if ([self canTopSuspension]) {
        if ([self.parentResponder isKindOfClass:UIViewController.class] && self.autoFit) {
            UIViewController *parentVC = (UIViewController*)self.parentResponder;
            if (!parentVC.parentViewController) {
                if (self.downSc.frame.origin.y == 0)
                    height -= self.param.CustomDataViewTopOffset;
            }else{
                if (![parentVC.parentViewController isKindOfClass:[TFY_PageBaseController class]]) {
                    if (parentVC.navigationController &&
                        ![parentVC.navigationController isNavigationBarHidden]) {
                        if (!self.param.FromNavi)
                            height -= (parentVC.navigationController.navigationBar.translucent? PageVCNavBarHeight:0);
                    }else{
                        if (self.downSc.frame.origin.y == 0)
                            height -= self.param.CustomDataViewTopOffset;
                    }
                }
            }
        }
    }
    sonChildVCHeight = height;
    if (self.param.CustomDataViewHeight){
        sonChildVCHeight = self.param.CustomDataViewHeight(sonChildVCHeight);
    }
    if (self.param.MenuPosition == PageMenuPositionBottom){
        [self.upSc.dataView page_y:0];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc.mainView page_y:CGRectGetMaxY(self.upSc.dataView.frame)];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.mainView.frame)];
    }else if (self.param.MenuPosition == PageMenuPositionNavi) {
        [self.upSc.mainView removeFromSuperview];
        [self.upSc.dataView page_y:0];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.dataView.frame)];
        if ([self.parentResponder isKindOfClass:UIViewController.class] &&
            [(UIViewController*)self.parentResponder navigationController]) {
            [(UIViewController*)self.parentResponder navigationItem].titleView = self.upSc.mainView;
        }
    }else{
        [self.upSc.dataView page_y: CGRectGetMaxY(self.upSc.mainView.frame)];
        [self.upSc.dataView page_height:sonChildVCHeight];
        [self.upSc page_height:CGRectGetMaxY(self.upSc.dataView.frame)];
    }
    pageDataFrame = self.upSc.dataView.frame;
    
}

/// 设置头部
- (void)setUpHead{
    /// 头部视图
    if(self.param.MenuHeadView&&
       self.param.MenuPosition != PageMenuPositionNavi&&
       self.param.MenuPosition != PageMenuPositionBottom) {
       self.headViewSonView = self.param.MenuHeadView();
       self.headView.frame = CGRectMake(0,  0, self.headViewSonView.frame.size.width, self.headViewSonView.frame.size.height);
       [self.headView addSubview:self.headViewSonView];
       self.downSc.tableHeaderView = self.headView;
    }else{
       self.downSc.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, CGFLOAT_MIN)];
    }
    if (self.param.InsertHeadAndMenuBg) {
        self.head_MenuView = [UIView new];
        self.param.InsertHeadAndMenuBg(self.head_MenuView);
    }
    /// 全景
    if (self.head_MenuView) {
        self.head_MenuView.frame = CGRectMake(0, self.headView?CGRectGetMinX(self.headView.frame):CGRectGetMinX(self.upSc.frame), self.upSc.frame.size.width, CGRectGetMaxY(self.upSc.frame)-self.upSc.dataView.frame.size.height);
        [self.downSc addSubview:self.head_MenuView];
        [self.downSc sendSubviewToBack:self.head_MenuView];
        self.upSc.backgroundColor = [UIColor clearColor];
        self.upSc.mainView.backgroundColor = [UIColor clearColor];
        for (TFY_PageNavBtn *btn in self.upSc.btnArr) {
            btn.layer.backgroundColor = [UIColor clearColor].CGColor;
        }
        if (self.headView) self.headView.backgroundColor = [UIColor clearColor];
    }
}

/// 底部滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView != self.downSc) return;
    /// 头部放大效果
    if (self.headView && self.param.HeadScaling) {
        CGFloat width = self.bounds.size.width;
        CGFloat yOffset = scrollView.contentOffset.y;
        if (yOffset < 0) {
            CGFloat totalOffset = self.headSize.height + ABS(yOffset);
            CGFloat f = totalOffset / self.headSize.height;
            self.headViewSonView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
        }
    }
    if (![self canTopSuspension]) return;
    float yOffset  = scrollView.contentOffset.y;
    int topOffset = MAX(0, scrollView.contentSize.height - scrollView.frame.size.height);
    /// 防止从底部快速滑动瞬间到顶部 突兀的感觉 v1.4.3
    if (self.param.AvoidQuickScroll &&
        [self.currentScroll isKindOfClass:UIScrollView.class] &&
        self.currentScroll.contentOffset.y &&
        yOffset <= 0 &&
        self.mainLastOffset == topOffset) {
        scrollView.contentOffset = CGPointMake(self.downSc.contentOffset.x, topOffset);
        self.scrolTotop = YES;
        self.scrolToBottom = NO;
        return;
    }
    if (yOffset <= 0) {
        self.scrolToBottom = YES;
    }else{
        if (yOffset >= (topOffset - 1) || yOffset >= (topOffset + 1) || yOffset >= topOffset) scrollView.contentOffset = CGPointMake(self.downSc.contentOffset.x, topOffset);
        self.scrolTotop = (yOffset >= topOffset);
        self.scrolToBottom = NO;
    }
    if (self.scrolTotop) {
        self.sonCanScroll = YES;
        self.canScroll = (self.currentScroll.contentSize.height <= self.currentScroll.frame.size.height);
    }else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, topOffset);
        }else {
            self.sonCanScroll = NO;
        }
    }
    if (![self currentNotSuspennsion])
        [self.downSc setContentOffset:CGPointMake(0, topOffset) animated:NO];
    CGFloat delta = MIN(1, MAX(0, scrollView.contentOffset.y/topOffset));
    if (self.param.NaviAlpha) {
        if ([self.parentResponder isKindOfClass:UIViewController.class]) {
            if ([(UIViewController*)self.parentResponder navigationController] &&
                self.naviBarBackGround)
                self.naviBarBackGround.alpha =  delta;
        }
        if (self.param.HeaderScrollHide && self.headView)  self.headView.alpha = !(delta == 1);
    }
    if (self.param.EventChildVCDidSroll)
        self.param.EventChildVCDidSroll((id)self.parentResponder,self.downSc.contentOffset, self.downSc.contentOffset, self.downSc);
    /// 防止第一次加载不成功
    if (self.currentFootView&&
        self.currentFootView.frame.origin.y != self.footOriginY)
        [self.currentFootView page_y:self.footOriginY];
    self.mainLastOffset = yOffset;
}

/// 改变菜单栏高度
- (void)changeMenuFrame{
    if (!self.param.TopChangeHeight) return;
    if (self.upSc.mainView.frame.size.height == self.param.MenuHeight && !self.sonCanScroll)return;
    CGFloat offsetHeight = self.param.TopChangeHeight > 0?
    MIN(self.currentScroll.contentOffset.y, self.param.TopChangeHeight):
    MAX (-self.currentScroll.contentOffset.y, self.param.TopChangeHeight);
    if (self.upSc.mainView.frame.size.height == (self.param.MenuHeight + self.param.MenuInsets.bottom - self.param.TopChangeHeight)&& self.sonCanScroll&&offsetHeight == self.param.TopChangeHeight)  return;
    [self.upSc.mainView page_height:self.param.MenuHeight + self.param.MenuInsets.bottom -offsetHeight ];
    [self.upSc.dataView page_y:CGRectGetMaxY(self.upSc.mainView.frame)];
    [self.upSc.dataView page_height:pageDataFrame.size.height+offsetHeight];
    if (offsetHeight == 0) {
        if (self.param.EventMenuNormalHeight) self.param.EventMenuNormalHeight(self.upSc.btnArr);
    }else{
        if (self.param.EventMenuChangeHeight) self.param.EventMenuChangeHeight(self.upSc.btnArr,self.currentScroll.contentOffset.y);
    }
    if (self.param.MenuAnimal == PageTitleMenuAiQY||self.param.MenuAnimal == PageTitleMenuPDD){
        CGRect rect = self.upSc.lineView.frame;
        if (rect.origin.y != ([self.upSc.mainView getMainHeight]-self.param.MenuIndicatorY-rect.size.height/2)) {
            rect.origin.y = [self.upSc.mainView getMainHeight]-self.param.MenuIndicatorY-rect.size.height/2;
        }
        self.upSc.lineView.frame = rect;
    }
}

/// 设置悬浮
- (void)setUpSuspension:(UIResponder*)newVC index:(NSInteger)index end:(BOOL)end{
    if (![self canTopSuspension]) return;
    if ([newVC isKindOfClass:TFY_PageBaseController.class]) {
        TFY_PageBaseController *pageVC = (TFY_PageBaseController*)newVC;
        pageVC.downSc.canScroll = NO;
    }
    if ([newVC conformsToProtocol:@protocol(TFY_PageProtocol)]) {
        if ([newVC respondsToSelector:@selector(getMyScrollViews)]) {
            NSArray *arr = [newVC performSelector:@selector(getMyScrollViews)];
            [arr enumerateObjectsUsingBlock:^(UIScrollView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 [self topSuspensionView:obj index:index*1000+idx+100];
            }];
            self.currentScrollArr = arr;
        }
        if ([newVC respondsToSelector:@selector(fixFooterView)]) {
            UIView *tmpView = [newVC performSelector:@selector(fixFooterView)];
            if (!tmpView) return;
            [self.sonChildFooterViewDic setObject:tmpView forKey:@(index)];
            self.currentFootView = tmpView;
            [self addSubview:self.currentFootView];
            self.currentFootView.hidden = NO;
            footerViewIndex = index;
            [self.currentFootView page_y:self.footOriginY];
        }else{
            if (self.currentFootView && end && !self.param.FixFirst) self.currentFootView.hidden = YES;
        }
        if (![self currentNotSuspennsion]) {
            int topOffset = self.downSc.contentSize.height - self.downSc.frame.size.height;
            [self.downSc setContentOffset:CGPointMake(0, topOffset) animated:YES];
        }
    }else{
        self.currentScroll = nil;
        self.currentFootView  = nil;
    }
}

- (void)topSuspensionView:(UIScrollView*)view index:(NSInteger)index{
    if (view &&
        [view isKindOfClass:[UIScrollView class]]) {
        self.currentScroll = view;
        NSNumber *key = @(index);
        if (!self.sonChildScrollerViewDic[key]) {
            [view pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        }else{
            if (self.sonChildScrollerViewDic[key] != view) {
                UIView *tempView = self.sonChildScrollerViewDic[key];
                [tempView pageRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
                [view pageRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
                [view pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
            }
        }
        [self.sonChildScrollerViewDic setObject:view forKey:key];
        if (self.scrolToBottom)  [view setContentOffset:CGPointMake(view.contentOffset.x,0) animated:NO];
        if (!self.sonCanScroll && !self.scrolToBottom) [view setContentOffset:CGPointZero animated:NO];
    }
}

/// 底部左滑滚动
- (void)pageWithScrollView:(UIScrollView*)scrollView left:(BOOL)left{
    int offset = (int)scrollView.contentOffset.x%(int)self.upSc.frame.size.width;
    NSInteger index = floor(scrollView.contentOffset.x/self.upSc.frame.size.width);
    if (self.currentFootView) {
        int x = 0;
        if (scrollView.contentOffset.x > (self.upSc.frame.size.width * footerViewIndex)) {
           x -= offset;
        }else{
           x = (int)self.upSc.frame.size.width - offset;
        }
        if (offset == 0 && [self.sonChildFooterViewDic objectForKey:@(index)]) x = 0;
        if (!self.param.FixFirst) [self.currentFootView page_x: x];
    }
}

/// 选中按钮
- (void)selectBtnWithIndex:(NSInteger)index{
    if (!self.currentFootView) return;
    if (!self.param.FixFirst) [self.currentFootView page_x:0];
}

/// 监听子控制器中的滚动视图
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        TFY_PageBaseView *pageVC = self;
        if ([self.parentResponder isKindOfClass:UIViewController.class]) {
            UIViewController<TFY_PageScrollProcotol> *parentVC = (UIViewController<TFY_PageScrollProcotol>*)self.parentResponder;
            while ((parentVC = (TFY_PageBaseController*)[parentVC parentViewController])){
                if ([parentVC conformsToProtocol:@protocol(TFY_PageScrollProcotol)]) {
                    if (parentVC.param.TopSuspension &&
                        [parentVC.headViewSonView isKindOfClass:UIView.class] &&
                        parentVC.headViewSonView.frame.size.height){
                        pageVC = [parentVC valueForKey:@"pageView"];
                        break;
                    }
                }
            }
        }
        if (!pageVC) pageVC = self;
        if (![pageVC canTopSuspension]) return;
        if (![pageVC currentNotSuspennsion]) return;
        if (hadWillDisappeal) return;
        if (pageVC.currentScroll != object) pageVC.currentScroll = object;
        CGPoint newH = [[change objectForKey:@"new"] CGPointValue];
        CGPoint oldH = [[change objectForKey:@"old"] CGPointValue];
        if (newH.y == oldH.y) return;
        if (pageVC.param.Bounces) pageVC.scrolToBottom = NO;
        if (!pageVC.sonCanScroll &&
            !pageVC.scrolToBottom &&
            [pageVC.currentScroll isKindOfClass:UIScrollView.class]){
            pageVC.currentScroll.contentOffset = CGPointZero;
        }
        pageVC.mainLastOffset = pageVC.downSc.contentOffset.y;
        [self changeMenuFrame];
        if ((int)newH.y <= 0) {
            pageVC.canScroll = YES;
            if (pageVC.param.Bounces &&
                [pageVC.currentScroll isKindOfClass:UIScrollView.class]) pageVC.currentScroll.contentOffset = CGPointZero;
        }
    }
}

- (void)updateMenuData{
    [self removeKVO];
    footerViewIndex = -1;
    [self.upSc removeFromSuperview];
    [self.upSc.dataView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([self.parentResponder isKindOfClass:UIViewController.class]) {
        for (UIViewController *VC in [(UIViewController*)self.parentResponder childViewControllers]) {
            [VC willMoveToParentViewController:nil];
            [VC.view removeFromSuperview];
            [VC removeFromParentViewController];
        }
    }
    [self.cache removeAllObjects];
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    [self setUpUI:YES];
}

- (void)selectMenuWithIndex:(NSInteger)index{
    [self.upSc.btnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            [obj sendActionsForControlEvents:UIControlEventTouchUpInside];
            *stop = YES;
            return;
        }
    }];
}

- (void)updatePageController{
    [self removeKVO];
    [self.upSc removeFromSuperview];
    [self.downSc removeFromSuperview];
    self.downSc = nil;
    [self.cache removeAllObjects];
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    footerViewIndex = -1;
    [self.upSc.dataView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if ([self.parentResponder isKindOfClass:UIViewController.class]) {
        for (UIViewController *VC in [(UIViewController*)self.parentResponder childViewControllers]) {
            [VC willMoveToParentViewController:nil];
            [VC.view removeFromSuperview];
            [VC removeFromParentViewController];
        }
    }
    [self.param defaultProperties];
    [self setUpUI:YES];
}

- (void)updateHeadView{
    [self.headView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setUpHead];
}

- (void)updateTitle{
    [self.upSc.mainView updateUI];
}

- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;{
    if (CGPointEqualToPoint(point, CGPointZero)) {
        /// 顶点
        int topOffset = self.downSc.contentSize.height - self.downSc.frame.size.height;
        point = CGPointMake(self.downSc.contentOffset.x, topOffset);
        self.scrolTotop = YES;
    }else if(point.y == CGFLOAT_MIN){
        self.canScroll = YES;
    }
    [self.downSc setContentOffset:point animated:animat];
}

- (void)showData{
    [self.param defaultProperties];
    [self setUpUI:YES];
}

- (BOOL)addMenuTitleWithObjectArr:(NSArray<TFY_PageTitleModel*>*)insertArr{
    __block BOOL success = YES;
    [insertArr enumerateObjectsUsingBlock:^(TFY_PageTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [self addMenuTitleWithObject:obj];
        if (!result) success = NO;
    }];
    return success;
}

- (BOOL)deleteMenuTitleIndexArr:(NSArray*)deleteArr{
    __block BOOL success = YES;
    [deleteArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result =  [self deleteMenuTitleIndex:obj];
         if (!result) success = NO;
    }];
    return success;
}

- (BOOL)addMenuTitleWithObject:(TFY_PageTitleModel*)insertObject{
    if (!insertObject) return NO;
    /// 插入的位置
    NSInteger index = NSNotFound;
    index = MIN(MAX(insertObject.index, 0), self.param.TitleArr.count);
    if (index == NSNotFound || index < 0) return NO;
    id insertTitle = insertObject.titleInfo?:(insertObject.title);
    UIResponder* insertController = insertObject.controller;
    if (!insertTitle){NSLog(@"输入插入的标题"); return NO;}
    if (!insertController){NSLog(@"输入插入的控制器"); return NO;}
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.TitleArr];
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.Controllers];
    BOOL last = (index == self.param.TitleArr.count);
    
    last?[titleMarr addObject:insertTitle]:[titleMarr insertObject:insertTitle atIndex:index];
    self.param.TitleArr = [NSArray arrayWithArray:titleMarr];
    last?[controllerArr addObject:insertController]:[controllerArr insertObject:insertController atIndex:index];
    self.param.Controllers = [NSArray arrayWithArray:controllerArr];
    
    TFY_PageNavBtn *btn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
    TFY_PageNavBtn *temp = nil;
    if (index > 0) {
        temp = [self.upSc.btnArr objectAtIndex:MAX(0, index - 1)];
    }
    [self.upSc.mainView setPropertiesWithBtn:btn withIndex:index withTemp:temp];
    for (int i = 0; i<self.upSc.dataView.subviews.count; i++) {
        UIView *view = self.upSc.dataView.subviews[i];
        CGFloat x = index*self.upSc.dataView.frame.size.width;
        if (view.frame.origin.x>=x) {
            [view page_x:view.frame.origin.x + self.upSc.dataView.frame.size.width];
        }
    }
    TFY_PageNavBtn *currentBtn = nil;
    for (int i = 0 ; i<self.upSc.btnArr.count; i++) {
        TFY_PageNavBtn *btn = self.upSc.btnArr[i];
        if (i>=index) {
            [btn page_x:currentBtn?CGRectGetMaxX(currentBtn.frame):0];
        }
        currentBtn = btn;
        btn.tag = i;
    }
    
    NSMutableDictionary *mdic = [NSMutableDictionary new];
    [self.cache enumerateKeysAndObjectsUsingBlock:^(NSNumber*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSInteger keyNum = key.integerValue;
        if (keyNum >= index) {
            NSInteger saveKey = MIN(keyNum + 1, self.param.TitleArr.count - 1);
            [mdic setObject:obj forKey:@(saveKey)];
        }else{
            [mdic setObject:obj forKey:key];
        }
    }];
    self.upSc.dataView.totalCount = self.param.TitleArr.count;
    [self.cache removeAllObjects];
    [self.cache addEntriesFromDictionary:mdic];
    self.upSc.dataView.contentSize = CGSizeMake(self.param.TitleArr.count * self.upSc.dataView.pageWidth ,0);
    if (self.upSc.currentTitleIndex >= index) {
        self.upSc.currentTitleIndex += 1;
        self.upSc.dataView.contentOffset = CGPointMake(self.upSc.currentTitleIndex * self.upSc.dataView.frame.size.width, 0);
    }
    if ([self.cache objectForKey:@(self.upSc.currentTitleIndex)]) {
        self.upSc.currentVC = (id)[self.cache objectForKey:@(self.upSc.currentTitleIndex)];
    }
    [self.upSc.mainView resetMainViewContenSize:self.upSc.btnArr.lastObject];
    [self.upSc.mainView scrollToIndex:self.upSc.currentTitleIndex animal:NO];
    return YES;
}

- (BOOL)deleteMenuTitleIndex:(id)deleteObject{
    if (!deleteObject) return NO;
    NSInteger index = NSNotFound;
    if ([deleteObject isKindOfClass:[NSNumber class]]) {
        NSInteger currentIndex = [deleteObject integerValue];
        if (currentIndex < self.param.TitleArr.count) {
            index = currentIndex;
        }
    }else{
        index = [self.param.TitleArr indexOfObject:deleteObject];
    }
    
    if (index == NSNotFound || index < 0) return NO;
    if (self.upSc.btnArr.count >index) {
        UIView *deleteView = self.upSc.btnArr[index];
        [deleteView removeFromSuperview];
        deleteView = nil;
    }
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.TitleArr];
    if (titleMarr.count>index) {
        [titleMarr removeObjectAtIndex:index];
        self.param.TitleArr = [NSArray arrayWithArray:titleMarr];
    }
    if (self.upSc.btnArr&&self.upSc.btnArr.count>index) {
        [self.upSc.btnArr removeObjectAtIndex:index];
    }
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.Controllers];
    if (controllerArr.count>index) {
        [controllerArr removeObjectAtIndex:index];
        self.param.Controllers = [NSArray arrayWithArray:controllerArr];
    }
    
    if ([self.cache objectForKey:@(index)]) {
        if (self.upSc.dataView.subviews.count>index) {
            UIView *deleteView = self.upSc.dataView.subviews[index];
            [deleteView removeFromSuperview];
            [deleteView willMoveToSuperview:nil];
            deleteView = nil;
        }
        UIResponder *indexVC = [self.cache objectForKey:@(index)];
        if ([indexVC isKindOfClass:UIViewController.class]) {
            UIViewController *viewController = (UIViewController*)indexVC;
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
            viewController.view = nil;
        }else if([indexVC isKindOfClass:UIView.class]){
            UIView *tempView = (UIView*)indexVC;
            [tempView removeFromSuperview];
        }
        indexVC = nil;
        [self.cache removeObjectForKey:@(index)];
        UIView *obj = [self.sonChildScrollerViewDic objectForKey:@(index)];
        [obj pageRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
        [self.sonChildScrollerViewDic removeObjectForKey:@(index)];
    }
    
    for (int i = 0; i<self.upSc.dataView.subviews.count; i++) {
        UIView *view = self.upSc.dataView.subviews[i];
        CGFloat x = index*self.upSc.dataView.frame.size.width;
        if (view.frame.origin.x>x) {
            [view page_x:view.frame.origin.x - self.upSc.dataView.frame.size.width];
        }
    }
    TFY_PageNavBtn *temp = nil;
    for (int i = 0 ; i<self.upSc.btnArr.count; i++) {
        TFY_PageNavBtn *btn = self.upSc.btnArr[i];
        if (i>=index) {
            [btn page_x:temp?CGRectGetMaxX(temp.frame):0];
        }
        temp = btn;
    }
    self.upSc.dataView.totalCount = self.param.TitleArr.count;
    [self.upSc.mainView resetMainViewContenSize:self.upSc.btnArr.lastObject];
    self.upSc.dataView.contentSize = CGSizeMake(self.param.TitleArr.count * self.upSc.dataView.pageWidth,0);
    if (index == self.upSc.currentTitleIndex) {
        self.upSc.currentTitleIndex = NSNotFound;
        self.upSc.currentVC = nil;
        [self selectMenuWithIndex:MAX(0, MIN(index, self.param.TitleArr.count - 1))];
    }else if(index < self.upSc.currentTitleIndex){
        self.upSc.currentTitleIndex = MAX(self.upSc.currentTitleIndex - 1, 0);
        NSMutableDictionary *mdic = [NSMutableDictionary new];
        [self.cache enumerateKeysAndObjectsUsingBlock:^(NSNumber*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSInteger keyNum = key.integerValue;
            if (keyNum > index) {
                NSInteger saveKey = MAX(keyNum - 1, 0);
                [mdic setObject:obj forKey:@(saveKey)];
            }else{
                [mdic setObject:obj forKey:key];
            }
        }];
        [self.cache removeAllObjects];
        [self.cache addEntriesFromDictionary:mdic];
        if ([self.cache objectForKey:@(self.upSc.currentTitleIndex)]) {
            self.upSc.currentVC = (id)[self.cache objectForKey:@(self.upSc.currentTitleIndex)];
        }
        self.upSc.dataView.contentOffset = CGPointMake(self.upSc.currentTitleIndex * self.upSc.dataView.frame.size.width, 0);
    }
    [self.upSc.mainView scrollToIndex:self.upSc.currentTitleIndex animal:NO];
    return YES;
}

- (BOOL)exchangeMenuDataAtIndex:(NSInteger)index withMenuDataAtIndex:(NSInteger)replaceIndex{
    if (self.param.TitleArr.count < index ||
        self.param.TitleArr.count < replaceIndex) {
        NSLog(@"输入正确的index或replaceIndex");
        return NO;
    }
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.TitleArr];
    [titleMarr exchangeObjectAtIndex:index withObjectAtIndex:replaceIndex];
    self.param.TitleArr = [NSArray arrayWithArray:titleMarr];
    
    if (self.upSc.btnArr &&
        self.upSc.btnArr.count > index &&
        self.upSc.btnArr.count > replaceIndex) {
        [self.upSc.btnArr exchangeObjectAtIndex:index withObjectAtIndex:replaceIndex];
    }
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.Controllers];
    if (controllerArr.count > index &&
        controllerArr.count > replaceIndex) {
        [controllerArr exchangeObjectAtIndex:index withObjectAtIndex:replaceIndex];
        self.param.Controllers = [NSArray arrayWithArray:controllerArr];
    }
    if ([self.cache objectForKey:@(index)] || [self.cache objectForKey:@(replaceIndex)]) {
        UIResponder *indexVC = [self.cache objectForKey:@(index)];
        UIResponder *replaceVC = [self.cache objectForKey:@(replaceIndex)];
        if (replaceVC) {
            [self.cache removeObjectForKey:@(replaceIndex)];
            [self.cache setObject:replaceVC forKey:@(index)];
            UIView *currentView = nil;
            if ([replaceVC isKindOfClass:UIViewController.class]) {
                currentView = [(UIViewController*)replaceVC view];
            } else  if ([replaceVC isKindOfClass:UIView.class]) {
                currentView = (UIView*)replaceVC;
            }
            if (currentView)
                [currentView page_x:index * self.upSc.dataView.pageWidth];
        }
        if (indexVC) {
            [self.cache removeObjectForKey:@(index)];
            [self.cache setObject:indexVC forKey:@(replaceIndex)];
            
            UIView *currentView = nil;
            if ([replaceVC isKindOfClass:UIViewController.class]) {
                currentView = [(UIViewController*)indexVC view];
            } else  if ([replaceVC isKindOfClass:UIView.class]) {
                currentView = (UIView*)indexVC;
            }
            
            [currentView page_x:replaceIndex * self.upSc.dataView.pageWidth];
        }
        UIScrollView *indexScrollView = [self.sonChildScrollerViewDic objectForKey:@(index)];
        UIScrollView *replaceScrollView = [self.sonChildScrollerViewDic objectForKey:@(replaceIndex)];
        if (replaceScrollView) {
            [self.sonChildScrollerViewDic removeObjectForKey:@(replaceIndex)];
            [self.sonChildScrollerViewDic setObject:replaceScrollView forKey:@(index)];
        }
        if (indexScrollView) {
            [self.sonChildScrollerViewDic removeObjectForKey:@(index)];
            [self.sonChildScrollerViewDic setObject:indexScrollView forKey:@(replaceIndex)];
        }
        if (self.upSc.currentTitleIndex == index) {
            self.upSc.dataView.contentOffset = CGPointMake(replaceIndex * self.upSc.dataView.pageWidth, 0);
            self.upSc.currentTitleIndex = replaceIndex;
        }
        if ([self.cache objectForKey:@(self.upSc.currentTitleIndex)]) {
            self.upSc.currentVC = (id)[self.cache objectForKey:@(self.upSc.currentTitleIndex)];
        }
    }
    TFY_PageNavBtn *temp = nil;
    for (int i = 0 ; i<self.upSc.btnArr.count; i++) {
        TFY_PageNavBtn *btn = self.upSc.btnArr[i];
        [btn page_x:temp?CGRectGetMaxX(temp.frame):0];
        temp = btn;
    }
    [self.upSc.mainView resetMainViewContenSize:self.upSc.btnArr.lastObject];
    [self.upSc.mainView scrollToIndex:self.upSc.currentTitleIndex animal:NO];
    return YES;
}

- (BOOL)canTopSuspension{
    if (!self.param.TopSuspension
       ||self.param.MenuPosition == PageMenuPositionBottom
        ||self.param.MenuPosition == PageMenuPositionNavi) return NO;
    if (!self.param.TitleArr.count) return NO;
    return YES;
}

/// 某个子控制不悬浮
- (BOOL)currentNotSuspennsion{
    if (self.param.TitleArr.count > self.upSc.currentTitleIndex) {
        id data = self.param.TitleArr[self.upSc.currentTitleIndex];
        if ([data isKindOfClass:[NSDictionary class]] &&
            data[TFY_PageKeyCanTopSuspension] &&
            ![data[TFY_PageKeyCanTopSuspension] boolValue]) return NO;
    }
    return YES;
}

- (NSMutableDictionary<NSNumber *,UIResponder *> *)cache{
    return _cache ?: ({ _cache = NSMutableDictionary.new;});
}

- (NSMutableDictionary<NSNumber *,__kindof UIScrollView *> *)sonChildScrollerViewDic{
    return _sonChildScrollerViewDic ?: ({ _sonChildScrollerViewDic = NSMutableDictionary.new;});
}

- (NSMutableDictionary<NSNumber *,__kindof UIView *> *)sonChildFooterViewDic{
    return _sonChildFooterViewDic ?: ({ _sonChildFooterViewDic = NSMutableDictionary.new;});
}

- (TFY_PageScroller *)downSc{
    if (!_downSc) {
        _downSc = [[TFY_PageScroller alloc]initWithFrame:CGRectMake(0, 0, PageVCWidth, PageVCHeight) style:UITableViewStyleGrouped];
        _downSc.delegate = self;
    }
    return _downSc;
}

- (UIView *)headView{
    return _headView ?_headView:({_headView = UIView.new;});
}

- (CGFloat)footOriginY{
    return _footOriginY ?_footOriginY:({_footOriginY = CGRectGetMaxY(self.downSc.frame) - self.currentFootView.frame.size.height;});
}

- (CGSize)headSize{
    return _headSize.width && _headSize.height ?_headSize:({_headSize = self.headView.frame.size;});
}
    
- (CGFloat)headHeight{
    _headHeight = self.headView.frame.size.height;
    return _headHeight;
}

- (void)setCurrentScroll:(UIScrollView *)currentScroll{
    _currentScroll = currentScroll;
    self.downSc.currentScroll = currentScroll;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (void)removeKVO{
    [self.sonChildScrollerViewDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, __kindof UIScrollView * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj pageRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
    }];
}

- (void)dealloc{
    [self removeKVO];
}


@end
