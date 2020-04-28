//
//  UIView+WaterMark.m
//  NoticeSheet
//
//  Created by libx on 2019/8/1.
//  Copyright © 2019 LF. All rights reserved.
//

#import "UIView+WaterMark.h"

#define HORIZONTAL_SPACEING 80 // 水平间距
#define VERTICAL_SPACEING 130  // 竖直间距
#define CG_TRANSFORM_ROTATING (-M_PI_2 / 3) // 旋转角度(正旋45度 | 反旋45度)

@implementation UIView (WaterMark)

- (UIImage * _Nullable)addWaterMarkText:(NSString *)text addMarkImage:(UIImage *_Nullable)markImage {
    if (!text || !text.length) return nil;
    
    //设置水印大小，可以根据图片大小或者view大小
    CGFloat view_w = self.bounds.size.width;
    CGFloat view_h = self.bounds.size.height;
    
    //1.开启上下文
    if (markImage) {
        view_w = markImage.size.width;
        view_h = markImage.size.height;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view_w, view_h), NO, 0.0);
    
    //2.绘制图片 水印图片
    if (markImage) {
        [markImage drawInRect:CGRectMake(0, 0, view_w, view_h)];
    }
    /* --添加水印文字样式--*/
    UIFont * font = [UIFont systemFontOfSize:23.0]; //水印文字大小
    NSDictionary * attr = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[[UIColor grayColor] colorWithAlphaComponent:0.3]};
    NSMutableAttributedString * attr_str =[[NSMutableAttributedString alloc]initWithString:text attributes:attr];
    
    //文字：字符串的宽、高
    CGFloat str_w = attr_str.size.width;
    CGFloat str_h = attr_str.size.height;
    
    //根据中心开启旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(view_w/2, view_h/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(CG_TRANSFORM_ROTATING));
    
    //将绘制原点恢复初始值，保证context中心点和image中心点处在一个点(当前context已经发生旋转，绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-view_w/2, -view_h/2));
    
    //sqrtLength：原始image对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(view_w*view_w + view_h*view_h);
    
    //计算需要绘制的列数和行数
    int count_Hor = sqrtLength / (str_w + HORIZONTAL_SPACEING) + 1;
    int count_Ver = sqrtLength / (str_h + VERTICAL_SPACEING) + 1;
    
    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength-view_w)/2;
    CGFloat orignY = -(sqrtLength-view_h)/2;
    
    //在每列绘制时X坐标叠加
    CGFloat overlayOrignX = orignX;
    //在每行绘制时Y坐标叠加
    CGFloat overlayOrignY = orignY;
    for (int i = 0; i < count_Hor * count_Ver; i++) {
        //绘制图片
        [text drawInRect:CGRectMake(overlayOrignX, overlayOrignY, str_w, str_h) withAttributes:attr];
        if (i % count_Hor == 0 && i != 0) {
            overlayOrignX = orignX;
            overlayOrignY += (str_h + VERTICAL_SPACEING);
        }else{
            overlayOrignX += (str_w + HORIZONTAL_SPACEING);
        }
    }
    
    //3.从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    CGContextRestoreGState(context);
    
    return newImage;
}

@end
