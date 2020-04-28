//
//  NSObject+Version.m
//  NoticeSheet
//
//  Created by libx on 2019/8/20.
//  Copyright © 2019 LF. All rights reserved.
//

#import "NSObject+Version.h"

/// app 版本
static NSString *AppVersion() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/// app 名称
static NSString *AppName() {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

/// 全局解析出来的字典
static NSMutableDictionary *VersionDictionary() {
    static NSMutableDictionary *versionDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        versionDict = @{}.mutableCopy;
    });
    return versionDict;
}

/// 解析xml的每一行的key
static NSString *_columnKey = @"";

/// 解析xml的字段
static NSString * const _newVersion = @"newVersion";                   // 新版本
static NSString * const _compulsoryVersion = @"compulsoryVersion";     // 强制新版本
static NSString * const _url = @"url";                                 // 版本更新地址
static NSString * const _description = @"description";                 // 更新内容
static NSString * const _name = @"name";                               // app名字

/// 开始跳转更新App
static void UpdateApp(BOOL isCompulsory) {
    NSString *iTunesString = [VersionDictionary() objectForKey:_url];
    NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
    
    if (@available(iOS 10.0, tvOS 10.10, *)) {
        [[UIApplication sharedApplication] openURL:iTunesURL options:@{} completionHandler:^(BOOL success) {
            if (isCompulsory) abort();
        }];
    } else {
        [[UIApplication sharedApplication] openURL:iTunesURL];
        if (isCompulsory) abort();
    }
}

@interface VersionDelegate : NSObject<NSXMLParserDelegate>

@end

@implementation VersionDelegate

+ (id)defaultDelegate {
    static VersionDelegate *_vDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _vDelegate = [[self alloc] init];
    });
    return _vDelegate;
}

- (void)parserXML:(NSString *)xmlURLString {
    [VersionDictionary() removeAllObjects];
    _columnKey = @"";
    
    __block NSString *weakXmlURLString = xmlURLString;
    
    dispatch_queue_t xmlParserQueue = dispatch_queue_create("xmlParserQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    dispatch_async(xmlParserQueue, ^{
        NSURL *xmlUrl = [NSURL URLWithString:weakXmlURLString];
        NSData *xmlData = [NSData dataWithContentsOfURL:xmlUrl options:NSDataReadingUncached error:nil];
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
        [parser setShouldProcessNamespaces:NO];
        [parser setShouldReportNamespacePrefixes:NO];
        [parser setShouldResolveExternalEntities:NO];
        [parser setDelegate:self];
        [parser parse];
    });
}

#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _columnKey = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (string.length && [string isEqualToString:@"\n "] == NO && [string isEqualToString:@"\n"] == NO) {
        [VersionDictionary() setObject:string forKey:_columnKey];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSString *appVersion = AppVersion();
    NSString *appName = AppName();
    NSString *appNewVersion = [VersionDictionary() objectForKey:_newVersion];
    NSString *appCompulsoryVersion = [VersionDictionary() objectForKey:_compulsoryVersion];
    NSString *appDescription = [VersionDictionary() objectForKey:_description];
    
    NSArray *origianDescriptions = [appDescription componentsSeparatedByString:@"--"];
    if (origianDescriptions.count) {
        NSMutableString *seqDescription = @"".mutableCopy;
        for (int i = 0; i < origianDescriptions.count; i++) {
            [seqDescription appendFormat:@"%d. %@\n",i+1,origianDescriptions[i]];
        }
        appDescription = seqDescription;
    }
    
    if ([appVersion compare:appCompulsoryVersion] == NSOrderedAscending) {
        [self showAlert:[NSString stringWithFormat:@"\"%@\" 发现新版本 %@",appName,appNewVersion] message:[NSString stringWithFormat:@"更新内容:\n%@",appDescription] cancel:@"" sure:@"马上更新" block:^(int result) {
            if (result) UpdateApp(YES);
        }];
    } else if ([appVersion compare:appNewVersion] == NSOrderedAscending) {
        [self showAlert:[NSString stringWithFormat:@"\"%@\" 发现新版本 %@",appName,appNewVersion] message:[NSString stringWithFormat:@"更新内容:\n%@",appDescription] cancel:@"一会更新" sure:@"马上更新" block:^(int result) {
            if (result) UpdateApp(NO);
        }];
    }
}

/// 显示 Alert, result 1 为点击了确定
- (void)showAlert:(NSString *)title
          message:(NSString *)message
           cancel:(NSString *)cancel
             sure:(NSString *)sure
            block:(void (^)(int result))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (cancel.length) {
            [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                block(0);
            }]];
        }
        if (sure.length) {
            [alertController addAction:[UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                block(1);
            }]];
        }
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        }];
    });
}

@end

@implementation NSObject (Version)

- (void)checkVersion:(NSString *)versionURLString {
    if (!versionURLString || !versionURLString.length) return;
    [[VersionDelegate defaultDelegate] parserXML:versionURLString];
}

@end
