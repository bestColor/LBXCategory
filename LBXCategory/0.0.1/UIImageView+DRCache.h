//
//  UIImageView+DRCache.h
//  DRCategory_Example
//
//  Created by 李风 on 2020/3/4.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (DRCache)

/** 加载网络图片（默认缓存到内存中） */
- (void)lf_setImageWithURLString:(nullable NSString *)urlString;
- (void)lf_setImageWithURLString:(nullable NSString *)urlString placeholderImage:(nullable UIImage *)placeholder;

/** 加载网络图片（不缓存图片） */
- (void)lf_setImageOfNoCacheWithURLString:(nullable NSString *)urlString;
- (void)lf_setImageOfNoCacheWithURLString:(nullable NSString *)urlString placeholderImage:(nullable UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
