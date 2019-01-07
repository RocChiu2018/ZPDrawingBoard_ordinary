//
//  UIImage+ZPScreenShot.h
//  屏幕截图
//
//  Created by 赵鹏 on 2018/12/31.
//  Copyright © 2018 赵鹏. All rights reserved.
//

/**
 用于给指定的View截取图片的分类。
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZPScreenShot)

//"captureView"参数如果传入的是整个屏幕则就是截屏，如果传入的是某个控件则截取的就是某个控件的图片。
+ (UIImage *)imageWithCaptureView:(UIView *)captureView;

@end

NS_ASSUME_NONNULL_END
