//
//  TFY_PageMunuView.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageMunuView.h"

@interface TFY_PageMunuView (){
    TFY_PageNavBtn *_btnLeft;
    TFY_PageNavBtn *_btnRight;
    TFY_PageNavBtn *_btnDownRepeat;
    CGFloat fixAllWidth;
}
@end

@implementation TFY_PageMunuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.bounces = NO;
        self.currentTitleIndex = NSNotFound;
        self.bouncesZoom = NO;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)setParam:(TFY_PageParam *)param{
    _param = param;
    [self UI];
}

/// UI
- (void)UI{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.btnArr = [NSMutableArray new];
    [self addSubview:self.containView];
    TFY_PageNavBtn *temp = nil;
    for (int i = 0; i<self.param.titleArr.count; i++) {
        TFY_PageNavBtn *btn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
        [self setPropertiesWithBtn:btn withIndex:i withTemp:temp];
        temp = btn;
    }
    if (self.param.customMenuView) self.param.customMenuView(self);
    /// 指示器
    [self setUpIndicator];
    /// 右边固定标题
    [self setUpFixRightBtn:temp];
    if (temp) [self resetMainViewContenSize:temp];
    /// 最底部固定线
    if (self.param.insertMenuLine) {
        self.bottomView = [UIView new];
        self.bottomView.backgroundColor = PageColor(0x999999);
        self.bottomView.frame = CGRectMake(0, self.frame.size.height - PageK1px, self.frame.size.width, PageK1px);
    }
    if (self.bottomView) {
        CGRect lineRect = self.bottomView.frame;
        lineRect.origin.y = self.frame.size.height- lineRect.size.height;
        if (!lineRect.size.width) lineRect.size.width = self.frame.size.width;
        self.bottomView.frame = lineRect;
        [self addSubview:self.bottomView];
        self.param.insertMenuLine(self.bottomView);
    }
}

- (void)updateUI{
    [self.btnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnArr removeAllObjects];
    TFY_PageNavBtn *temp = nil;
    for (int i = 0; i< self.param.titleArr.count; i++) {
        TFY_PageNavBtn *btn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
        if (!btn) continue;
        [self setPropertiesWithBtn:btn withIndex:i withTemp:temp];
        temp = btn;
        
        if (i == self.param.titleArr.count - 1)
            [self resetMainViewContenSize:btn];
        
        if (self.lastBTN) {
            if (i == self.lastBTN.tag) self.lastBTN = btn;
        }else{
            if (i == self.currentTitleIndex) self.lastBTN = btn;
        }
    }
    [self scrollToIndex:self.lastBTN.tag animal:NO];
}

- (void)setDefaultSelect:(NSInteger)index{
    if (self.btnArr.count <= index) return;
    [self.btnArr[index] sendActionsForControlEvents:UIControlEventTouchUpInside];
}

/// 重置contensize
- (void)resetMainViewContenSize:(TFY_PageNavBtn*)btn{
    self.scrollEnabled = (CGRectGetMaxX(btn.frame) > self.frame.size.width);
    self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
    CGRect rect = self.frame;
    if (self.contentSize.width < self.frame.size.width &&
        self.param.menuPosition == PageMenuPositionCenter &&
        self.param.menuWidth == PageVCWidth) {
        rect.size.width = self.contentSize.width;
        rect.origin.x = (PageVCWidth - rect.size.width)/2;
        self.frame = rect;
    }
    if (self.btnArr.count) {
        [self sendSubviewToBack:self.containView];
        self.containView.frame = CGRectMake(self.btnArr.firstObject.frame.origin.x, btn.frame.origin.y, CGRectGetMaxX(btn.frame), btn.frame.size.height);
    }
    if (self.fixBtnArr) {
        self.contentSize = CGSizeMake(self.contentSize.width + fixAllWidth, 0);
        self.scrollEnabled = (CGRectGetMaxX(btn.frame) > (self.frame.size.width - fixAllWidth));
    }
}

/// 初始化指示器
- (void)setUpIndicator{
    self.lineView = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
    if (self.param.menuIndicatorImage) {
        [self.lineView setImage:[UIImage imageNamed:self.param.menuIndicatorImage] forState:UIControlStateNormal];
    }else{
        self.lineView.backgroundColor = self.param.menuIndicatorColor;
    }
    [self addSubview:self.lineView];
    if (self.param.menuAnimal == PageTitleMenuCircle) {
        self.lineView.userInteractionEnabled = NO;
        [self sendSubviewToBack:self.lineView];
    }
    self.lineView.hidden = (self.param.menuAnimal == PageTitleMenuNone||
                            self.param.menuAnimal == PageTitleMenuTouTiao||
                            self.param.menuAnimal == PageTitleMenuCircleBg||
                            self.param.menuAnimal == PageTitleMenuJD);
    if (self.param.menuIndicatorRadio) {
        self.lineView.layer.cornerRadius = self.param.menuIndicatorRadio;
        self.lineView.layer.masksToBounds = YES;
    }
}

- (void)setUpFixRightBtn:(TFY_PageNavBtn*)temp{
    if (self.param.menuFixRightData) {
        self.fixBtnArr = [NSMutableArray new];
        NSMutableArray *fixData = [NSMutableArray new];
        if ([self.param.menuFixRightData isKindOfClass:[NSArray class]]) {
            fixData = [NSMutableArray arrayWithArray:self.param.menuFixRightData];
        }else{
            [fixData addObject:self.param.menuFixRightData];
        }
        CGFloat allWidth = 0;
        for (int i = ((int)fixData.count - 1); i >= 0 ; i--) {
            id info = fixData[i];
            TFY_PageNavBtn *fixBtn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
            fixBtn.config = info;
            CGFloat menuFixWidth = [self getTitleData:info key:TFY_PageKeyTitleWidth]?[[self getTitleData:info key:TFY_PageKeyTitleWidth] floatValue]:self.param.menuFixWidth;
            CGFloat originY = [self getTitleData:info key:TFY_PageKeyTitleMarginY]?[[self getTitleData:info key:TFY_PageKeyTitleMarginY] floatValue]:(temp.frame.origin.y + self.param.menuInsets.top);
            CGFloat menuFixHeight = [self getTitleData:info key:TFY_PageKeyTitleHeight]?[[self getTitleData:info key:TFY_PageKeyTitleHeight] floatValue]:temp.frame.size.height;
            id text = [self getTitleData:info key:TFY_PageKeyName];
            if (!text && self.param.customTitleContent) {
                text =  self.param.customTitleContent(info,i);
            }
            id selectText = [self getTitleData:info key:TFY_PageKeySelectName];
            id image = [self getTitleData:info key:TFY_PageKeyImage];
            id selectImage = [self getTitleData:info key:TFY_PageKeySelectImage];
            id titleColor = [self getTitleData:info key:TFY_PageKeyTitleColor]?:self.param.menuTitleColor;
            id titleSelectColor = [self getTitleData:info key:TFY_PageKeyTitleSelectColor]?:self.param.menuTitleSelectColor;
            if (text) {
                if ([text isKindOfClass:NSString.class]) [fixBtn setTitle:text forState:UIControlStateNormal];
                else if ([text isKindOfClass:NSAttributedString.class]) [fixBtn setAttributedTitle:text forState:UIControlStateNormal];
                fixBtn.normalText = text;
            }
            if (selectText) {
                if ([selectText isKindOfClass:NSString.class]) [fixBtn setTitle:selectText forState:UIControlStateSelected];
                else if ([selectText isKindOfClass:NSAttributedString.class]) [fixBtn setAttributedTitle:selectText forState:UIControlStateSelected];
                fixBtn.selectText = selectText;
            }
            if (image){
                if ([image isKindOfClass:NSString.class]) {
                    [fixBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
                }else if ([image isKindOfClass:UIImage.class]) {
                    [fixBtn setImage:image forState:UIControlStateNormal];
                }
            }
            if (selectImage && image){
                if ([selectImage isKindOfClass:NSString.class]) {
                    [fixBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
                }else if ([selectImage isKindOfClass:UIImage.class]) {
                    [fixBtn setImage:selectImage forState:UIControlStateSelected];
                }
            }
            if (text && image) menuFixWidth += 30;
            allWidth += menuFixWidth;
            fixBtn.titleLabel.font = self.param.menuTitleUIFont;
            [fixBtn setTitleColor:titleColor forState:UIControlStateNormal];
            [fixBtn setTitleColor:titleSelectColor forState:UIControlStateSelected];
            fixBtn.frame = CGRectMake(CGRectGetMaxX(self.frame)-allWidth, originY, menuFixWidth, menuFixHeight);
            fixBtn.tag = 10086+i;
            fixBtn.backgroundColor = temp.backgroundColor;
            [self addSubview:fixBtn];
            [self bringSubviewToFront:fixBtn];
            CGFloat margin = [self getTitleData:info key:TFY_PageKeyImageOffset]?[[self getTitleData:info key:TFY_PageKeyImageOffset] floatValue]:self.param.menuImageMargin;
            if (image) [fixBtn tagSetImagePosition:self.param.menuImagePosition spacing:margin];
            if (self.param.menuFixShadow) {
               [fixBtn viewShadowPathWithColor:PageColor(0x333333) shadowOpacity:0.8 shadowRadius:3 shadowPathType:PageShadowPathLeft shadowPathWidth:2];
                fixBtn.alpha = 0.9;
            }
            [fixBtn setAdjustsImageWhenHighlighted:NO];
            [fixBtn addTarget:self action:@selector(fixTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.fixBtnArr addObject:fixBtn];
        }
        fixAllWidth = allWidth;
        if (self.param.customMenufixTitle) self.param.customMenufixTitle(self.fixBtnArr);
    }
}

/// 设置按钮样式
- (void)setPropertiesWithBtn:(TFY_PageNavBtn*)btn withIndex:(NSInteger)i  withTemp:(TFY_PageNavBtn*)temp{
    CGFloat margin = self.param.menuCellMargin;
    btn.param = self.param;
    btn.titleLabel.font = self.param.menuTitleUIFont;
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    id titleInfo = self.param.titleArr[i];
    btn.config = titleInfo;
    id selectColor = [self getTitleData:titleInfo key:TFY_PageKeyTitleSelectColor]?:self.param.menuTitleSelectColor;
    id color = [self getTitleData:titleInfo key:TFY_PageKeyTitleColor]?:self.param.menuTitleColor;
    [btn setTitleColor:selectColor?:self.param.menuTitleSelectColor forState:UIControlStateSelected];
    [btn setTitleColor:color forState:UIControlStateNormal];
    id name = [self getTitleData:titleInfo key:TFY_PageKeyName];
    if (!name && self.param.customTitleContent) {
        name =  self.param.customTitleContent(titleInfo,i);
    }
    if (name) {
        if ([name isKindOfClass:NSString.class]) [btn setTitle:name forState:UIControlStateNormal];
        else if ([name isKindOfClass:NSAttributedString.class]) [btn setAttributedTitle:name forState:UIControlStateNormal];
        btn.normalText = name;
    }
    id selectText = [self getTitleData:titleInfo key:TFY_PageKeySelectName];
    if (selectText) {
        if ([selectText isKindOfClass:NSString.class]) [btn setTitle:selectText forState:UIControlStateSelected];
        else if ([selectText isKindOfClass:NSAttributedString.class]) [btn setAttributedTitle:selectText forState:UIControlStateSelected];
        btn.selectText = selectText;
    }
    CGSize size =  btn.maxSize;
    /// 设置图片
    id image = [self getTitleData:titleInfo key:TFY_PageKeyImage];
    id selectImage = [self getTitleData:titleInfo key:TFY_PageKeySelectImage];
    id onlyClick = [self getTitleData:titleInfo key:TFY_PageKeyOnlyClick];
    id onlyAnClick = [self getTitleData:titleInfo key:TFY_PageKeyOnlyClickWithAnimal];
    id titleBackground = [self getTitleData:titleInfo key:TFY_PageKeyTitleBackground];
    if (!titleBackground) titleBackground = self.param.menuTitleBackground ?: UIColor.clearColor;
    if (titleBackground) btn.backgroundColor = titleBackground;
    if (image) {
        if ([image isKindOfClass:NSString.class]) {
            [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }else if ([image isKindOfClass:UIImage.class]) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    if (onlyClick) btn.tapType = PageBTNTapNone;
    if (onlyAnClick) btn.tapType = PageBTNTapAnimalNone;
    if (image && selectImage){
        if ([selectImage isKindOfClass:NSString.class]) {
            [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        }else if ([selectImage isKindOfClass:UIImage.class]) {
            [btn setImage:selectImage forState:UIControlStateSelected];
        }
    }
    if (size.width == 0 && image) size.width = 20.0f;
    if (size.height == 0 && image) size.height = 20.0f;
    btn.maxSize = size;
    if (image) {
        if (self.param.menuImagePosition == PageBtnPositionLeft || self.param.menuImagePosition == PageBtnPositionRight ) {
            margin += 20;
            margin += self.param.menuImageMargin;
        }
        if (self.param.menuImagePosition == PageBtnPositionTop || self.param.menuImagePosition == PageBtnPositionBottom ) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
    }
    if (self.param.menuPosition != PageMenuPositionNavi) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    CGFloat btnWidth = [self getTitleData:titleInfo key:TFY_PageKeyTitleWidth]?[[self getTitleData:titleInfo key:TFY_PageKeyTitleWidth] floatValue]:(self.param.menuTitleWidth?:(size.width + margin));
    CGFloat marginX = 0;
    CGFloat originY = [self getTitleData:titleInfo key:TFY_PageKeyTitleMarginY]?[[self getTitleData:titleInfo key:TFY_PageKeyTitleMarginY] floatValue]:0;
    CGFloat btnHeight = [self getTitleData:titleInfo key:TFY_PageKeyTitleHeight]?[[self getTitleData:titleInfo key:TFY_PageKeyTitleHeight] floatValue]:self.param.menuHeight;
    btn.tag = i;
    if (temp) {
        marginX = [self getTitleData:titleInfo key:TFY_PageKeyTitleMarginX]?[[self getTitleData:titleInfo key:TFY_PageKeyTitleMarginX] floatValue]:self.param.menuTitleOffset;
        btn.frame = CGRectMake((CGRectGetMaxX(temp.frame)+marginX), originY, btnWidth, btnHeight);
    }else{
        marginX = [self getTitleData:titleInfo key:TFY_PageKeyTitleMarginX]?[[self getTitleData:titleInfo key:TFY_PageKeyTitleMarginX] floatValue]:0;
        btn.frame = CGRectMake(marginX, originY, btnWidth, btnHeight);
    }
    /// 设置右上角红点
    NSString *badge = [self getTitleData:titleInfo key:TFY_PageKeyBadge];
    if (badge) [btn showBadgeWithTopMagin:self.param.titleArr[i]];
    if (self.param.menuAnimal == PageTitleMenuCircleBg &&
        self.param.menuTitleRadios == 0) self.param.menuTitleRadios = btnHeight/2;
    if (self.param.menuTitleRadios) btn.layer.cornerRadius = self.param.menuTitleRadios;
    CGFloat imageMargin = [self getTitleData:titleInfo key:TFY_PageKeyImageOffset]?[[self getTitleData:titleInfo key:TFY_PageKeyImageOffset] floatValue]:self.param.menuImageMargin;
    if (image) [btn tagSetImagePosition:self.param.menuImagePosition spacing:imageMargin];

    if (self.btnArr.count>i) {
        if ([self.btnArr indexOfObject:btn] == NSNotFound)
            [self.btnArr insertObject:btn atIndex:i];
        
        if ([self.subviews indexOfObject:btn] == NSNotFound)
            [self insertSubview:btn atIndex:i];
        
    }else{
        if ([self.btnArr indexOfObject:btn] == NSNotFound)
            [self.btnArr addObject:btn];
        
        if ([self.subviews indexOfObject:btn] == NSNotFound)
            [self addSubview:btn];
    }
}

/// 解析字典
- (NSString*)getTitleData:(id)model key:(NSString*)key{
    if ([model isKindOfClass:[NSString class]] || [model isKindOfClass:[NSAttributedString class]])  return [key isEqualToString:TFY_PageKeyName] ? model : nil;
    else if ([model isKindOfClass:[NSDictionary class]]) return [model objectForKey:key] ? : nil;
    return nil;
}

/// 点击
- (void)tap:(TFY_PageNavBtn*)btn{
    [self showDistination:btn];
    if (self.lastBTN == btn && !btn.tapType) {
        if (self.param.eventClick) self.param.eventClick(btn, btn.tag);
        return;
    }
    NSInteger index = [self.btnArr indexOfObject:btn];
    if (index == NSNotFound || index > self.btnArr.count) return;
    
    if (!btn.tapType || btn.tapType == PageBTNTapAnimalNone) {
        [self scrollToIndex:index animal:YES];
    }
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)])[self.menuDelegate titleClick:btn fix:NO];
}

- (void)showDistination:(TFY_PageNavBtn *)sender {
    if (sender == _btnDownRepeat) {
        _btnDownRepeat.selected = !_btnDownRepeat.selected;
        if (self.param.eventDownRepeatClick) self.param.eventDownRepeatClick(_btnDownRepeat, !_btnDownRepeat.selected);
    } else {
        _btnDownRepeat = sender;
    }
}

/// 固定标题点击
- (void)fixTap:(TFY_PageNavBtn*)btn{
    if (self.fixLastBtn)  self.fixLastBtn.selected = NO;
    btn.selected = YES;
    if (self.param.eventFixedClick) self.param.eventFixedClick(btn, btn.tag);
    self.fixLastBtn = btn;
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)]) [self.menuDelegate titleClick:btn fix:YES];
}

- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal{
    if (self.btnArr.count <= newIndex) return;
    if (animal && !self.lastBTN) animal = NO;
    TFY_PageNavBtn *btn = self.btnArr[newIndex];
    if (self.lastBTN) {
        self.lastBTN.selected = NO;
        self.lastBTN.titleLabel.font = self.param.menuTitleUIFont;
        if (self.param.menuTitleBackground) self.lastBTN.layer.backgroundColor = self.param.menuTitleBackground.CGColor;
        if (self.lastBTN.layer.backgroundColor && !self.param.menuTitleBackground) self.lastBTN.layer.backgroundColor = UIColor.clearColor.CGColor;
        if ([self getTitleData:self.lastBTN.config key:TFY_PageKeyImage]) {
            [self.lastBTN tagSetImagePosition:self.param.menuImagePosition spacing:[self getTitleData:self.lastBTN.config key:TFY_PageKeyImageOffset]?[[self getTitleData:self.lastBTN.config key:TFY_PageKeyImageOffset] floatValue]:self.param.menuImageMargin];
        }
        if (self.param.menuAnimal == PageTitleMenuJD && self.lastBTN != btn){
            [self.lastBTN jdRemoveLayer];
        }
    }
    btn.selected = YES;
    /// 隐藏右上角红点
    [btn hidenBadge];
    /// 改变背景色
    NSArray* backgroundColor = (NSArray*)[self getTitleData:self.param.titleArr[newIndex] key:TFY_PageKeyBackgroundColor];
    /// 改变指示器颜色
    id indicatorColor = [self getTitleData:self.param.titleArr[newIndex] key:TFY_PageKeyIndicatorColor];
    UIColor *tempBackgroundColor = self.param.menuBgColor;
    UIColor *fixBackgroundColor = self.param.menuBgColor;
    if (backgroundColor) {
        /// 渐变色
        if ([backgroundColor isKindOfClass:[NSArray class]]) {
            if ([backgroundColor count] > 1) {
                tempBackgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(self.contentSize.width, self.frame.size.height) direction:PageGradientChangeDirectionLevel startColor:backgroundColor[0] endColor:backgroundColor[1]];
                fixBackgroundColor = backgroundColor[1];
            }else{
                tempBackgroundColor = backgroundColor[0];
                fixBackgroundColor = tempBackgroundColor;
            }
        }else if ([backgroundColor isKindOfClass:[UIColor class]]){
                 tempBackgroundColor = (UIColor*)backgroundColor;
                 fixBackgroundColor = tempBackgroundColor;
        }
    }
    if (!self.param.insertHeadAndMenuBg && self.param.didScrollMenuColorChange)
        self.backgroundColor = tempBackgroundColor;
    if (!self.param.menuIndicatorImage) self.lineView.backgroundColor = indicatorColor?:self.param.menuIndicatorColor;
    [self.fixBtnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.param.didScrollMenuColorChange) {
            obj.backgroundColor = fixBackgroundColor;
        }
        if (!CGColorEqualToColor(self.param.menuBgColor.CGColor, fixBackgroundColor.CGColor)) {
            [obj setTitleColor:[btn titleColorForState:UIControlStateSelected] forState:UIControlStateNormal];
        }
    }];
    btn.titleLabel.font = self.param.menuTitleSelectUIFont;
    if (self.param.menuSelectTitleBackground) btn.layer.backgroundColor = self.param.menuSelectTitleBackground.CGColor;
    if ([self getTitleData:btn.config key:TFY_PageKeyImage]) {
        [btn tagSetImagePosition:self.param.menuImagePosition spacing:[self getTitleData:btn.config key:TFY_PageKeyImageOffset]?[[self getTitleData:btn.config key:TFY_PageKeyImageOffset] floatValue]:self.param.menuImageMargin];
    }
    
    /// 滚动到中间
    CGFloat centerX = self.frame.size.width / 2 ;
    CGRect indexFrame = btn.frame;
    CGFloat contenSizeWidth = self.contentSize.width  + self.param.menuInsets.right;
    CGPoint point = CGPointZero;
    if ((ceil(indexFrame.origin.x) + self.param.menuInsets.left) < centerX) {
        point = CGPointMake(-self.param.menuInsets.left, 0);
    }else if (ceil(CGRectGetMaxX(indexFrame)) > (contenSizeWidth - centerX)) {
        point = CGPointMake(contenSizeWidth - self.frame.size.width , 0);
    }else{
        point = CGPointMake(CGRectGetMaxX(indexFrame) -  centerX - indexFrame.size.width/2, 0);
    }
    if ([self isScrollEnabled]) [self setContentOffset:point animated:animal];
    
    CGFloat dataWidth = btn.titleLabel.frame.size.width?:btn.maxSize.width;
    /// 改变指示器frame
    CGRect lineRect = indexFrame;
    if (self.param.menuAnimal == PageTitleMenuCircle) {
        lineRect = indexFrame;
        lineRect.origin.x =  indexFrame.origin.x ;
        lineRect.size.width =  indexFrame.size.width ;
        lineRect.size.height =  self.param.menuIndicatorHeight?:(btn.maxSize.height + 8);
        lineRect.origin.y =  (indexFrame.size.height -  lineRect.size.height)/2;
        self.lineView.layer.masksToBounds = YES;
        self.lineView.layer.cornerRadius =  self.param.menuCircilRadio?:(lineRect.size.height/2);
    }else{
        lineRect.size.height = self.param.menuIndicatorHeight?:PageK1px;
        lineRect.origin.y = [self getMainHeight] - lineRect.size.height/2 - self.param.menuIndicatorY;
        lineRect.size.width =  self.param.menuIndicatorWidth?: (dataWidth + self.param.menuIndicatorTitleRelativeWidth);
        lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
    }
    if (!animal) {
        self.lineView.frame = lineRect;
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            self.lineView.frame = lineRect;
        }];
    }
    
    self.currentTitleIndex = newIndex;
    if (self.param.insertHeadAndMenuBg) self.backgroundColor = [UIColor clearColor];
    if (self.param.customMenuSelectTitle) self.param.customMenuSelectTitle(self.btnArr);
    if (self.param.menuAnimal == PageTitleMenuJD){
        if (self.lastBTN != btn) {
            btn.jdLayer.backgroundColor = self.param.menuIndicatorColor;
            if (self.param.eventCustomJDAnimal) self.param.eventCustomJDAnimal(btn, btn.jdLayer);
            [btn jdAddLayer];
        }
    }
    self.lastBTN = btn;
    if(self.param.menuAnimalTitleScale){
        [self.btnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.transform = CGAffineTransformIdentity;
        }];
    }
}

/// 动画管理
- (void)animalAction:(UIScrollView*)scrollView lastContrnOffset:(CGFloat)lastContentOffset {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat sWidth =  self.pageWidth;
    CGFloat content_X = (contentOffsetX / sWidth);
    NSArray *arr = [[NSString stringWithFormat:@"%f",content_X] componentsSeparatedByString:@"."];
    int num = [arr[0] intValue];
    CGFloat scale = content_X - num;
    int selectIndex = contentOffsetX/sWidth;
    BOOL left = false;
    /// 拖拽
    if (contentOffsetX <= lastContentOffset){
        left = YES;
        selectIndex = selectIndex+1;
        _btnRight = [self safeObjectAtIndex:selectIndex data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex-1 data:self.btnArr];
    } else if (contentOffsetX > lastContentOffset ){
        _btnRight = [self safeObjectAtIndex:selectIndex+1 data:self.btnArr];
        _btnLeft = [self safeObjectAtIndex:selectIndex data:self.btnArr];
    }
    /// 跟随滑动
    if (self.param.menuAnimal == PageTitleMenuAiQY) {
        CGRect rect = self.lineView.frame;
        if (scale < 0.5 ) {
            rect.origin.x = _btnLeft.center.x -self.param.menuIndicatorWidth/2;
            rect.size.width = self.param.menuIndicatorWidth + (_btnRight.center.x-_btnLeft.center.x) * scale*2;
        }else if(scale >= 0.5 ){
            rect.origin.x = _btnLeft.center.x +  2 * (scale - 0.5) * (_btnRight.center.x - _btnLeft.center.x) - self.param.menuIndicatorWidth / 2;
            rect.size.width =  self.param.menuIndicatorWidth + (_btnRight.center.x-_btnLeft.center.x) * (1-scale)*2;
        }
        if (rect.size.height!= (self.param.menuIndicatorHeight?:PageK1px))
            rect.size.height = self.param.menuIndicatorHeight?:PageK1px;
        if (rect.origin.y != ([self getMainHeight]-self.param.menuIndicatorY-rect.size.height/2))
            rect.origin.y = [self getMainHeight]-self.param.menuIndicatorY-rect.size.height/2;
        self.lineView.frame = rect;
    }else if (self.param.menuAnimal == PageTitleMenuPDD) {
        CGRect rect = self.lineView.frame;
        rect.size.width = self.param.menuIndicatorWidth?:rect.size.width;
        self.lineView.frame = rect;
        CGPoint center = self.lineView.center;
        center.x = _btnLeft.center.x +  (scale)*(_btnRight.center.x - _btnLeft.center.x);
        self.lineView.center = center;
    }else if (self.param.menuAnimal == PageTitleMenuNewAiQY) {
        CGPoint center = self.lineView.center;
        CGRect rect = self.lineView.frame;
        if (scale < 0.5) {
            rect.size.width = (1 - scale * 2) * self.param.menuIndicatorWidth;
            self.lineView.frame = rect;
            self.lineView.alpha = (1 - scale * 2);
            center.x = _btnLeft.center.x;
        }else{
            rect.size.width =  (scale - 0.5) * 2 * self.param.menuIndicatorWidth;
            self.lineView.alpha = scale;
            self.lineView.frame = rect;
            center.x = _btnRight.center.x;
        }
        self.lineView.center = center;
    }
    /// 渐变
    if (self.param.menuAnimalTitleGradient) {
        TFY_PageNavBtn *tempBtn = _btnLeft?:_btnRight;
        CGFloat difR =  tempBtn.selectedColorR - tempBtn.unSelectedColorR;
        CGFloat difG = tempBtn.selectedColorG - tempBtn.unSelectedColorG;
        CGFloat difB = tempBtn.selectedColorB - tempBtn.unSelectedColorB;
        CGFloat difA = tempBtn.selectAlpah - tempBtn.unSelectAlpah;
        CGFloat leftA = 1;
        CGFloat rightA = 1;
        if (tempBtn.selectAlpah != tempBtn.unSelectAlpah) {
            leftA = tempBtn.unSelectAlpah + scale * difA;
            rightA = tempBtn.unSelectAlpah + (1 - scale) * difA;
        }
        UIColor *leftItemColor  = [UIColor colorWithRed:tempBtn.unSelectedColorR+scale*difR green:tempBtn.unSelectedColorG+scale*difG blue:tempBtn.unSelectedColorB+scale*difB alpha:leftA ];
        UIColor *rightItemColor = [UIColor colorWithRed:tempBtn.unSelectedColorR+(1-scale)*difR green:tempBtn.unSelectedColorG+(1-scale)*difG blue:tempBtn.unSelectedColorB+(1-scale)*difB alpha:rightA];
        _btnLeft.titleLabel.textColor = rightItemColor;
        _btnRight.titleLabel.textColor = leftItemColor;
    }
    ///标题字体缩放过渡
    if (self.param.menuAnimalTitleScale &&
        self.param.menuTitleSelectUIFont.pointSize > self.param.menuTitleUIFont.pointSize &&
        _btnLeft && _btnRight) {
        CGFloat difference =  (self.param.menuTitleSelectUIFont.pointSize - self.param.menuTitleUIFont.pointSize) / self.param.menuTitleSelectUIFont.pointSize;
        CGFloat samllValue = 0;
        CGFloat bigValue = 0;
        if(!left){
            samllValue = 1 - difference * scale;
            bigValue = 1 + difference * scale;
            if(samllValue == self.param.menuTitleUIFont.pointSize/ self.param.menuTitleSelectUIFont.pointSize ){
                _btnLeft.transform = CGAffineTransformIdentity;
                _btnRight.transform = CGAffineTransformIdentity;
            }else{
                _btnLeft.transform = CGAffineTransformMakeScale(samllValue, samllValue);
                _btnRight.transform = CGAffineTransformMakeScale(bigValue, bigValue);
            }
        }else{
            samllValue = 1 - difference * (1 - scale);
            bigValue = 1 + difference * (1 - scale);
            if(samllValue == self.param.menuTitleUIFont.pointSize / self.param.menuTitleSelectUIFont.pointSize ){
                _btnLeft.transform = CGAffineTransformIdentity;
                _btnRight.transform = CGAffineTransformIdentity;
            }else{
                _btnLeft.transform = CGAffineTransformMakeScale(bigValue, bigValue);
                _btnRight.transform = CGAffineTransformMakeScale(samllValue, samllValue);
            }
        }
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index data:(NSArray*)data{
    return  index < data.count && index >= 0 ? [data objectAtIndex:index] : nil;
}

- (CGFloat)getMainHeight{
    if ((PageIsIphoneX && self.param.menuPosition == PageMenuPositionBottom)) return (self.frame.size.height - 15);
    else if (self.param.menuPosition == PageMenuPositionNavi) return 44;
    else if (self.param.menuAddSubView){
        return self.frame.size.height - self.param.menuInsets.bottom;
    }
    return self.frame.size.height;
}

- (NSMutableArray<TFY_PageNavBtn *> *)btnArr{
    return _btnArr ?: ({ _btnArr = NSMutableArray.new;});
}

- (NSMutableArray<TFY_PageNavBtn *> *)fixBtnArr{
    return _fixBtnArr ?: ({ _fixBtnArr = NSMutableArray.new;});
}

- (UIView *)containView{
    return _containView ?: ({ _containView = UIView.new;});
}


@end
