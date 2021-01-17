//
//  TFY_WZThirdController.m
//  TFY_PageSegmentKit
//
//  Created by 田风有 on 2021/1/16.
//

#import "TFY_WZThirdController.h"
#import "TFY_WZSecondController.h"

@interface TFY_WZThirdController ()<TFY_PageProtocol>

@end

@implementation TFY_WZThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TFY_PageParam *param = PageParam()
    .titleArrSet(@[@"资讯",@"视频",@"其他"])
    .viewControllerSet(^UIViewController *(NSInteger index) {
        return [TFY_WZSecondController new];
    })
    .topSuspensionSet(YES)
    .menuIndicatorColorSet([UIColor orangeColor])
    .menuTitleSelectColorSet([UIColor orangeColor])
//    //头部
    .menuHeadViewSet(^UIView *{
        UIView *back = [UIView new];
        back.frame = CGRectMake(0, 0, PageVCWidth, 200);
        UIImageView *image = [UIImageView new];
        [image sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602673230263&di=c9290650541d8edf911ff008a3bfa4dc&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fpic%2Ff%2F33%2F648011013.jpg"]];
        image.frame = back.bounds;
        [back addSubview:image];
        return back;
    })
    .menuAnimalSet(PageTitleMenuPDD);
    self.param = param;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
