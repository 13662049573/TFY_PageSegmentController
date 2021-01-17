//
//  SceneDelegate.m
//  TFY_PageSegmentController
//
//  Created by 田风有 on 2021/1/17.
//

#import "SceneDelegate.h"
#import "ViewController.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    self.window.rootViewController = ViewController.new;
    [self.window makeKeyAndVisible];
}



@end
