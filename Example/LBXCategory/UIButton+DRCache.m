//
//  UIButton+DRCache.m
//  DRCategory_Example
//
//  Created by 李风 on 2020/3/4.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import "UIButton+DRCache.h"

@implementation UIButton (DRCache)

/** 加载网络图片（默认缓存到内存中） */
- (void)lf_setImageWithURLString:(nullable NSString *)urlString {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [self setImage:image forState:UIControlStateNormal];
            }
        });
    });
}

@end
