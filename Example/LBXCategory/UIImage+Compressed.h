//
//  UIImage+Compressed.h
//  NoticeSheet
//
//  Created by libx on 2019/8/1.
//  Copyright © 2019 LF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compressed)

/** 压缩图片到指定尺寸 比例自动按照图片宽高比例修正*/
- (UIImage *)compressedSize:(CGSize)newSize;

/** 压缩图片到指定KB */
- (void)compressedImageKB:(CGFloat)fImageKBytes result:(void(^)(NSData *imageData))block;

@end

NS_ASSUME_NONNULL_END
