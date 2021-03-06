//
//  TFY_PageNavBtn.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_ConfigProtocol.h"
#import "TFY_PageParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFY_PageNavBtn : UIButton

@property(nonatomic,strong)TFY_PageParam *_Nonnull param;
//最大size
@property(nonatomic,assign)CGSize maxSize;
//处于动画状态
@property(nonatomic,assign)BOOL animal;
//仅点击不加载页面 保持原页面
@property(nonatomic,assign)BOOL onlyClick;
//有红点提示
@property(nonatomic,assign)NSInteger hasBadge;
//初始文本内容
@property(nonatomic,copy)NSString* _Nonnull normalText;
//选中文本
@property(nonatomic,copy)NSString* _Nonnull selectText;
//RGB值
@property (nonatomic, assign) CGFloat selectedColorR;
@property (nonatomic, assign) CGFloat selectedColorG;
@property (nonatomic, assign) CGFloat selectedColorB;
@property (nonatomic, assign) CGFloat unSelectedColorR;
@property (nonatomic, assign) CGFloat unSelectedColorG;
@property (nonatomic, assign) CGFloat unSelectedColorB;
//富文本图片
@property(nonatomic,strong)NSAttributedString* _Nonnull attributedImage;
//富文本选中图片
@property(nonatomic,strong)NSAttributedString* _Nonnull attributedSelectImage;

- (NSAttributedString*_Nonnull)setImageWithStr:(NSString*_Nonnull)str
                                  font:(UIFont*_Nonnull)font
                         textAlignment:(NSTextAlignment)textAlignment
                             textColor:(nullable UIColor*)textColor
                                height:(CGFloat)height
                       backgroundColor:(nullable UIColor*)backgroundColor
                          cornerRadius:(CGFloat)cornerRadius;
//设置图文位置
- (void)TagSetImagePosition:(PageBtnPosition)postion spacing:(CGFloat)spacing;
//设置单边阴影
- (void)viewShadowPathWithColor:(UIColor *_Nonnull)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(PageShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
//设置圆角
-(void)setRadii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner;

@end

@interface TFY_PageNavBtn (Badge)

@property (nonatomic, strong) UILabel *_Nonnull badge;
/**
 *  显示小红点
 *  @magin 小红点距离控件上方距离
 */
- (void)showBadgeWithTopMagin:(NSDictionary*_Nonnull)info;

/**
 *  隐藏小红点
 */
- (void)hidenBadge;
@end

@interface UIColor (GradientColor)
+ (instancetype _Nonnull )bm_colorGradientChangeWithSize:(CGSize)size
                direction:(PageGradientChangeDirection)direction
                startColor:(UIColor*_Nonnull)startcolor
                endColor:(UIColor*_Nonnull)endColor;
@end

@interface UIView (PageBorder)
//设置单边框
- (void)viewPathWithColor:(UIColor *_Nonnull)shadowColor  PathType:(PageShadowPathType)shadowPathType PathWidth:(CGFloat)shadowPathWidth heightScale:(CGFloat)sacle;
@end

NS_ASSUME_NONNULL_END
