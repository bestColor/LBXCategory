//
//  UIImageView+DRCache.m
//  DRCategory_Example
//
//  Created by 李风 on 2020/3/4.
//  Copyright © 2020 3257468284@qq.com. All rights reserved.
//

#import "UIImageView+DRCache.h"
#import <SDWebImage/SDWebImage.h>

@implementation UIImageView (DRCache)

- (void)lf_setImageWithURLString:(nullable NSString *)urlString {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)lf_setImageWithURLString:(nullable NSString *)urlString placeholderImage:(nullable UIImage *)placeholder {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)lf_setImageOfNoCacheWithURLString:(nullable NSString *)urlString {
    [self setImageOfNoCacheWithURL:[NSURL URLWithString:urlString] placeholderImage:nil];
}

- (void)lf_setImageOfNoCacheWithURLString:(nullable NSString *)urlString placeholderImage:(nullable UIImage *)placeholder {
    [self setImageOfNoCacheWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholder];
}

- (void)setImageOfNoCacheWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholderImage {
    if (placeholderImage) { self.image = placeholderImage; }
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (image && finished) {
            self.image = image;
        }
    }];
    
}

@end

