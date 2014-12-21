//
//  ViewController.h
//  2048
//
//  Created by ZhuiYi on 14-11-22.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol viewControllerDelegate <NSObject>

- (void)viewController:(UIViewController *)vc dataArray:(NSArray *)array;

@end

@interface ViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, copy) void(^dismiss)();

@end

