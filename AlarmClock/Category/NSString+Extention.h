//
//  NSString+Extention.h
//  basisProject
//
//  Created by shenyong on 2019/2/27.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extention)

/**
 *  判断手机号是否是合法手机号
 *
 */
-(BOOL) isMobileNumber;

/**
 *  判断邮箱是否合法
 */
-(BOOL) isEmailAddress;

/**
 *  取出字符串中所有空格 换行符
 */
-(NSString *) trimStr;
/**
 *  判断密码强弱
 *
 *  @return 0:规则不允许 1:允许 弱2:强密码
 */
-(NSInteger)stringIsWeakOrStrong;

/**
 *  是否为空字符串
 */
-(BOOL) isEmptyStr;
//

- (NSString *)dateFormatterWithDateFormat:(NSString *)format;

/**
 *  MD5加密
 *
 */

- (NSString *)md5Input;

/**
 * 传入指定日期获取第二天日期
 */

- (NSString *)dateToGetsecondDay:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
