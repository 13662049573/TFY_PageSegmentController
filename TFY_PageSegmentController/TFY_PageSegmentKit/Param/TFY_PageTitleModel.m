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
                   controller:(UIResponder*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    if (self = [super init]) {
        self.index = index;
        self.controller = controller;
        self.titleInfo = titleInfo;
    }
    return self;
}

+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                        title:(NSString*)title{
    return [[TFY_PageTitleModel alloc]initWithIndex:index controller:controller title:title];
}

+ (instancetype)initWithIndex:(NSInteger)index
                   controller:(UIResponder*)controller
                    titleInfo:(NSDictionary*)titleInfo{
    return [[TFY_PageTitleModel alloc]initWithIndex:index controller:controller titleInfo:titleInfo];
}

@end
