//
//  TFY_PageTitleModel.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_PageTitleModel.h"

@implementation TFY_PageTitleModel

- (instancetype)initWithIndex:(NSInteger)index controller:(UIViewController*)controller title:(NSString*)title{
    if (self = [super init]) {
        self.index = index;
        self.controller = controller;
        self.title = title;
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    if (self = [super init]) {
        self.index = index;
        self.controller = controller;
        self.titleInfo = titleInfo;
    }
    return self;
}

//初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                        title:(NSString*)title{
    TFY_PageTitleModel *model = TFY_PageTitleModel.new;
    model.index = index;
    model.controller = controller;
    model.title = title;
    return model;
}

//初始化方法
+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIViewController*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    TFY_PageTitleModel *model = TFY_PageTitleModel.new;
    model.index = index;
    model.controller = controller;
    model.titleInfo = titleInfo;
    return model;
}

@end
