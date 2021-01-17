//
//  TFY_PageSegmentKit.h
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//  最新版本:2.0.0

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double TFY_PageSegmentKitVersionNumber;

FOUNDATION_EXPORT const unsigned char TFY_PageSegmentKitVersionString[];

#define TFY_PageSegmentKitRelease 0

#if TFY_PageSegmentKitRelease

#import <TFY_PageSegmentKit/TFY_ConfigProtocol.h>
#import <TFY_PageSegmentKit/TFY_PageParam.h>
#import <TFY_PageSegmentKit/TFY_PageBaseController.h>

#else

#import "TFY_ConfigProtocol.h"
#import "TFY_PageParam.h"
#import "TFY_PageBaseController.h"

#endif

