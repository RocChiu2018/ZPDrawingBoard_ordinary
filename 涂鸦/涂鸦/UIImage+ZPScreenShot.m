//
//  UIImage+ZPScreenShot.m
//  屏幕截图
//
//  Created by 赵鹏 on 2018/12/31.
//  Copyright © 2018 赵鹏. All rights reserved.
//

#import "UIImage+ZPScreenShot.h"

@implementation UIImage (ZPScreenShot)

+ (UIImage *)imageWithCaptureView:(UIView *)captureView
{
    /**
     1、创建一个与屏幕大小相同的基于位图(bitmap)的图形上下文：可以把图形上下文看成是一个画板，以后所绘制的内容都画在这个画板上。
     size参数：图形上下文的尺寸；
     opaque参数：不透明度（YES：不透明；NO：透明）；
     scale参数：缩放比例。
     */
    UIGraphicsBeginImageContextWithOptions(captureView.bounds.size, NO, 0);
    
    /**
     2、获取图形上下文：
     */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /**
     3、把屏幕上的图层渲染到图形上下文中：
     图层(layer)只能渲染，不能绘制。
     */
    [captureView.layer renderInContext:ctx];
    
    /**
     4、从图形上下文中取出截好屏的图片：
     */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    /**
     5、关闭图形上下文：
     */
    UIGraphicsEndImageContext();
    
    return image;
}

@end
