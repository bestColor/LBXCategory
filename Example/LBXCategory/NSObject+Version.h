//
//  NSObject+Version.h
//  NoticeSheet
//
//  Created by libx on 2019/8/20.
//  Copyright © 2019 LF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Version)

/** 检查版本更新 */
- (void)checkVersion:(NSString *)versionURLString;

@end

NS_ASSUME_NONNULL_END

/** xml里面的格式
<?xml version="1.0" encoding="UTF-8"?>
<info>
 <newVersion>1.0.0</newVersion>
 <compulsoryVersion>1.0.0</compulsoryVersion>
 <url>http://www.baidu.com</url>
 <description>修复了已知bug。--修复了提交不上去的问题。--新增了长不大的功能。--把更新的内容每条之间用--分开</description>
 <name>通告单</name>
</info>



parma newVersion           是最新版本的版本号
parma compulsoryVersion    强制更新版本号
parma url                  是你软件更新的地址
parma description          是这次更新解决的问题，每一条之间以  --   来分隔
parma name                 软件名字

将此文件放在自己的服务器上，然后把地址传入调用接口

例如
        xml服务器地址  https://bestcolor.github.io/bestColor/sources.xml
调用方法
        [[VersionManager sharedVersionManager] checkVersions@"https://bestcolor.github.io/bestColor/sources.xml"];



*/
