//
//  UIColor+Extention.h
//  DRCategory_Example
//
//  Created by 李风 on 2020/3/4.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extention)

+ (UIColor *)randomColor;

+ (UIColor *)colorWithHexCode:(NSString *)hexCode;

+ (UIColor *)colorWithHexCode:(NSString *)hexCode alpha:(CGFloat)alpha;


//[UIColor jg_colorHex:0x333333]
+ (instancetype)jg_colorHex:(uint32_t)hex;

+ (instancetype)jg_colorHex:(uint32_t)hex alpha:(CGFloat)alpha;

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A;

@end

NS_ASSUME_NONNULL_END
