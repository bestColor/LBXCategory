//
//  UIImage+Rotation.h
//  CaocaoChuxing
//
//  Created by Apple on 2019/12/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Rotation)

// 图片旋转角度
+ (UIImage * _Nullable)imageWithRotation:(UIImage *)image degree:(CGFloat)degree;

@end

NS_ASSUME_NONNULL_END
