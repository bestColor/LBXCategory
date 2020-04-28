//
//  UIImage+Rotation.m
//  CaocaoChuxing
//
//  Created by Apple on 2019/12/11.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "UIImage+Rotation.h"
#import<QuartzCore/QuartzCore.h>
#import<Accelerate/Accelerate.h>

@implementation UIImage (Rotation)

+ (UIImage * _Nullable)imageWithRotation:(UIImage *)image degree:(CGFloat)degree {
    //将image转化成context
    //获取图片像素的宽和高
    size_t width = image.size.width * image.scale;
    size_t height = image.size.height * image.scale;
    
    //颜色通道为8 因为0-255 经过了8个颜色通道的变化
    //每一行图片的字节数 因为我们采用的是ARGB/RGBA 所以字节数为 width * 4
    size_t bytesPerRow = width * 4;
    //图片的透明度通道
    CGImageAlphaInfo info = kCGImageAlphaPremultipliedFirst;
    CGColorSpaceRef myColorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, bytesPerRow, myColorSpaceRef, kCGBitmapByteOrderDefault|info);
    CGColorSpaceRelease(myColorSpaceRef);
    
    if (!context) {
        return nil;
    }
    //将图片渲染到图形上下文中
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
    //旋转context
    uint8_t *data = (uint8_t *) CGBitmapContextGetData(context);
    //旋转欠的数据
    vImage_Buffer src = { data,height,width,bytesPerRow };
    //旋转后的数据
    vImage_Buffer dest= { data,height,width,bytesPerRow };
    
    //背景颜色
    Pixel_8888  backColor = {0,0,0,0};
    //填充颜色
    vImage_Flags flags = kvImageBackgroundColorFill;
    
    vImageRotate_ARGB8888(&src, &dest, nil, degree * M_PI/180.f, backColor, flags);
    
    //将conetxt转换成image
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *rotateImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    
    CFRelease(context);
    CFRelease(imageRef);
    
    return rotateImage;
}

@end
