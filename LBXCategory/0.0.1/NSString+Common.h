//
//  NSString+Common.h
//  YueTao_iOS
//
//  Created by Apple on 2019/12/24.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Common)

/** 将str加密成本地保存的文件名 */
+ (NSString *)md5String:(NSString *)str;
- (NSString *)md5;

-(NSString *)firstPinYin;

/** 是否为空 */
+ (BOOL)isEmpty:(NSString *)string;

/** 当前字符串是否只包含空白字符和换行符 */
- (BOOL)isWhitespaceAndNewlines;

/** 去除字符串前后的空白,不包含换行符 */
- (NSString *)trim;

/** 去除字符串中所有空白 */
- (NSString *)removeWhiteSpace;
- (NSString *)removeNewLine;
/** 手机号码添加****  */
+ (NSString *)replaceStringWithPhone:(NSString *)phone;
@end

NS_ASSUME_NONNULL_END
