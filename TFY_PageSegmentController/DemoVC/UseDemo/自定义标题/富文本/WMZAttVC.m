//
//  WMZAttVC.m
//  TFY_PageBaseController
//
//  Created by wmz on 2021/8/13.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZAttVC.h"

@interface WMZAttVC ()

@end

@implementation WMZAttVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavi];
    
    TFY_PageParam *param = TFY_PageParam.new;
    param.titleArr = @[
        /// 富文本需成对出现   TFY_PageKeyName/TFY_PageKeySelectName
        @{TFY_PageKeyName:[self getNormalStr:@"未使用" smallStr:@"(0)"],
          TFY_PageKeySelectName:[self getSelectStr:@"未使用" smallStr:@"(0)"],},
        
        @{TFY_PageKeyName:[self getNormalStr:@"已使用" smallStr:@"(10)"],
          TFY_PageKeySelectName:[self getSelectStr:@"已使用" smallStr:@"(10)"],},
        
        @{TFY_PageKeyName:[self getNormalStr:@"已取消" smallStr:@"(20)"],
          TFY_PageKeySelectName:[self getSelectStr:@"已取消" smallStr:@"(20)"],},
        
        @{TFY_PageKeyName:[self getNormalStr:@"已完成" smallStr:@"(99)"],
          TFY_PageKeySelectName:[self getSelectStr:@"已完成" smallStr:@"(99)"],},
    ];
    param.menuIndicatorColor = UIColor.orangeColor;
    param.menuAnimalTitleGradient = NO;
    param.menuAnimal = PageTitleMenuAiQY;
    param.menuTitleWidth = PageVCWidth/4;
    param.menuTitleSelectColor = UIColor.orangeColor;
    param.viewController = ^UIViewController * _Nullable(NSInteger index) {
        return NSClassFromString(@"TestVC").new;
    };
    self.param = param;
    
}

/// 组建富文本
- (NSMutableAttributedString*)getNormalStr:(NSString*)str smallStr:(NSString*)samllStr{
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str,samllStr]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f] range:[mStr.string rangeOfString:str]];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:[mStr.string rangeOfString:samllStr]];
    [mStr addAttribute:NSForegroundColorAttributeName value:UIColor.blackColor range:[mStr.string rangeOfString:mStr.string]];
    return mStr;
}

- (NSMutableAttributedString*)getSelectStr:(NSString*)str smallStr:(NSString*)samllStr{
    NSMutableAttributedString *mStr = [self getNormalStr:str smallStr:samllStr];
    [mStr addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[mStr.string rangeOfString:mStr.string]];
    return mStr;
}

- (void)customNavi{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [btn setTitle:@"更新标题" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)onBtnAction{
    self.param.titleArr = @[
        /// 富文本需成对出现   WMZPageKeyName/WMZPageKeySelectName
        @{TFY_PageKeyName:[self getNormalStr:@"未使用" smallStr:@"(222)"],
          TFY_PageKeySelectName:[self getSelectStr:@"未使用" smallStr:@"(222)"],},
        
        @{TFY_PageKeyName:[self getNormalStr:@"已使用" smallStr:@"(303)"],
          TFY_PageKeySelectName:[self getSelectStr:@"已使用" smallStr:@"(303)"],},
        
        @{TFY_PageKeyName:[self getNormalStr:@"已取消" smallStr:@"(120)"],
          TFY_PageKeySelectName:[self getSelectStr:@"已取消" smallStr:@"(120)"],},
        
        @{TFY_PageKeyName:[self getNormalStr:@"已完成" smallStr:@"(9)"],
          TFY_PageKeySelectName:[self getSelectStr:@"已完成" smallStr:@"(9)"],},
    ];
    [self updateTitle];
}
@end
