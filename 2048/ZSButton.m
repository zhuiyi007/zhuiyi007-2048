//
//  ZSButton.m
//  2048
//
//  Created by ZhuiYi on 14-11-22.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "ZSButton.h"
#define ZSCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation ZSButton
+ (instancetype)createButtonWithNum:(int)num
{
    ZSButton *btn = [ZSButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return btn;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    int count = [title intValue];
    switch (count) {
        case 2:
            [self setBackgroundColor:ZSCOLOR(240, 230, 220)];
            break;
        case 4:
            [self setBackgroundColor:ZSCOLOR(240, 220, 200)];
            break;
        case 8:
            [self setBackgroundColor:ZSCOLOR(240, 180, 120)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 16:
            [self setBackgroundColor:ZSCOLOR(240, 140, 90)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 32:
            [self setBackgroundColor:ZSCOLOR(240, 120, 90)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 64:
            [self setBackgroundColor:ZSCOLOR(240, 90, 60)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 128:
            [self setBackgroundColor:ZSCOLOR(240, 200, 100)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 256:
            [self setBackgroundColor:ZSCOLOR(240, 200, 100)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 512:
            [self setBackgroundColor:ZSCOLOR(240, 200, 100)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1024:
            [self setBackgroundColor:ZSCOLOR(240, 200, 100)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 2048:
            [self setBackgroundColor:ZSCOLOR(240, 195, 45)];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{}
@end
