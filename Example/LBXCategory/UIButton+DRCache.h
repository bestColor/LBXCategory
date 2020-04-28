//
//  UIButton+DRCache.h
//  DRCategory_Example
//
//  Created by 李风 on 2020/3/4.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DRCache)

/** 加载网络图片（默认缓存到内存中） */
- (void)lf_setImageWithURLString:(nullable NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
