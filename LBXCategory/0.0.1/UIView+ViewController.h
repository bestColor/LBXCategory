//
//  UIView+ViewController.h
//  NoticeSheet
//
//  Created by libx on 2019/8/6.
//  Copyright © 2019 LF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ViewController)

/** 给view直接设置背景图片 */
- (void)setBackgroundImage:(UIImage *)image;

/** 获取当前的viewController */
- (UIViewController *)viewController;

/** 截图 */
- (nullable UIImage *)snapshotImage;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

@end

NS_ASSUME_NONNULL_END
