//
//  NSObject+Height.h
//  NoticeSheet
//
//  Created by libx on 2019/8/6.
//  Copyright © 2019 LF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFHeightManager : NSObject

@end

@interface NSObject (Height)

/** 设置系统的tabbar高度和navigation的高度，并计算出该分类所有的高度 */
- (void)lf_setTabBarHeight:(float)tabBarHeight navigationBarHeight:(float)navigationBarHeight;

/** 获取状态栏高度 */
- (float)lf_getStatusBarHeight;

/** 获取系统navigationbar的高度(包含状态栏高度) */
- (float)lf_getNavigationBarHeight;

/** 获取home indicator高度，没有为0 */
- (float)lf_getHomeIndicatorHeight;

/** 获取系统tabbar高度（包含home indicator高度） */
- (float)lf_getTabBarHeight;

@end

NS_ASSUME_NONNULL_END
