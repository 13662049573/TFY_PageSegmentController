//
//  TFY_PageBaseController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageBaseController.h"

@interface TFY_PageBaseController () {
    BOOL hadWillDisappeal;
    NSInteger footerViewIndex;
    CGFloat sonChildVCHeight;
    CGFloat sonChildVCY;
    CGRect pageDataFrame;
    CGRect pageUpScFrame;
}
//当前子控制器中的滚动视图
@property(nonatomic,strong)UIScrollView *currentScroll;
//子控制器中的滚动视图数组(底部有多层的情况)
@property(nonatomic,strong)NSArray *currentScrollArr;
//当前子控制器中需要固定的底部视图
@property(nonatomic,strong)UIView *currentFootView;
//头部视图
@property(nonatomic,strong)UIView *headView;
//头部视图菜单栏底部的占位视图(如有需要)
@property(nonatomic,strong)UIView *head_MenuView;
//视图消失时候的导航栏透明度 有透明度变化的时候
@property(nonatomic,strong)NSNumber *lastAlpah;
//视图出现时候的导航栏透明度
@property(nonatomic,strong)NSNumber *enterAlpah;
//底部tableView是否可以滚动
@property (nonatomic, assign) BOOL canScroll;
//onTableView是否可以滚动
@property (nonatomic, assign) BOOL sonCanScroll;
//到达顶部
@property (nonatomic, assign) BOOL scrolTotop;
//到达底部
@property (nonatomic, assign) BOOL scrolToBottom;
//headHeight
@property (nonatomic, assign) CGFloat headHeight;
@end

@implementation TFY_PageBaseController

- (void)viewDidLoad{
    self.topheightsuction = 0;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.naviBarBackGround&&self.param.naviAlpha) {
        self.lastAlpah = @(self.naviBarBackGround.alpha);
    }
     hadWillDisappeal = YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.naviBarBackGround&&self.param.naviAlpha) {
        self.lastAlpah = @(self.naviBarBackGround.alpha);
        self.naviBarBackGround.alpha = self.enterAlpah?self.enterAlpah.floatValue:1;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    hadWillDisappeal = NO;
    if (self.navigationController&&self.param.naviAlpha) {
        self.naviBarBackGround.alpha = 0;
        if (self.naviBarBackGround&&self.lastAlpah){
            self.naviBarBackGround.alpha = self.lastAlpah.floatValue;
            return;
        }
        if (self.param.naviAlphaAll) {
            self.naviBarBackGround = self.navigationController.navigationBar;
            self.enterAlpah = @(self.naviBarBackGround.alpha);
            [self.naviBarBackGround setAlpha:0];
        }else{
           NSMutableArray *loop= [NSMutableArray new];
           [loop addObject:[self.navigationController.navigationBar subviews]];
           while (loop.count) {
               NSArray *arr = loop.lastObject;
               [loop removeLastObject];
               for (NSInteger i = arr.count - 1; i >= 0; i--) {
                   UIView *view = arr[i];
                   [loop addObject:view.subviews];
                   if ([[UIDevice currentDevice].systemVersion intValue]>=12&&[[UIDevice currentDevice].systemVersion intValue]<13){
                       if ([NSStringFromClass([view class]) isEqualToString:@"UIVisualEffectView"]) {
                           self.naviBarBackGround = view;
                           self.enterAlpah = @(self.naviBarBackGround.alpha);
                           [self.naviBarBackGround setAlpha:0];
                            break;
                       }
                   }else{
                       if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]||[NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"]) {
                           self.naviBarBackGround = view;
                           self.enterAlpah = @(self.naviBarBackGround.alpha);
                           [self.naviBarBackGround setAlpha:0];
                           break;
                       }
                   }
               }
           }
        }
        
    }
    
}

- (void)setParam{
    if (self.param.menuAnimal == PageTitleMenuAiQY) {
        if (!self.param.menuIndicatorWidth) {
            self.param.menuIndicatorWidth = 20;
        }
    }
    
    if (self.param.menuAnimal == PageTitleMenuNone||
        self.param.menuAnimal == PageTitleMenuCircleBg||
        self.param.menuAnimal == PageTitleMenuCircle||
        self.param.menuAnimal == PageTitleMenuPDD) {
        self.param.menuAnimalTitleGradient = NO;
        if (self.param.menuAnimal == PageTitleMenuPDD) {
            if (!self.param.menuIndicatorWidth) {
                self.param.menuIndicatorWidth = 25;
            }
        }
    }
    
    if (self.param.menuAnimal == PageTitleMenuCircle) {
        if (CGColorEqualToColor(self.param.menuIndicatorColor.CGColor, PageColor(0xE5193E).CGColor)) {
            self.param.menuIndicatorColor = PageColor(0xe1f9fe);
        }
        if (CGColorEqualToColor(self.param.menuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor)) {
            self.param.menuTitleSelectColor = PageColor(0x00baf9);
        }
        if (self.param.menuIndicatorHeight <= 15.0f) {
            self.param.menuIndicatorHeight = 0;
        }
    }else if (self.param.menuAnimal == PageTitleMenuCircleBg) {
        if (CGColorEqualToColor(self.param.menuSelectTitleBackground.CGColor, [UIColor clearColor].CGColor)) {
            self.param.menuSelectTitleBackground = [UIColor orangeColor];
        }
        if (CGColorEqualToColor(self.param.menuTitleSelectColor.CGColor, PageColor(0xE5193E).CGColor)) {
            self.param.menuTitleSelectColor = [UIColor whiteColor];
        }
        if (!self.param.menuCellMarginY) {
            self.param.menuCellMarginY = 10.f;
        }
        if (!self.param.menuBottomMarginY) {
            self.param.menuBottomMarginY = 10.f;
        }
    }
    if (self.param.menuPosition == PageMenuPositionNavi) {
        if (CGColorEqualToColor(self.param.menuBgColor.CGColor, PageColor(0xffffff).CGColor)) {
            self.param.menuBgColor = [UIColor clearColor];
        }
        if (self.param.menuHeight == 55.0f) {
            self.param.menuHeight = 40.0f;
        }
    }
    if (self.param.menuSpecifial == PageSpecialTypeOne) {
        if (self.param.menuHeight == 55.0f) {
            self.param.menuHeight = 75.0f;
        }
    }
    
}


- (void)UI{
    BOOL nest = NO;
    self.cache = [NSMutableDictionary new];
    footerViewIndex = -1;
    CGFloat headY = 0;
    CGFloat tabbarHeight = 0;
    CGFloat statusBarHeight = 0;
    if (self.presentingViewController) {
        if (!self.navigationController) {
            statusBarHeight = PageVCStatusBarHeight;
        }
    } else if (self.tabBarController) {
        if (!self.tabBarController.tabBar.translucent) {
            tabbarHeight = 0;
        }else{
            tabbarHeight = PageVCTabBarHeight;
        }
    } else if (self.navigationController){
        headY = (!self.param.fromNavi&&
                  self.param.menuPosition != PageMenuPositionBottom)?0:
       (!self.navigationController.navigationBar.translucent?0:PageVCNavBarHeight);
    }
    if (self.parentViewController) {
        if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *naPar = (UINavigationController*)self.parentViewController;
            headY = (!self.param.fromNavi&&
            self.param.menuPosition != PageMenuPositionBottom)?0:
            (!naPar.navigationBar.translucent?0:(naPar.isNavigationBarHidden?PageVCStatusBarHeight:PageVCNavBarHeight));
            //davidli- Update 2020.11.27 适配隐藏导航栏时距离顶部的高度
            if (self.parentViewController.tabBarController) {
                if (!self.parentViewController.tabBarController.tabBar.translucent) {
                    tabbarHeight = 0;
                }else{
                    tabbarHeight = PageVCTabBarHeight;
                }
            }
        }else if ([self.parentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *ta = (UITabBarController*)self.parentViewController;
            if (!ta.tabBar.translucent) {
                tabbarHeight = 0;
            }else{
                tabbarHeight = PageVCTabBarHeight;
            }
            if (self.parentViewController.navigationController) {
                headY = (!self.param.fromNavi&&
                self.param.menuPosition != PageMenuPositionBottom)?0:(!self.parentViewController.navigationController.navigationBar.translucent?0:PageVCNavBarHeight);
            }else if(self.parentViewController.presentingViewController){
                statusBarHeight = PageVCStatusBarHeight;
            }
        }else if ([self.parentViewController isKindOfClass:[TFY_PageBaseController class]]) {
            headY = 0;
            tabbarHeight = 0;
            statusBarHeight = 0;
            nest = YES;
        }
    }
    
    if (self.hidesBottomBarWhenPushed&&tabbarHeight>=PageVCTabBarHeight) {
        tabbarHeight -= PageVCTabBarHeight;
    }
    
    if (self.param.customNaviBarY) {
        headY = self.param.customNaviBarY(headY);
    }
    if (self.param.customTabbarY) {
        tabbarHeight = self.param.customTabbarY(tabbarHeight);
    }

    //全屏
    if (self.navigationController) {
        for (UIGestureRecognizer *gestureRecognizer in self.upSctableView.gestureRecognizers) {
             [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
        }
    }
    
    self.upSctableView.delegate = self;
    self.upSctableView.bounces = self.param.bounces;
    self.upSctableView.frame = CGRectMake(0, headY, self.view.frame.size.width, self.view.frame.size.height-headY-tabbarHeight);
    self.upSctableView.canScroll = [self canTopSuspension];
    self.upSctableView.scrollEnabled = [self canTopSuspension];
    self.upSctableView.fromNavi = self.param.fromNavi;
    [self.view addSubview:self.upSctableView];
    
   //滚动和菜单视图
    if (self.param.titleArr.count>0) {
        self.upScHerder = [[TFY_PageLoopView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) param:self.param];
        self.upScHerder.loopDelegate = self;
        self.upSctableView.tableFooterView = self.upScHerder;
    }
    
    if (nest) {
        TFY_PageBaseController *superVC = (TFY_PageBaseController*)self.parentViewController;
        self.upScHerder.dataView.level = superVC.upScHerder.dataView.level - 1;
    }
    
    if (self.param.customMenuTitle) {
        self.param.customMenuTitle(self.upScHerder.btnArr);
    }
    //底部
    
    if (self.param.titleArr.count>0) {
        [self setUpMenuAndDataViewFrame];
    }
    [self setUpHead];
    self.canScroll = YES;
    self.scrolToBottom = YES;
    
    [self.upSctableView reloadData];
    [self.upSctableView layoutIfNeeded];
    
    [self selectMenuWithIndex:self.param.menuDefaultIndex];
    
}

- (void)setUpMenuAndDataViewFrame{
    sonChildVCY = 0;
    sonChildVCHeight = 0;
    CGFloat titleMenuhHeight = self.upScHerder.mainView.frame.size.height + self.param.menuCellMarginY;
    if (self.param.menuPosition == PageMenuPositionNavi) {
        sonChildVCY = 0;
        sonChildVCHeight = self.upSctableView.frame.size.height;
    }else if (self.param.menuPosition == PageMenuPositionBottom) {
        sonChildVCY = 0;
        if (self.param.menuSpecifial == PageSpecialTypeOne) {
            sonChildVCHeight = self.upSctableView.frame.size.height;
        }else{
            sonChildVCHeight = self.upSctableView.frame.size.height - titleMenuhHeight;
        }
    }else{
        sonChildVCY = 0;
        sonChildVCHeight = self.upSctableView.frame.size.height - titleMenuhHeight;
    }

    CGFloat height = [self canTopSuspension]?sonChildVCHeight :(sonChildVCHeight-self.headHeight);
    
    if ([self canTopSuspension]) {
        if (!self.parentViewController) {
            height -=PageVCStatusBarHeight;
        }else{
            if (![self.parentViewController isKindOfClass:[TFY_PageBaseController class]]) {
                if (self.navigationController&&![self.navigationController isNavigationBarHidden]) {
                    if (!self.param.fromNavi) {
                        height -= (self.navigationController.navigationBar.translucent?PageVCNavBarHeight:0);
                        
                    }
                }else{
                    height -= PageVCStatusBarHeight;
                }
            }
        }
    }

    sonChildVCHeight = height;
    
    if (self.param.customDataViewHeight) {
        sonChildVCHeight = self.param.customDataViewHeight(sonChildVCHeight);
    }

    if (self.param.menuPosition == PageMenuPositionBottom){
        if (self.param.menuSpecifial == PageSpecialTypeOne) {
            [self.upScHerder.dataView page_y:0];
            [self.upScHerder.dataView page_height:sonChildVCHeight];
            [self.upScHerder.mainView page_y:sonChildVCHeight-titleMenuhHeight];
            [self.upScHerder page_height:CGRectGetMaxY(self.upScHerder.mainView.frame)];
            [self.upScHerder bringSubviewToFront:self.upScHerder.mainView];
        }else{
            [self.upScHerder.dataView page_y:0];
            [self.upScHerder.dataView page_height:sonChildVCHeight];
            [self.upScHerder.mainView page_y:CGRectGetMaxY(self.upScHerder.dataView.frame)];
            [self.upScHerder page_height:CGRectGetMaxY(self.upScHerder.mainView.frame)];
        }
    }else if (self.param.menuPosition == PageMenuPositionNavi && self.navigationController) {
        [self.upScHerder.mainView removeFromSuperview];
        [self.upScHerder.dataView page_y:0];
        [self.upScHerder.dataView page_height:sonChildVCHeight];
        [self.upScHerder page_height:CGRectGetMaxY(self.upScHerder.dataView.frame)];
        self.navigationItem.titleView = self.upScHerder.mainView;
    }else{
        [self.upScHerder.dataView page_y:CGRectGetMaxY(self.upScHerder.mainView.frame)+self.param.menuBottomMarginY];
        [self.upScHerder.dataView page_height:sonChildVCHeight];
        [self.upScHerder page_height:CGRectGetMaxY(self.upScHerder.dataView.frame)];
    }
    self.param.titleHeight = self.upScHerder.mainView.frame.size.height + self.param.menuCellMarginY + self.param.menuBottomMarginY;
    self.upSctableView.menuTitleHeight = self.param.titleHeight;
    pageDataFrame = self.upScHerder.dataView.frame;
    pageUpScFrame = self.upScHerder.frame;
}

- (void)setUpHead{
    //头部视图
    if(self.param.menuHeadView&&
       self.param.menuPosition != PageMenuPositionNavi&&
       self.param.menuPosition != PageMenuPositionBottom) {
       self.headView = self.param.menuHeadView();
       self.headView.frame = CGRectMake(self.headView.frame.origin.x,  0, self.headView.frame.size.width, self.headView.frame.size.height);
        self.upSctableView.tableHeaderView = self.headView;
    }else{
        self.upSctableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake( 0, 0,self.view.frame.size.width, 0.01)];
    }
    if (self.param.insertHeadAndMenuBg) {
        self.head_MenuView = [UIView new];
        self.param.insertHeadAndMenuBg(self.head_MenuView);
    }
    //全景
    if (self.head_MenuView) {
        self.head_MenuView.frame = CGRectMake(0, self.headView?CGRectGetMinX(self.headView.frame):CGRectGetMinX(self.upScHerder.frame), self.upScHerder.frame.size.width, CGRectGetMaxY(self.upScHerder.frame)-self.upScHerder.dataView.frame.size.height);
        [self.upSctableView addSubview:self.head_MenuView];
        [self.upSctableView sendSubviewToBack:self.head_MenuView];
        self.upScHerder.backgroundColor = [UIColor clearColor];
        self.upScHerder.mainView.backgroundColor = [UIColor clearColor];
        for (TFY_PageNavBtn *btn in self.upScHerder.btnArr) {
            btn.layer.backgroundColor = [UIColor clearColor].CGColor;
        }
        if (self.headView) {
            self.headView.backgroundColor = [UIColor clearColor];
        }
    }
}

//底部滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.param.titleArr.count > 0) {
        
    if (scrollView!=self.upSctableView) return;
    if (![self canTopSuspension]) return;
    //偏移量
    float yOffset  = scrollView.contentOffset.y;
    //顶点
    int topOffset = scrollView.contentSize.height - scrollView.frame.size.height - self.topheightsuction;
    if (yOffset<=0) {
          self.scrolToBottom = YES;
    }else{
          if (yOffset >= topOffset) {
              scrollView.contentOffset = CGPointMake(self.upSctableView.contentOffset.x, topOffset);
              self.scrolTotop = YES;
          }else{
              self.scrolTotop = NO;
          }
          self.scrolToBottom = NO;
      }
    if (self.scrolTotop) {
        self.sonCanScroll = YES;
        if (self.currentScroll.contentSize.height<=self.currentScroll.frame.size.height) {
            self.canScroll = YES;
        }else{
            self.canScroll = NO;
        }
    }else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, topOffset);
        }else {
            self.sonCanScroll = NO;
        }
    }
    if (![self currentNotSuspennsion]) {
        [self.upSctableView setContentOffset:CGPointMake(0, topOffset) animated:NO];
    }
    CGFloat delta = scrollView.contentOffset.y/topOffset;
    if (delta>1) {
        delta = 1;
    }else if (delta < 0){
        delta = 0;
    }
    if (self.param.naviAlpha) {
        if (self.navigationController&&self.naviBarBackGround) {
            self.naviBarBackGround.alpha =  delta;
        }
        if (self.headView) {
            if (delta == 1) {
                self.headView.alpha = 0;
            }else{
                self.headView.alpha = 1;
            }
        }
    }
    if (self.param.eventChildVCDidSroll) {
        self.param.eventChildVCDidSroll(self,topOffset, self.upSctableView.contentOffset, self.upSctableView);
    }
    //防止第一次加载不成功
    if (self.currentFootView&&
        self.currentFootView.frame.origin.y!=
        self.footViewOrginY) {
        [self.currentFootView page_y:self.footViewOrginY];
    }
    }
}



//改变菜单栏高度
- (void)changeMenuFrame{
    if (!self.param.topChangeHeight) return;
    if (self.upScHerder.mainView.frame.size.height == self.param.titleHeight&&!self.sonCanScroll)return;
    CGFloat offsetHeight = self.param.topChangeHeight>0?MIN(self.currentScroll.contentOffset.y, self.param.topChangeHeight):MAX (-self.currentScroll.contentOffset.y, self.param.topChangeHeight);
    if (self.upScHerder.mainView.frame.size.height == (self.param.titleHeight-self.param.topChangeHeight)&&self.sonCanScroll&&offsetHeight == self.param.topChangeHeight)  return;
    [self.upScHerder.mainView page_height:self.param.titleHeight-offsetHeight];
    [self.upScHerder.dataView page_y:CGRectGetMaxY(self.upScHerder.mainView.frame)];
    [self.upScHerder.dataView page_height:pageDataFrame.size.height+offsetHeight];
    if (offsetHeight == 0) {
        if (self.param.eventMenuNormalHeight) {
            self.param.eventMenuNormalHeight(self.upScHerder.btnArr);
        }
    }else{
        if (self.param.eventMenuChangeHeight) {
            self.param.eventMenuChangeHeight(self.upScHerder.btnArr,self.currentScroll.contentOffset.y);
        }
    }
     if (self.param.menuAnimal == PageTitleMenuAiQY||self.param.menuAnimal == PageTitleMenuPDD){
        CGRect rect = self.upScHerder.lineView.frame;
        if (rect.origin.y != ([self.upScHerder.mainView getMainHeight]-self.param.menuIndicatorY-rect.size.height/2)) {
            rect.origin.y = [self.upScHerder.mainView getMainHeight]-self.param.menuIndicatorY-rect.size.height/2;
        }
        self.upScHerder.lineView.frame = rect;
    }
}
//设置悬浮
- (void)setUpSuspension:(UIViewController*)newVC index:(NSInteger)index end:(BOOL)end{
    if (![self canTopSuspension]) return;
    if ([newVC conformsToProtocol:@protocol(TFY_PageProtocol)]) {
        UIScrollView *view = nil;
        if ([newVC respondsToSelector:@selector(getMyScrollViews)]) {
            NSArray *arr = [newVC performSelector:@selector(getMyScrollViews)];
            [arr enumerateObjectsUsingBlock:^(UIScrollView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 [self topSuspensionView:obj index:index*1000+idx+100];
            }];
            self.currentScrollArr = arr;
        }else{
            if ([newVC respondsToSelector:@selector(getMyTableView)]) {
                UIScrollView *tmpView = [newVC performSelector:@selector(getMyTableView)];
                if (tmpView&&[tmpView isKindOfClass:[UIScrollView class]]) {
                    view = tmpView;
                }
            }else if([newVC respondsToSelector:@selector(getMyScrollView)]){
                UIScrollView *tmpView = [newVC performSelector:@selector(getMyScrollView)];
                if (tmpView&&[tmpView isKindOfClass:[UIScrollView class]]) {
                    view = tmpView;
                }
            }
            [self topSuspensionView:view index:index];
        }

        if ([newVC respondsToSelector:@selector(fixFooterView)]) {
            UIView *tmpView = [newVC performSelector:@selector(fixFooterView)];
            [self.sonChildFooterViewDic setObject:view forKey:@(index)];
            self.currentFootView = tmpView;
            [self.view addSubview:self.currentFootView];
            self.currentFootView.hidden = NO;
            footerViewIndex = index;
            [self.currentFootView page_y:self.footViewOrginY];
        }else{
            if (self.currentFootView&&
                end) {
                if (!self.param.fixFirst) {
                    self.currentFootView.hidden = YES;
                }
            }
        }
        if (![self currentNotSuspennsion]) {
            int topOffset = self.upSctableView.contentSize.height - self.upSctableView.frame.size.height - self.topheightsuction;
            [self.upSctableView setContentOffset:CGPointMake(0, topOffset) animated:YES];
        }
    }else{
        self.currentScroll = nil;
        self.currentFootView  = nil;
    }
}

- (void)topSuspensionView:(UIScrollView*)view index:(NSInteger)index{
    if (view&&[view isKindOfClass:[UIScrollView class]]) {
        self.currentScroll = view;
        if (view) {
            [self.sonChildScrollerViewDic setObject:view forKey:[NSString stringWithFormat:@"%ld",(long)index]];
        }
        if (self.scrolToBottom) {
            [view setContentOffset:CGPointMake(view.contentOffset.x,0) animated:NO];
        }
        if (!self.sonCanScroll&&!self.scrolToBottom) {
            [view setContentOffset:CGPointZero animated:NO];
        }
        @try {
          [view pageAddObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        } @catch (NSException *exception) {
            
        }
    }
}

//底部左滑滚动
- (void)pageWithScrollView:(UIScrollView*)scrollView left:(BOOL)left{
    int offset = (int)scrollView.contentOffset.x%(int)self.upScHerder.frame.size.width;
    NSInteger index = floor(scrollView.contentOffset.x/self.upScHerder.frame.size.width);
    if (self.currentFootView) {
        int x = 0;
        CGFloat width = self.footViewSizeWidth;
        if (left) {
            if (scrollView.contentOffset.x>(self.upScHerder.frame.size.width*footerViewIndex)) {
                x = 0;
                width -= offset;
            }else{
                x = (int)self.upScHerder.frame.size.width - offset;
            }
        }else{
            if (scrollView.contentOffset.x>(self.upScHerder.frame.size.width*footerViewIndex)) {
               x = 0;
               width -= offset;
            }else{
               x = (int)self.upScHerder.frame.size.width - offset;
            }
        }
        if (offset == 0 && [self.sonChildFooterViewDic objectForKey:@(index)]) {
            x = self.footViewOrginX;
        }
        if (!self.param.fixFirst) {
            [self.currentFootView page_x: x];
            [self.currentFootView page_width:width];
        }
    }
}


//选中按钮
- (void)selectBtnWithIndex:(NSInteger)index{
    if (self.currentFootView) {
        if (!self.param.fixFirst) {
            [self.currentFootView page_x:self.footViewOrginX];
        }
    }
}

//监听子控制器中的滚动视图
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (![self canTopSuspension]) return;
        if (![self currentNotSuspennsion]) return;
        if (hadWillDisappeal) return;
        if (self.currentScroll!=object){
            self.currentScroll = object;
        };
        CGPoint newH = [[change objectForKey:@"new"] CGPointValue];
        CGPoint newOld = [[change objectForKey:@"old"] CGPointValue];
        if (newH.y==newOld.y)  return;
        if (!self.sonCanScroll&&!self.scrolToBottom) {
            self.currentScroll.contentOffset = CGPointZero;
            self.upSctableView.showsVerticalScrollIndicator = NO;
            self.currentScroll.showsVerticalScrollIndicator = NO;
        }else{
            self.upSctableView.showsVerticalScrollIndicator = NO;
            self.currentScroll.showsVerticalScrollIndicator = NO;
        }
        [self changeMenuFrame];
        if ((int)newH.y<=0) {
            self.canScroll = YES;
            if (self.param.bounces) {
                self.currentScroll.contentOffset = CGPointZero;
            }
        }
    }
}


- (void)updateMenuData{
    [self removeKVO];
    footerViewIndex = -1;
    for (UIViewController *VC in self.childViewControllers) {
        [VC willMoveToParentViewController:nil];
        [VC.view removeFromSuperview];
        [VC removeFromParentViewController];
    }
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    [self UI];
}

/*
*手动调用菜单到第index个
*/
- (void)selectMenuWithIndex:(NSInteger)index{
    [self.upScHerder.btnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            [obj sendActionsForControlEvents:UIControlEventTouchUpInside];
            *stop = YES;
        }
    }];
}

//更新
- (void)updatePageController{
    [self removeKVO];
    [self.upScHerder removeFromSuperview];
    [self.upSctableView removeFromSuperview];
    self.upSctableView = nil;
    [self.sonChildScrollerViewDic removeAllObjects];
    [self.sonChildFooterViewDic removeAllObjects];
    self.sonChildScrollerViewDic = [NSMutableDictionary new];
    self.sonChildFooterViewDic = [NSMutableDictionary new];
    footerViewIndex = -1;
    for (UIViewController *VC in self.childViewControllers) {
        [VC willMoveToParentViewController:nil];
        [VC.view removeFromSuperview];
        [VC removeFromParentViewController];
    }
    [self setParam];
    [self UI];
}

//更新头部
- (void)updateHeadView{
    [self setUpHead];
}

//标题数量内容不变情况下只更新内容 (高度需要提前布置好 这里不更新标题的高度)
- (void)updateTitle{
    [self.upScHerder.btnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj&&[obj isKindOfClass:[TFY_PageNavBtn class]]) {
            NSString *string = [obj titleForState:UIControlStateNormal];
            if (self.param.titleArr&&self.param.titleArr.count>idx) {
                string = self.param.titleArr[idx];
            }
            [obj setTitle:string forState:UIControlStateNormal];
        }
    }];
}
/*
*底部手动滚动  传入CGPointZero则为吸顶临界点
*/
- (void)downScrollViewSetOffset:(CGPoint)point animated:(BOOL)animat;{
    if (CGPointEqualToPoint(point, CGPointZero)) {
        //顶点
        int topOffset = self.upSctableView.contentSize.height - self.upSctableView.frame.size.height - self.topheightsuction;
        point = CGPointMake(self.upSctableView.contentOffset.x, topOffset);
        self.scrolTotop = YES;
    }
    [self.upSctableView setContentOffset:point animated:animat];
}

//动态插入菜单数组
- (BOOL)addMenuTitleWithObjectArr:(NSArray<TFY_PageTitleModel*>*)insertArr{
    __block BOOL success = YES;
    [insertArr enumerateObjectsUsingBlock:^(TFY_PageTitleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [self addMenuTitleWithObject:obj];
        if (!result) {
            success = NO;
        }
    }];
    return success;
}


//动态删除菜单数组
- (BOOL)deleteMenuTitleIndexArr:(NSArray*)deleteArr{
    __block BOOL success = YES;
    [deleteArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result =  [self deleteMenuTitleIndex:obj];
        if (!result) {
            success = NO;
        }
    }];
    return success;
}

//动态插入菜单数据
- (BOOL)addMenuTitleWithObject:(TFY_PageTitleModel*)insertObject{
    if (!insertObject) return NO;
    //插入的位置
    NSInteger index = NSNotFound;
    index = MIN(MAX(insertObject.index, 0), self.param.titleArr.count);
    if (index == NSNotFound || index < 0) return NO;
    id insertTitle = insertObject.titleInfo?:(insertObject.title);
    UIViewController* insertController = insertObject.controller;
    if (!insertTitle){NSLog(@"输入插入的标题"); return NO;}
    if (!insertController){NSLog(@"输入插入的控制器"); return NO;}
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.titleArr];
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.controllers];
    BOOL last = (index == self.param.titleArr.count);
    
    last?[titleMarr addObject:insertTitle]:[titleMarr insertObject:insertTitle atIndex:index];
    self.param.titleArr = [NSArray arrayWithArray:titleMarr];
    last?[controllerArr addObject:insertController]:[controllerArr insertObject:insertController atIndex:index];
    self.param.controllers = [NSArray arrayWithArray:controllerArr];
    
    TFY_PageNavBtn *btn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
    TFY_PageNavBtn *temp = [self.upScHerder.btnArr objectAtIndex:MAX(0, index - 1)];
    [self.upScHerder.mainView setPropertiesWithBtn:btn withIndex:index withTemp:temp];
    for (int i = 0; i<self.upScHerder.dataView.subviews.count; i++) {
        UIView *view = self.upScHerder.dataView.subviews[i];
        CGFloat x = index*self.upScHerder.dataView.frame.size.width;
        if (view.frame.origin.x>=x) {
            [view page_x:view.frame.origin.x + self.upScHerder.dataView.frame.size.width];
        }
    }
    TFY_PageNavBtn *currentBtn = nil;
    for (int i = 0 ; i<self.upScHerder.btnArr.count; i++) {
        TFY_PageNavBtn *btn = self.upScHerder.btnArr[i];
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
            NSInteger saveKey = MIN(keyNum + 1, self.param.titleArr.count - 1);
            [mdic setObject:obj forKey:@(saveKey)];
        }else{
            [mdic setObject:obj forKey:key];
        }
    }];
    self.cache = [NSMutableDictionary dictionaryWithDictionary:mdic];
    if (self.upScHerder.currentTitleIndex >= index) {
        self.upScHerder.dataView.contentOffset = CGPointMake(self.upScHerder.dataView.contentOffset.x + self.upScHerder.dataView.frame.size.width, 0);
        self.upScHerder.currentTitleIndex+=1;
    }
    
    [self.upScHerder.mainView resetMainViewContenSize:self.upScHerder.btnArr.lastObject];
    self.upScHerder.dataView.contentSize = CGSizeMake(self.param.titleArr.count*PageVCWidth,0);
    return YES;
}

// 动态删除菜单数据
- (BOOL)deleteMenuTitleIndex:(id)deleteObject{
    if (!deleteObject) return NO;
    NSInteger index = NSNotFound;
    if ([deleteObject isKindOfClass:[NSNumber class]]) {
        NSInteger currentIndex = [deleteObject integerValue];
        if (currentIndex < self.param.titleArr.count) {
            index = currentIndex;
        }
    }else{
        index = [self.param.titleArr indexOfObject:deleteObject];
    }
    
    if (index == NSNotFound || index < 0) return NO;
    if (self.upScHerder.mainView.subviews.count>index) {
        UIView *deleteView = self.upScHerder.mainView.subviews[index];
        [deleteView removeFromSuperview];
        deleteView = nil;
    }
    NSMutableArray *titleMarr = [NSMutableArray arrayWithArray:self.param.titleArr];
    if (titleMarr.count>index) {
        [titleMarr removeObjectAtIndex:index];
        self.param.titleArr = [NSArray arrayWithArray:titleMarr];
    }
    if (self.upScHerder.btnArr&&self.upScHerder.btnArr.count>index) {
        [self.upScHerder.btnArr removeObjectAtIndex:index];
    }
    NSMutableArray *controllerArr = [NSMutableArray arrayWithArray:self.param.controllers];
    if (controllerArr.count>index) {
        [controllerArr removeObjectAtIndex:index];
        self.param.controllers = [NSArray arrayWithArray:controllerArr];
    }
    if ([self.cache objectForKey:@(index)]) {
        if (self.upScHerder.dataView.subviews.count>index) {
            UIView *deleteView = self.upScHerder.dataView.subviews[index];
            [deleteView removeFromSuperview];
            deleteView = nil;
        }
        UIViewController *indexVC = [self.cache objectForKey:@(index)];
        [indexVC willMoveToParentViewController:nil];
        [indexVC.view removeFromSuperview];
        [indexVC removeFromParentViewController];
        indexVC.view = nil;
        indexVC = nil;
        [self.cache removeObjectForKey:@(index)];
        UIView *obj = [self.sonChildScrollerViewDic objectForKey:@(index)];
        [obj paegRemoveObserver:obj forKeyPath:@"contentOffset" context:nil];
        [self.sonChildScrollerViewDic removeObjectForKey:@(index)];
    }
    for (int i = 0; i<self.upScHerder.dataView.subviews.count; i++) {
        UIView *view = self.upScHerder.dataView.subviews[i];
        CGFloat x = index*self.upScHerder.dataView.frame.size.width;
        if (view.frame.origin.x>x) {
            [view page_x:view.frame.origin.x - self.upScHerder.dataView.frame.size.width];
        }
    }
    TFY_PageNavBtn *temp = nil;
    for (int i = 0 ; i<self.upScHerder.btnArr.count; i++) {
        TFY_PageNavBtn *btn = self.upScHerder.btnArr[i];
        if (i>=index) {
            [btn page_x:temp?CGRectGetMaxX(temp.frame):0];
        }
        temp = btn;
    }
    [self.upScHerder.mainView resetMainViewContenSize:self.upScHerder.btnArr.lastObject];
    self.upScHerder.dataView.contentSize = CGSizeMake(self.param.titleArr.count*PageVCWidth,0);
    if (index == self.upScHerder.currentTitleIndex) {
        self.upScHerder.currentTitleIndex = NSNotFound;
        self.upScHerder.currentVC = nil;
        [self selectMenuWithIndex:MAX(0, MIN(index, self.param.titleArr.count - 1))];
    }else if(index < self.upScHerder.currentTitleIndex){
        self.upScHerder.currentTitleIndex = MAX(self.upScHerder.currentTitleIndex - 1, 0);
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
        self.cache = [NSMutableDictionary dictionaryWithDictionary:mdic];
        self.upScHerder.dataView.contentOffset = CGPointMake(MAX(0, self.upScHerder.dataView.contentOffset.x - self.upScHerder.dataView.frame.size.width) , 0);
    }
    return YES;
}
//数据
- (void)showData{
    [self setParam];
    [self UI];
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
//某个子控制不悬浮
- (BOOL)currentNotSuspennsion{
    if (self.param.titleArr.count > self.upScHerder.currentTitleIndex) {
        id data = self.param.titleArr[self.upScHerder.currentTitleIndex];
        if ([data isKindOfClass:[NSDictionary class]] &&
            data[@"canTopSuspension"]
            &&![data[@"canTopSuspension"] boolValue]) {
            return NO;
        }
    }
    return YES;
}
- (NSMutableDictionary *)sonChildScrollerViewDic{
    if (!_sonChildScrollerViewDic) {
        _sonChildScrollerViewDic =  [NSMutableDictionary new];
    }
    return _sonChildScrollerViewDic;
}
- (NSMutableDictionary *)sonChildFooterViewDic{
    if (!_sonChildFooterViewDic) {
        _sonChildFooterViewDic = [NSMutableDictionary new];
    }
    return _sonChildFooterViewDic;
}
- (TFY_PageTableView *)upSctableView{
    if (!_upSctableView) {
        _upSctableView = [[TFY_PageTableView alloc]initWithFrame:CGRectMake(0, 0, PageVCWidth, PageVCHeight) style:UITableViewStyleGrouped];
    }
    return _upSctableView;
}
- (CGFloat)footViewOrginY{
    if (!_footViewOrginY) {
        _footViewOrginY = CGRectGetMaxY(self.upSctableView.frame)-self.currentFootView.frame.size.height;
    }
    return _footViewOrginY;
}
- (CGFloat)headHeight{
    _headHeight = self.headView.frame.size.height;
    return _headHeight;
}
- (CGFloat)footViewSizeWidth{
    if (!_footViewSizeWidth) {
        _footViewSizeWidth = self.upScHerder.frame.size.width;
    }
    return _footViewSizeWidth;
}
- (void)setParam:(TFY_PageParam *)param{
    _param = param;
    if ([self.parentViewController isKindOfClass:[TFY_PageBaseController class]]||
        self.param.menuPosition == PageMenuPositionNavi||
        self.param.menuPosition == PageMenuPositionBottom) {
        [self showData];
    }else{
        if (self.param.lazyLoading) {
            [self performSelector:@selector(showData) withObject:nil afterDelay:CGFLOAT_MIN];
        }else{
            [self showData];
        }
    }
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.cache removeAllObjects];
    [self.sonChildScrollerViewDic removeAllObjects];
}

- (void)removeKVO{
    [self.sonChildScrollerViewDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        @try {
            [obj paegRemoveObserver:self forKeyPath:@"contentOffset" context:nil];
        }@catch (NSException *exception) {

        }
    }];
}
- (void)dealloc{
    [self removeKVO];
}

@end
