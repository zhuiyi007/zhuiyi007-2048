//
//  AppDelegate.m
//  2048
//
//  Created by ZhuiYi on 14-11-22.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ZSAccountTool.h"

@interface AppDelegate ()

@property (nonatomic, strong) ViewController *vc;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 新建窗口
    self.window = [[UIWindow alloc] init];
    // 设置frame
    self.window.frame = [UIScreen mainScreen].bounds;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ViewController *vc = [storyboard instantiateInitialViewController];
    self.vc = vc;
    
    [self.window setRootViewController:vc];
    
    // 设置主窗口
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    if (self.vc.dismiss) {
        self.vc.dismiss();
    }
    NSLog(@"应用程序将要进入非活动状态，即将进入后台");
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    NSLog(@"系统内存不足，需要进行清理工作");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"应用程序将要退出，通常用于保存书架喝一些推出前的清理工作");
}

@end
