//
//  UIImage+Color.h
//  NoticeSheet
//
//  Created by libx on 2019/8/23.
//  Copyright © 2019 LF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

/**
 根据颜色生成图片

 @param color 颜色
 @param size 图片大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据颜色生成（1，1）图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 改变图片颜色

 @param color 颜色
 @return 图片
 */
- (UIImage *)changeImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
