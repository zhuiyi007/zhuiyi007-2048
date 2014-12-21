//
//  ZSAccountTool.m
//  2048
//
//  Created by ZhuiYi on 14/12/16.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "ZSAccountTool.h"
#define ARRAYPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"array.data"]
#define SCOREPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"score.data"]

@implementation ZSAccountTool

+ (void)saveArray:(NSMutableArray *)array
{
    [NSKeyedArchiver archiveRootObject:array toFile:ARRAYPATH];
}
+ (NSMutableArray *)readArray
{
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:ARRAYPATH];
    return array;
}

+ (void)saveScore:(NSNumber *)score
{
    [NSKeyedArchiver archiveRootObject:score toFile:SCOREPATH];
}

+ (NSNumber *)readScore
{
    NSNumber *score = [NSKeyedUnarchiver unarchiveObjectWithFile:SCOREPATH];
    return score;
}


@end
