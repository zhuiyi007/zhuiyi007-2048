//
//  ViewController.m
//  2048
//
//  Created by ZhuiYi on 14-11-22.
//  Copyright (c) 2014年 ZhuiYi. All rights reserved.
//

#import "ViewController.h"
#import "ZSButton.h"
#define space  8
#define height 59
#define width 59

#define MAXROW 4
#define MAXCOL MAXROW
typedef enum{
    ZSDirectionRight = 1,
    ZSDirectionLeft = 2,
    ZSDirectionDown = 3,
    ZSDirectionUp = 4
}ZSDirection;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, assign) int score;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIButton *restart;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *array_1;
@property (nonatomic, strong) NSMutableArray *array_2;
@property (nonatomic, strong) NSMutableArray *array_3;
@property (nonatomic, strong) NSMutableArray *array_4;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (nonatomic, assign) CGPoint curP;
@property (nonatomic, assign) CGPoint preP;

@property (nonatomic, assign) int localRow;
@property (nonatomic, assign) int localCol;

@property (nonatomic, assign, getter = isAppear) BOOL appear;

@property (nonatomic, assign) ZSDirection direction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 开始时随机出两个button
    [self start];
}

#pragma mark - 懒加载
- (NSMutableArray *)array
{
    if (!_array) {
        _array_1 = [NSMutableArray arrayWithObjects:@(0), @(0), @(0), @(0), nil];
        _array_2 = [NSMutableArray arrayWithObjects:@(0), @(0), @(0), @(0), nil];
        _array_3 = [NSMutableArray arrayWithObjects:@(0), @(0), @(0), @(0), nil];
        _array_4 = [NSMutableArray arrayWithObjects:@(0), @(0), @(0), @(0), nil];
        _array = [NSMutableArray array];
        [_array addObject:_array_1];
        [_array addObject:_array_2];
        [_array addObject:_array_3];
        [_array addObject:_array_4];
    }
    return _array;
}

#pragma mark - 重新开始
- (IBAction)restartButtonClick:(id)sender {
    //
    self.coverView.hidden = YES;
    self.restart.hidden = YES;
    self.gameOverLabel.hidden = YES;
    self.array = nil;
    for (UIButton *btn in self.bgView.subviews) {
        [btn removeFromSuperview];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",0];
    int i = 0;
    while (i != 2) {
        [self random];
        i ++;
    }
}

#pragma mark - 刚开始随机出两个按钮
- (void)start
{
    int i = 0;
    while (i != 2) {
        [self random];
        i ++;
    }
}

#pragma mark - 随机出来一个方块(不与之前的重复)
- (void)random
{
    while (1) {
        int row = arc4random_uniform(4);
        int col = arc4random_uniform(4);
        if ([self.array[row][col] isEqual: @(0)])
        {
            ZSButton *btn = [ZSButton createButtonWithNum:2];
            [btn setFrame:CGRectMake(space + (width + space) * col, space + (height + space) * row, 0, 0)];
            [UIView animateWithDuration:0.25 animations:^{
                [btn setFrame:CGRectMake(space + (width + space) * col, space + (height + space) * row, width, height)];
            }];
            self.array[row][col] = btn;
            [self.bgView addSubview:btn];
            break;
        }
    }
}

#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.preP = [touch locationInView:self.view];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.appear = NO;
    UITouch *touch = [touches anyObject];
    self.curP = [touch locationInView:self.view];
    CGFloat offsetX = self.curP.x - self.preP.x;
    CGFloat offsetY = self.curP.y - self.preP.y;
    self.score = [self.scoreLabel.text intValue];
    int localRow, localCol;
    if (fabs(offsetX) > fabs(offsetY))// 横向滑动 X
    {
        if (offsetX > 0)// 往右滑
        {
            _direction = ZSDirectionRight;
            // 从上往下遍历每一行
            for (localRow = 0; localRow < MAXROW; localRow ++)
            {
                _localRow = localRow;
                // 从右往左遍历每一列
                for (localCol = MAXCOL - 1; localCol >=0; localCol--)
                {
                    _localCol = localCol;
                    // 如果当前单元格是button的话
                    if ([self.array[_localRow][_localCol] isKindOfClass:[UIButton class]])
                    {
                        // 从最后一列遍历到当前列之前的列,找到合适的位置移动当前的单元格
                        for (int i = MAXCOL - 1; i > _localCol; i --)
                        {
                            if ([self.array[_localRow][i] isKindOfClass:[NSNumber class]] && [self.array[_localRow][i] isEqualToNumber:@(0)])
                            {
                                // 寻找合适的空白
                                [self findFeatBlank:i];
                                break;
                            }
                        }
                        // 从当前单元格前面一个往前遍历
                        for (int i = _localCol - 1; i >=0 ; i --)
                        {
                            // 如果遍历到button
                            if ([self.array[_localRow][i] isKindOfClass:[UIButton class]])
                            {
                                [self findButton:i];
                                break;
                            }
                        }
                    }
                }
            }
            if (self.appear) {
                [self random];
            }
        }
        else // 往左滑
        {
            _direction = ZSDirectionLeft;
            // 从上往下遍历每一行
            for (localRow = 0; localRow < MAXROW; localRow ++)
            {
                _localRow = localRow;
                // 从左往右遍历每一列
                for (localCol = 0; localCol < MAXCOL; localCol ++)
                {
                    _localCol = localCol;
                    // 如果当前单元格是button的话
                    if ([self.array[_localRow][localCol] isKindOfClass:[UIButton class]])
                    {
                        // 从第一列遍历到当前列之前的列,找到合适的位置移动当前的单元格
                        for (int i = 0; i < _localCol; i ++)
                        {
                            if ([self.array[_localRow][i] isKindOfClass:[NSNumber class]] && [self.array[_localRow][i] isEqualToNumber:@(0)])
                            {
                                [self findFeatBlank:i];
                                break;
                            }
                        }
                        // 从当前单元格后面一个往后遍历
                        for (int i = _localCol + 1; i < MAXCOL ; i ++)
                        {
                            // 如果遍历到button
                            if ([self.array[_localRow][i] isKindOfClass:[UIButton class]])
                            {
                                [self findButton:i];
                                break;
                            }
                        }
                    }
                }
            }
            if (self.appear) {
                [self random];
            }
        }
    }
    else // 纵向滑动 Y
    {
        if (offsetY > 0)// 往下滑
        {
            _direction = ZSDirectionDown;
            // 从左往右遍历每一列
            for (localCol = 0; localCol < MAXCOL; localCol ++)
            {
                _localCol = localCol;
                // 从下往上遍历每一行
                for (localRow = MAXROW - 1; localRow >= 0 ; localRow --)
                {
                    _localRow = localRow;
                    // 如果当前单元格是button的话
                    if ([self.array[_localRow][_localCol] isKindOfClass:[UIButton class]])
                    {
                        // 从最后一行遍历到当前行之前的行,找到合适的位置移动当前的单元格
                        for (int i = MAXROW - 1; i > _localRow; i --)
                        {
                            if ([self.array[i][_localCol] isKindOfClass:[NSNumber class]] && [self.array[i][_localCol] isEqualToNumber:@(0)])
                            {
                                [self findFeatBlank:i];
                                break;
                            }
                        }
                        // 从当前单元格上面一个往上遍历
                        for (int i = _localRow - 1; i >= 0 ; i --)
                        {
                            // 如果遍历到button
                            if ([self.array[i][_localCol] isKindOfClass:[UIButton class]])
                            {
                                [self findButton:i];
                                break;
                            }
                        }
                    }
                }
            }
            if (self.appear) {
                [self random];
            }
        }
        else // 往上滑
        {
            _direction = ZSDirectionUp;
            // 从左往右遍历每一列
            for (localCol = 0; localCol < MAXCOL; localCol ++)
            {
                _localCol = localCol;
                // 从上往下遍历每一行
                for (localRow = 0; localRow < MAXROW ; localRow ++)
                {
                    _localRow = localRow;
                    // 如果当前单元格是button的话
                    if ([self.array[_localRow][_localCol] isKindOfClass:[UIButton class]])
                    {
                        // 从最上一行遍历到当前行之上的行,找到合适的位置移动当前的单元格
                        for (int i = 0; i < _localRow; i ++)
                        {
                            if ([self.array[i][_localCol] isKindOfClass:[NSNumber class]] && [self.array[i][_localCol] isEqualToNumber:@(0)])
                            {
                                [self findFeatBlank:i];
                                break;
                            }
                        }
                        // 从当前单元格下面一个往下遍历
                        for (int i = _localRow + 1; i < MAXROW ; i ++)
                        {
                            // 如果遍历到button
                            if ([self.array[i][_localCol] isKindOfClass:[UIButton class]])
                            {
                                [self findButton:i];
                                break;
                            }
                        }
                    }
                }
            }
            if (self.appear) {
                [self random];
            }
        }
    }
    int count = 0;
    for (NSArray *arr in self.array)
    {
        for (NSObject *obj in arr)
        {
            if ([obj isKindOfClass:[ZSButton class]])
            {
                count ++;
            }
        }
    }
    // 格子已满,判断是否结束游戏
    if (count == 16)
    {
        BOOL live = NO;
        // 横向判断是否还有可以移动的格子
        for (int i = 0; i < 4; i++)
        {
            if (live)
            {
                break;
            }
            for (int j = 0; j < 3; j ++)
            {
                ZSButton *btn1 = self.array[i][j];
                int btn1Title = [btn1.titleLabel.text intValue];
                ZSButton *btn2 = self.array[i][j + 1];
                int btn2Title = [btn2.titleLabel.text intValue];
                if (btn1Title == btn2Title)
                {
                    live = YES;
                    break;
                }
            }
        }
        // 纵向判断是否还有可以移动的格子
        for (int j = 0; j < 4; j++)
        {
            if (live)
            {
                break;
            }
            for (int i = 0; i < 3; i ++)
            {
                ZSButton *btn1 = self.array[i][j];
                int btn1Title = [btn1.titleLabel.text intValue];
                ZSButton *btn2 = self.array[i + 1][j];
                int btn2Title = [btn2.titleLabel.text intValue];
                if (btn1Title == btn2Title)
                {
                    live = YES;
                    break;
                }
            }
        }
        if (!live) {
            self.coverView.hidden = NO;
            self.restart.hidden = NO;
            self.gameOverLabel.hidden = NO;
        }
    }
}

#pragma mark - 寻找合适的空白
- (void)findFeatBlank:(int)i
{
    int row, col;
    switch (_direction)
    {
        case ZSDirectionLeft:
            row = _localRow;
            col = i;
            break;
        case ZSDirectionRight:
            row = _localRow;
            col = i;
            break;
        case ZSDirectionDown:
            row = i;
            col = _localCol;
            break;
        default:
            row = i;
            col = _localCol;
            break;
    }
    self.array[row][col] = self.array[_localRow][_localCol];
    self.array[_localRow][_localCol] = @(0);
    [UIView animateWithDuration:0.25 animations:^{
        [self.array[row][col] setFrame:CGRectMake(space + (width + space) * col, space + (height + space) * row, width, height)];
    }];
    self.appear = YES;
    if ((_direction == ZSDirectionRight) || (_direction == ZSDirectionLeft))
    {
        _localCol = i;
    }
    else
    {
        _localRow = i;
    }
}

#pragma mark - 寻找相邻的button
- (void)findButton:(int)i
{
    int row, col;
    int localRow, localCol;
    int judge;
    switch (_direction) {
        case ZSDirectionRight:
            row = _localRow;
            col = _localCol - 1;
            localRow = row;
            localCol = i;
            judge = col;
            break;
        case ZSDirectionLeft:
            row = _localRow;
            col = _localCol + 1;
            localRow = row;
            localCol = i;
            judge = col;
            break;
        case ZSDirectionDown:
            row = _localRow - 1;
            col = _localCol;
            localRow = i;
            localCol = col;
            judge = row;
            break;
        default:
            row = _localRow + 1;
            col = _localCol;
            localRow = i;
            localCol = col;
            judge = row;
            break;
    }
    ZSButton *staticBtn = self.array[_localRow][_localCol];
    ZSButton *btn = self.array[localRow][localCol];
    // 判断遍历到的button与最后方的button的数字是否相同
    // 相同的话进行相加操作,并且合并单元格
    if ([staticBtn.titleLabel.text isEqualToString:btn.titleLabel.text])
    {
        int count = [staticBtn.titleLabel.text intValue];
        count = count * 2;
        self.score += count;
        [staticBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            btn.frame = staticBtn.frame;
        }completion:^(BOOL finished) {
        }];
        self.array[_localRow][_localCol] = staticBtn;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [btn removeFromSuperview];
        });
        self.array[localRow][localCol] = @(0);
        self.appear = YES;
        self.scoreLabel.text = [NSString stringWithFormat:@"%d",self.score];
    }
    // 不相同的话,将此单元格移动到前面一个单元格
    else
    {
        if(i != judge)
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self.array[localRow][localCol] setFrame:CGRectMake(space + (width + space) * col, space + (height + space) * row, width, height)];
            }];
            self.array[row][col] = self.array[localRow][localCol];
            self.array[localRow][localCol] = @(0);
            self.appear = YES;
        }
    }
}
@end

