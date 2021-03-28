//
//  TFY_PageMunuView.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageMunuView.h"

@implementation TFY_PageMunuView

- (instancetype)init{
    if (self = [super init]) {
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

//ui
- (void)UI{
    self.btnArr = [NSMutableArray new];
    TFY_PageNavBtn *temp = nil;
    for (int i = 0; i<self.param.titleArr.count; i++) {
        TFY_PageNavBtn *btn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
        [self setPropertiesWithBtn:btn withIndex:i withTemp:temp];
        temp = btn;
        if (i == self.param.titleArr.count - 1) {
            [self resetMainViewContenSize:btn];
        }
    }
    if (self.param.customMenuView) {
        self.param.customMenuView(self);
    }
    //指示器
    [self setUpIndicator];
    //右边固定标题
    [self setUpFixRightBtn:temp];
    
}

//重置contensize
- (void)resetMainViewContenSize:(TFY_PageNavBtn*)btn{
    if (CGRectGetMaxX(btn.frame) <= CGRectGetWidth(self.frame)) {
        self.scrollEnabled = NO;
    }else{
        self.scrollEnabled = YES;
    }
    self.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), 0);
}

//初始化指示器
- (void)setUpIndicator{
    self.lineView = [UIButton buttonWithType:UIButtonTypeCustom];
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
                            self.param.menuAnimal == PageTitleMenuCircleBg
                            );
    if (self.param.menuIndicatorRadio) {
        self.lineView.layer.cornerRadius = self.param.menuIndicatorRadio;
        self.lineView.layer.masksToBounds = YES;
    }
}

//设置右边固定标题
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
        for (int i = ((int)fixData.count - 1); i>=0; i--) {
            id info = fixData[i];
            TFY_PageNavBtn *fixBtn = [TFY_PageNavBtn buttonWithType:UIButtonTypeCustom];
            CGFloat menuFixWidth = [self getTitleData:info key:@"width"]?[[self getTitleData:info key:@"width"] floatValue]:self.param.menuFixRightWidth;
            CGFloat originY = [self getTitleData:info key:@"y"]?[[self getTitleData:info key:@"y"] floatValue]:temp.frame.origin.y;
            CGFloat menuFixHeight = [self getTitleData:info key:@"height"]?[[self getTitleData:info key:@"height"] floatValue]:temp.frame.size.height;
            id text = [self getTitleData:info key:@"name"];
            id selectText = [self getTitleData:info key:@"selectName"];
            id image = [self getTitleData:info key:@"image"];
            id selectImage = [self getTitleData:info key:@"selectImage"];
            id titleColor = [self getTitleData:info key:@"titleColor"]?:self.param.menuTitleRightColor;
            id titleSelectColor = [self getTitleData:info key:@"titleSelectColor"]?:self.param.menuTitleSelectRightColor;
            if (text) {
                [fixBtn setTitle:text forState:UIControlStateNormal];
            }
            if (selectText) {
                [fixBtn setTitle:selectText forState:UIControlStateSelected];
            }
            if (image) {
                [fixBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            }
            if (selectImage) {
                [fixBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
            }
            if (text && image) {
                menuFixWidth+=30;
            }
            allWidth += menuFixWidth;
            fixBtn.titleLabel.font = self.param.menuTitleRightUIFont;
            [fixBtn setTitleColor:titleColor forState:UIControlStateNormal];
            [fixBtn setTitleColor:titleSelectColor forState:UIControlStateSelected];
            fixBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-allWidth, originY, menuFixWidth, menuFixHeight);
            fixBtn.tag = 10086+i;
            fixBtn.backgroundColor = temp.backgroundColor;
            [self addSubview:fixBtn];
            [self bringSubviewToFront:fixBtn];
            CGFloat margin = [self getTitleData:info key:@"margin"]?[[self getTitleData:info key:@"margin"] floatValue]:self.param.menuImageRightMargin;
            if (image) {
                [fixBtn TagSetImagePosition:self.param.menuImageRightPosition spacing:margin];
            }
            if (self.param.menuFixShadow) {
               [fixBtn viewShadowPathWithColor:PageColor(0x333333) shadowOpacity:0.8 shadowRadius:3 shadowPathType:PageShadowPathLeft shadowPathWidth:2];
                fixBtn.alpha = 0.9;
            }
            [fixBtn  setAdjustsImageWhenHighlighted:NO];
            [fixBtn addTarget:self action:@selector(fixTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.fixBtnArr addObject:fixBtn];
        }
        if (self.param.customMenufixTitle) {
            self.param.customMenufixTitle(self.fixBtnArr);
        }
        
        self.contentSize = CGSizeMake(self.contentSize.width+allWidth, 0);
        self.scrollEnabled = !(CGRectGetMaxX(temp.frame) <= (self.frame.size.width-allWidth));
    }
}

//设置按钮样式
- (void)setPropertiesWithBtn:(TFY_PageNavBtn*)btn withIndex:(NSInteger)index  withTemp:(TFY_PageNavBtn*)temp{
    CGFloat margin = self.param.menuCellMargin;
    btn.param = self.param;
    btn.titleLabel.font = self.param.menuTitleUIFont;
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    id titleInfo = self.param.titleArr[index];
    id selectColor = [self getTitleData:titleInfo key:@"titleSelectColor"]?:self.param.menuTitleSelectColor;
    id color = [self getTitleData:titleInfo key:@"titleColor"]?:self.param.menuTitleColor;
    [btn setTitleColor:selectColor?:self.param.menuTitleSelectColor forState:UIControlStateSelected];
    [btn setTitleColor:color forState:UIControlStateNormal];
    id name = [self getTitleData:titleInfo key:@"name"];
    if (name) {
        [btn setTitle:name forState:UIControlStateNormal];
        btn.normalText = name;
    }
    id selectName = [self getTitleData:titleInfo key:@"selectName"];
    if (selectName) {
        [btn setTitle:selectName forState:UIControlStateSelected];
        btn.selectText = selectName;
    }
    CGSize size =  btn.maxSize;
    //设置图片
    id image = [self getTitleData:titleInfo key:@"image"];
    id selectImage = [self getTitleData:titleInfo key:@"selectImage"];
    id onlyClick = [self getTitleData:titleInfo key:@"onlyClick"];
    id titleBackground = [self getTitleData:titleInfo key:@"titleBackground"];
    btn.backgroundColor = titleBackground?:self.param.menuTitleBackground;
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    if (onlyClick) {
        btn.onlyClick = [onlyClick boolValue];
    }
    if (image&&selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }

    if (size.width == 0 && image) {
        size.width = 20.0f;
    }
    if (size.height == 0 && image) {
        size.height = 20.0f;
    }
    btn.maxSize = size;
    if (image) {
        if (self.param.menuImagePosition == PageBtnPositionLeft || self.param.menuImagePosition == PageBtnPositionRight ) {
            margin+=20;
            margin+=self.param.menuImageMargin;
        }
        if (self.param.menuImagePosition == PageBtnPositionTop || self.param.menuImagePosition == PageBtnPositionBottom ) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        }
    }
    //设置右上角红点
    NSString *badge = [self getTitleData:titleInfo key:@"badge"];
    if (badge) {
       [btn showBadgeWithTopMagin:self.param.titleArr[index]];
    }
    if (self.param.menuPosition != PageMenuPositionNavi) {
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    //设置富文本
    id wrapColor = [self getTitleData:titleInfo key:@"wrapColor"];
    id firstColor = [self getTitleData:titleInfo key:@"firstColor"];
    if ([btn.titleLabel.text containsString:@"\n"]&&(wrapColor||firstColor)) {
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
        NSMutableAttributedString *mSelectStr = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
        [mSelectStr addAttribute:NSForegroundColorAttributeName value:self.param.menuTitleSelectColor range:[btn.titleLabel.text rangeOfString:btn.titleLabel.text]];
        NSArray *array = [btn.titleLabel.text componentsSeparatedByString:@"\n"];
        if (wrapColor) {
            [mStr addAttribute:NSForegroundColorAttributeName value:wrapColor range:[btn.titleLabel.text rangeOfString:array[1]]];
        }
        if (firstColor) {
            [mStr addAttribute:NSForegroundColorAttributeName value:firstColor range:[btn.titleLabel.text rangeOfString:array[0]]];
        }
        [btn setAttributedTitle:mStr forState:UIControlStateNormal];
        [btn setAttributedTitle:mSelectStr forState:UIControlStateSelected];

    }
    
    CGFloat btnWidth = [self getTitleData:titleInfo key:@"width"]?[[self getTitleData:titleInfo key:@"width"] floatValue]:(self.param.menuTitleWidth?:(size.width + margin));
    CGFloat marginX = 0;
    CGFloat originY = [self getTitleData:titleInfo key:@"y"]?[[self getTitleData:titleInfo key:@"y"] floatValue]:0;
    CGFloat btnHeight = [self getTitleData:titleInfo key:@"height"]?[[self getTitleData:titleInfo key:@"height"] floatValue]:self.param.menuHeight;
    btn.tag = index;
    if (temp) {
        marginX = [self getTitleData:titleInfo key:@"marginX"]?[[self getTitleData:titleInfo key:@"marginX"] floatValue]:self.param.menuTitleOffset;
        btn.frame = CGRectMake((CGRectGetMaxX(temp.frame)+marginX), originY, btnWidth, btnHeight);
    }else{
        marginX = [self getTitleData:titleInfo key:@"marginX"]?[[self getTitleData:titleInfo key:@"marginX"] floatValue]:0;
        btn.frame = CGRectMake(marginX, originY, btnWidth, btnHeight);
    }
    
    if (self.param.menuAnimal == PageTitleMenuCircleBg) {
        if (self.param.menuTitleRadios == 0) {
            self.param.menuTitleRadios = btnHeight/2;
        }
    }
    if (self.param.menuTitleRadios) {
        btn.layer.cornerRadius = self.param.menuTitleRadios;
    }
    CGFloat imageMargin = [self getTitleData:titleInfo key:@"margin"]?[[self getTitleData:titleInfo key:@"margin"] floatValue]:self.param.menuImageMargin;
    if (image) {
        [btn TagSetImagePosition:self.param.menuImagePosition spacing:imageMargin];
    }
    if (self.btnArr.count>index) {
        [self.btnArr insertObject:btn atIndex:index];
        [self insertSubview:btn atIndex:index];
    }else{
        [self.btnArr addObject:btn];
        [self addSubview:btn];
    }
    
}

//解析字典
- (NSString*)getTitleData:(id)model key:(NSString*)key{
    if ([model isKindOfClass:[NSString class]]) {
        return [key isEqualToString:@"name"]?model:nil;
    }else if ([model isKindOfClass:[NSDictionary class]]) {
         return [model objectForKey:key]?:nil;
    }
    return nil;
}

//点击
- (void)tap:(TFY_PageNavBtn*)btn{
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)]) {
        [self.menuDelegate titleClick:btn fix:NO];
    }
}

//固定标题点击
- (void)fixTap:(TFY_PageNavBtn*)btn{
    if (self.menuDelegate&&[self.menuDelegate respondsToSelector:@selector(titleClick:fix:)]) {
        [self.menuDelegate titleClick:btn fix:YES];
    }
}


- (void)scrollToIndex:(NSInteger)newIndex animal:(BOOL)animal{
    if (self.btnArr.count<=newIndex) return;
    TFY_PageNavBtn *btn = self.btnArr[newIndex] ;
    //隐藏右上角红点
    [btn hidenBadge];
    //改变背景色
    id backgroundColor = [self getTitleData:self.param.titleArr[newIndex] key:@"backgroundColor"];
    //改变指示器颜色
    id indicatorColor = [self getTitleData:self.param.titleArr[newIndex] key:@"indicatorColor"];
    //改变标题颜色
    [self.btnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull temp, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger btnIndex = [self.btnArr indexOfObject:temp];
        temp.selected = (btnIndex == newIndex ?YES:NO);
        if ([temp isSelected]) {
            UIColor *tempBackgroundColor = self.param.menuBgColor;
            UIColor *fixBackgroundColor = self.param.menuBgColor;
            if (backgroundColor) {
                //渐变色
                if ([backgroundColor isKindOfClass:[NSArray class]]) {
                    if ([backgroundColor count]==2) {
                        
                        tempBackgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(self.contentSize.width, self.frame.size.height) direction:PageGradientChangeDirectionLevel startColor:backgroundColor[0] endColor:backgroundColor[1]];
                        fixBackgroundColor = backgroundColor[1];
                    }else{
                        tempBackgroundColor = backgroundColor[0];
                        fixBackgroundColor = tempBackgroundColor;
                    }
                }else if ([backgroundColor isKindOfClass:[UIColor class]]){
                           tempBackgroundColor = backgroundColor;
                           fixBackgroundColor = tempBackgroundColor;
                }
            }
            if (!self.param.insertHeadAndMenuBg) {
                self.backgroundColor = tempBackgroundColor;
            }
            if (!self.param.menuIndicatorImage) {
                self.lineView.backgroundColor = indicatorColor?:self.param.menuIndicatorColor;
            }
            temp.titleLabel.font = self.param.menuTitleSelectUIFont;
            [self.fixBtnArr enumerateObjectsUsingBlock:^(TFY_PageNavBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.backgroundColor = fixBackgroundColor;
                if (!CGColorEqualToColor(self.param.menuBgColor.CGColor, fixBackgroundColor.CGColor)) {
                    [obj setTitleColor:[temp titleColorForState:UIControlStateSelected] forState:UIControlStateNormal];
                }
            }];
            temp.layer.backgroundColor = self.param.menuSelectTitleBackground.CGColor;
        }else{
            temp.titleLabel.font = self.param.menuTitleUIFont;
            temp.layer.backgroundColor = self.param.menuTitleBackground.CGColor;
        }
    }];
    
    //滚动到中间
    CGFloat centerX = CGRectGetWidth(self.frame)/2;
    CGRect indexFrame = btn.frame;
    CGFloat contenSize = self.contentSize.width;
    CGPoint point = CGPointZero;
    if (indexFrame.origin.x<= centerX) {
        point = CGPointMake(0, 0);
    }else if (CGRectGetMaxX(indexFrame) > (contenSize-centerX)) {
        point = CGPointMake(self.contentSize.width-CGRectGetWidth(self.frame) , 0);
    }else{
        point = CGPointMake(CGRectGetMaxX(indexFrame) -  centerX-  indexFrame.size.width/2, 0);
    }
    if ([self isScrollEnabled]) {
        [self setContentOffset:point animated:animal?YES:NO];
    }
    
    if (![self.lineView isHidden]) {
        CGFloat dataWidth = btn.titleLabel.frame.size.width?:btn.maxSize.width;
        //改变指示器frame
        CGRect lineRect = indexFrame;
        lineRect.size.height = self.param.menuIndicatorHeight?:PageK1px;
        lineRect.origin.y = [self getMainHeight] - lineRect.size.height/2 - self.param.menuIndicatorY;
        lineRect.size.width =  self.param.menuIndicatorWidth?:(dataWidth+6);
        lineRect.origin.x =  (indexFrame.size.width - lineRect.size.width)/2 + indexFrame.origin.x;
        
        if (self.param.menuAnimal == PageTitleMenuCircle) {
            lineRect = indexFrame;
            lineRect.origin.x =  indexFrame.origin.x ;
            lineRect.size.width =  indexFrame.size.width ;
            lineRect.size.height =  self.param.menuIndicatorHeight?:(btn.maxSize.height + 8);
            lineRect.origin.y =  (indexFrame.size.height -  lineRect.size.height)/2;
            self.lineView.layer.masksToBounds = YES;
            self.lineView.layer.cornerRadius =  self.param.menuCircilRadio?:(lineRect.size.height/2);
        }
        
        if (!animal) {
            self.lineView.frame = lineRect;
        }else{
            [UIView animateWithDuration:0.2f animations:^{
                self.lineView.frame = lineRect;
            }];
        }
    }
        
    self.currentTitleIndex = newIndex;
    if (self.param.insertHeadAndMenuBg) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    
    if (self.param.customMenuSelectTitle) {
        self.param.customMenuSelectTitle(self.btnArr);
    }
}

//滚动到中间
- (void)scrollToIndex:(NSInteger)newIndex{
    [self scrollToIndex:newIndex animal:YES];
}


- (CGFloat)getMainHeight{
    if ((PageIsIphoneX&&self.param.menuPosition == PageMenuPositionBottom)) {
        return (CGRectGetHeight(self.frame) - 15);
    }else if (self.param.menuPosition == PageMenuPositionNavi) {
        return 44;
    }
    return CGRectGetHeight(self.frame);
}

- (NSMutableArray<TFY_PageNavBtn *> *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}
- (NSMutableArray<TFY_PageNavBtn *> *)fixBtnArr{
    if (!_fixBtnArr) {
        _fixBtnArr = [NSMutableArray new];
    }
    return _fixBtnArr;
}


@end
