//
//  TFY_PageBaseController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageBaseController.h"

@interface TFY_PageBaseController () <UITableViewDelegate>{
    BOOL hadWillDisappeal;
    /// 视图消失时候的导航栏透明度 有透明度变化的时候
    NSNumber *lastAlpah;
    /// 视图出现时候的导航栏透明度
    NSNumber *enterAlpah;
    /// 视图出现时候的导航栏透明度
    NSMutableArray <NSString*>*procotolMethodArr;
    /// 菜单为屏幕宽度
    BOOL menuScreen;
}
@end

@implementation TFY_PageBaseController
/// 为了兼容旧版本 所以也实现TFY_PageScrollProcotol 协议
@synthesize param = _param ;
@synthesize upSc = _upSc;
@synthesize downSc = _downSc;
@synthesize cache = _cache;
@synthesize sonChildScrollerViewDic = _sonChildScrollerViewDic;
@synthesize sonChildFooterViewDic = _sonChildFooterViewDic;
@synthesize headView = _headView;
@synthesize headViewSonView = _headViewSonView;
@synthesize naviBarBackGround = _naviBarBackGround;

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.naviBarBackGround && self.param.naviAlpha)  lastAlpah = @(self.naviBarBackGround.alpha);
    hadWillDisappeal = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.naviBarBackGround && self.param.naviAlpha) {
        lastAlpah = @(self.naviBarBackGround.alpha);
        self.naviBarBackGround.alpha = enterAlpah ? enterAlpah.floatValue:1;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNaviUI];
}

/// 导航栏设置
- (void)setNaviUI{
    hadWillDisappeal = NO;
    if (self.navigationController && self.param.naviAlpha) {
        self.naviBarBackGround.alpha = 0;
        if (self.naviBarBackGround && lastAlpah){
            self.naviBarBackGround.alpha = lastAlpah.floatValue;
            return;
        }
        if (self.param.naviAlphaAll) {
            self.naviBarBackGround = self.navigationController.navigationBar;
            enterAlpah = @(self.naviBarBackGround.alpha);
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
                    if ([[UIDevice currentDevice].systemVersion intValue] >= 11 && [[UIDevice currentDevice].systemVersion intValue] < 13){
                       if ([NSStringFromClass([view class]) isEqualToString:@"UIVisualEffectView"]) {
                           self.naviBarBackGround = view;
                           enterAlpah = @(self.naviBarBackGround.alpha);
                           self.naviBarBackGround.alpha = 0;
                           break;
                       }
                   }else{
                       if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]||[NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"]) {
                           self.naviBarBackGround = view;
                           enterAlpah = @(self.naviBarBackGround.alpha);
                           self.naviBarBackGround.alpha = 0;
                           break;
                       }
                   }
               }
           }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pageView performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
}

- (void)showData{
    self.pageView.frame = self.view.bounds;
    [self.view addSubview:self.pageView];
    [self.view sendSubviewToBack:self.pageView];
    if ([self.pageView respondsToSelector:@selector(showData)])
        [self.pageView performSelector:@selector(showData) withObject:nil];
    
    /// 获取协议内属性 兼容旧版本
    unsigned int propertiesCount = 0;
    objc_property_t *properties = protocol_copyPropertyList(@protocol(TFY_PageScrollProcotol),&propertiesCount);
    for (int i = 0; i < propertiesCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if (![propertyName isEqualToString:@"naviBarBackGround"] && ![propertyName isEqualToString:@"param"])
            [self setValue:[self.pageView valueForKey:propertyName] forKey:propertyName];
        
    }
    free(properties);
    
    self.pageView.naviBarBackGround = self.naviBarBackGround;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    return YES;
}

/// 消息转发 兼容旧版本
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if ([procotolMethodArr indexOfObject:NSStringFromSelector(aSelector)] != NSNotFound &&
        [self.pageView respondsToSelector:aSelector]) {
        return self.pageView;
    }
    return self;
}

- (void)setParam:(TFY_PageParam *)param{
    _param = param;
    if (self.param.deviceChange)
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    menuScreen = (self.param.menuWidth == PageVCWidth);
    if (self.pageView) {
        [self.pageView removeFromSuperview];
    }
    self.pageView = [[TFY_PageBaseView alloc]initWithFrame:self.view.bounds autoFix:YES source:YES param:param parentReponder:self];
    self.downSc = self.pageView.downSc;
    self.downSc.delegate = self;
    if (self.param.menuPosition == PageMenuPositionNavi||
        self.param.menuPosition == PageMenuPositionBottom ||
        !self.param.lazyLoading) {
        [self showData];
    }else{
        [self performSelector:@selector(showData) withObject:nil afterDelay:CGFLOAT_MIN];
    }
}

/// 横竖屏通知
- (void)change:(NSNotification*)notification{
    if (!self.param.deviceChange) return;
    BOOL change = ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
                   [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
    [self changeLeft:change];
}

/// 横竖屏改变frame
- (void)changeLeft:(BOOL)left{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self->menuScreen) {
            self.param.menuWidth = PageVCWidth;
        }
        self.pageView.frame = self.view.bounds;
        [self.pageView setUpUI:NO];
    });
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (void)dealloc{
    if (self.param.deviceChange)
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
