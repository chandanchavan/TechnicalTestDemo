//
//  splashViewController.m
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()
{
    NSTimer* myTimer;
}

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target: self
                                                      selector: @selector(pushToUserViewContoller) userInfo: nil repeats: NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)pushToUserViewContoller
{
    [self performSegueWithIdentifier:@"pushToUserInfo" sender:self];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
