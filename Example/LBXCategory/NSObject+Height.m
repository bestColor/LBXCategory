//
//  NSObject+Height.m
//  NoticeSheet
//
//  Created by libx on 2019/8/6.
//  Copyright © 2019 LF. All rights reserved.
//

#import "NSObject+Height.h"
#import "objc/runtime.h"
#import "sys/utsname.h"

static NSString * const statusBarHeightKey       = @"statusBarHeight";         // 状态栏高度
static NSString * const navigationBarHeightKey   = @"navigationBarHeight";     // 导航栏高度
static NSString * const homeIndicatorHeightKey   = @"homeIndicatorHeight";     // homeIndicator高度
static NSString * const tabBarHeightKey          = @"tabBarHeight";            // tabBar高度

@implementation LFHeightManager
+ (id)heightManager
{
    static LFHeightManager *_heightManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _heightManager = [[LFHeightManager alloc] init];
    });
    return _heightManager;
}
@end

@implementation NSObject (Height)

- (void)lf_setTabBarHeight:(float)tabBarHeight navigationBarHeight:(float)navigationBarHeight {
    // 配置 statusbar 高度
    NSNumber *endStatusBarHeight = [NSNumber numberWithFloat:[[UIApplication sharedApplication] statusBarFrame].size.height];
    objc_setAssociatedObject([LFHeightManager heightManager], &statusBarHeightKey, endStatusBarHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // 配置 navigationBar 高度
    float statusBarAndNavigationBarHeight = navigationBarHeight + [[UIApplication sharedApplication] statusBarFrame].size.height;
    NSNumber *endNavigationBarHeight = [NSNumber numberWithFloat:statusBarAndNavigationBarHeight];
    objc_setAssociatedObject([LFHeightManager heightManager], &navigationBarHeightKey, endNavigationBarHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);

    float homeIndicatorHeight = 0;
    float homeIndicatorAndTabBarHeight = tabBarHeight;
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPad8,1"] ||
        [platform isEqualToString:@"iPad8,2"] ||
        [platform isEqualToString:@"iPad8,3"] ||
        [platform isEqualToString:@"iPad8,4"] ||
        [platform isEqualToString:@"iPad8,5"] ||
        [platform isEqualToString:@"iPad8,6"] ||
        [platform isEqualToString:@"iPad8,7"] ||
        [platform isEqualToString:@"iPad8,8"]) {
        homeIndicatorAndTabBarHeight += 15;
        homeIndicatorHeight = 20;
    } else if ([platform isEqualToString:@"iPhone10,3"] ||
               [platform isEqualToString:@"iPhone10,6"] ||
               [platform isEqualToString:@"iPhone11,8"] ||
               [platform isEqualToString:@"iPhone11,2"] ||
               [platform isEqualToString:@"iPhone11,4"] ||
               [platform isEqualToString:@"iPhone11,6"] ||
               [platform isEqualToString:@"iPhone12,1"] ||
               [platform isEqualToString:@"iPhone12,3"] ||
               [platform isEqualToString:@"iPhone12,5"]) {
        homeIndicatorAndTabBarHeight += 34;
        homeIndicatorHeight = 34;
    } else {
        if ([platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"i386"]) {
            NSString *modelName = [[UIDevice currentDevice] name];
            if ([modelName containsString:@"X"] || [modelName containsString:@"iPhone 11"]) {
                homeIndicatorAndTabBarHeight += 34;
                homeIndicatorHeight = 34;
            } else if (([modelName containsString:@"12.9-inch"] && [modelName containsString:@"3rd"]) || [modelName containsString:@"11-inch"]){
                homeIndicatorAndTabBarHeight += 15;
                homeIndicatorHeight = 20;
            } else {
                homeIndicatorAndTabBarHeight = tabBarHeight;
            }
        } else {
            homeIndicatorAndTabBarHeight = tabBarHeight;
        }
    }
    
    // 配置 home indicator 高度
    NSNumber *endHomeIndicatorHeight = [NSNumber numberWithFloat:homeIndicatorHeight];
    objc_setAssociatedObject([LFHeightManager heightManager], &homeIndicatorHeightKey, endHomeIndicatorHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // 配置 tabbar 高度
    NSNumber *endTabBarHeight = [NSNumber numberWithFloat:homeIndicatorAndTabBarHeight];
    objc_setAssociatedObject([LFHeightManager heightManager], &tabBarHeightKey, endTabBarHeight, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (float)lf_getStatusBarHeight {
    NSNumber *statusBarHeight = objc_getAssociatedObject([LFHeightManager heightManager], &statusBarHeightKey);
    return [statusBarHeight floatValue];
}

- (float)lf_getNavigationBarHeight {
    NSNumber *navigationBarHeight = objc_getAssociatedObject([LFHeightManager heightManager], &navigationBarHeightKey);
    return [navigationBarHeight floatValue];
}

- (float)lf_getHomeIndicatorHeight {
    NSNumber *homeIndicatorHeight = objc_getAssociatedObject([LFHeightManager heightManager], &homeIndicatorHeightKey);
    return [homeIndicatorHeight floatValue];
}

- (float)lf_getTabBarHeight {
    NSNumber *tabBarHeight = objc_getAssociatedObject([LFHeightManager heightManager], &tabBarHeightKey);
    return [tabBarHeight floatValue];
}

@end
