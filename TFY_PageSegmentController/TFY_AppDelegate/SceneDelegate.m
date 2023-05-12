//
//  SceneDelegate.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2021/1/17.
//

#import "SceneDelegate.h"
#import "viewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[viewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}



@end
