//
//  ZSAccountTool.h
//  2048
//
//  Created by ZhuiYi on 14/12/16.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSAccountTool : NSObject

+ (void)saveArray:(NSMutableArray *)array;
+ (NSMutableArray *)readArray;

+ (void)saveScore:(NSNumber *)score;
+ (NSNumber *)readScore;

@end
