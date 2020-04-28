//
//  UIView+WaterMark.h
//  NoticeSheet
//
//  Created by libx on 2019/8/1.
//  Copyright © 2019 LF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WaterMark)

/**    获取添加了水印的图片
 
 @param  text                       添加的水印字符串
 @param  markImage                  背景上需要添加的图片，可以为空
 @return UIImage                    返回添加了水印的图片
 */

- (UIImage * _Nullable)addWaterMarkText:(NSString *)text addMarkImage:(UIImage *_Nullable)markImage;


@end

NS_ASSUME_NONNULL_END
