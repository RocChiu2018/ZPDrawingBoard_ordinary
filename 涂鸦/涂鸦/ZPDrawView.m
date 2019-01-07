//
//  ZPDrawView.m
//  涂鸦
//
//  Created by apple on 2016/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPDrawView.h"

@interface ZPDrawView()

@property (nonatomic, strong) NSMutableArray *totalPathMutableArray;  //这个可变数组里存放着不同的路径，而每个路径又是一个数组，里面存放着形成这一路径的所有点。

@end

@implementation ZPDrawView

#pragma mark ————— 懒加载 —————
- (NSMutableArray *)totalPathMutableArray
{
    if (_totalPathMutableArray == nil)
    {
        _totalPathMutableArray = [NSMutableArray array];
    }
    
    return _totalPathMutableArray;
}

#pragma mark ————— 清屏 —————
//把可变数组全部清空，然后重绘。
- (void)clear
{
    [self.totalPathMutableArray removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark ————— 回退 —————
//删除可变数组中的最后一个路径，然后重绘。
- (void)back
{
    [self.totalPathMutableArray removeLastObject];
    
    [self setNeedsDisplay];
}

#pragma mark ————— 确定路径的起点 —————
//当用户的手指一点击本View的时候系统就会调用这个方法。
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint startPoint = [touch locationInView:touch.view];
    
    /**
     用户刚开始点击本View的时候就会创建一个可变数组用来存放这个路径中的所有点；
     这个路径对应着这个新创建的可变数组。
     */
    NSMutableArray *pathMutableArray = [NSMutableArray array];
    
    //把路径的起点加到这个路径所对应的可变数组中
    [pathMutableArray addObject:[NSValue valueWithCGPoint:startPoint]];
    
    //把这个路径所对应的可变数组添加到可变数组中
    [self.totalPathMutableArray addObject:pathMutableArray];
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ————— 确定路径的拖动点 —————
//当用户的手指在本View上拖动的时候系统就会调用这个方法。
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:touch.view];
    
    //从可变数组中取出本路径所对应的可变数组
    NSMutableArray *pathMutableArray = [self.totalPathMutableArray lastObject];
    
    //把路径的拖动点添加到这个路径所对应的可变数组中
    [pathMutableArray addObject:[NSValue valueWithCGPoint:currentPoint]];
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ————— 确定路径的终点 —————
//当用户的手指离开本View的时候系统就会调用这个方法。
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint endPoint = [touch locationInView:touch.view];
    
    //从可变数组中取出本路径所对应的可变数组
    NSMutableArray *pathMutableArray = [self.totalPathMutableArray lastObject];
    
    //把路径的终点添加到本路径所对应的可变数组中
    [pathMutableArray addObject:[NSValue valueWithCGPoint:endPoint]];
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ————— 绘制 —————
-(void)drawRect:(CGRect)rect
{
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (NSMutableArray *pathMutableArray in self.totalPathMutableArray)
    {
        for (int i = 0; i < pathMutableArray.count; i++)
        {
            CGPoint point = [[pathMutableArray objectAtIndex:i] CGPointValue];
            
            if (i == 0)
            {
                CGContextMoveToPoint(ctx, point.x, point.y);
            }else
            {
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
    }
    
    //设置路径是以圆形开头
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //设置路径的转折点的是圆形的
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    //设置路径的粗细
    CGContextSetLineWidth(ctx, 5);
    
    //绘制路径
    CGContextStrokePath(ctx);
}

@end
