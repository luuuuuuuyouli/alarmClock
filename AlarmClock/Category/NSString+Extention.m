//
//  NSString+Extention.m
//  basisProject
//
//  Created by shenyong on 2019/2/27.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

/**
 *  是否为空字符串
 */
-(BOOL) isEmptyStr{
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self==nil||self==NULL) {
        return YES;
    }
    
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//判断手机号是否是合法手机号
-(BOOL) isMobileNumber{
    NSString *mobileRegex = @"^(134|135|136|137|138|139|147|150|151|152|157|158|159|178|182|183|184|187|188|130|131|132|145|155|156|171|175|176|185|186|133|149|153|173|177|180|181|189|170|852)[0-9]{8}$";//正则
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];//安装正则的断言器
    return [mobileTest evaluateWithObject:self];
}


/**
 *  判断邮箱是否合法
 */
-(BOOL) isEmailAddress{
    NSString *emailRegex = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    NSPredicate *emailTester = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTester evaluateWithObject:self];
}


/**
 *  取出字符串中所有空格 换行符
 */
-(NSString *) trimStr{
    NSString *trimedStr ;
    //初始化空格换行字符集
    trimedStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    trimedStr = [trimedStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    trimedStr = [trimedStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return trimedStr;
}

-(NSInteger )stringIsWeakOrStrong
{
    NSString *newStr = self;
    NSString *temp = nil;
    NSString * same = nil;
    NSInteger count = 0;
    // 数字类型
    NSInteger num = 0;
    // 字母类型
    NSInteger letter = 0;
    // 特殊字符类型
    NSInteger specialChar = 0;
    // 判断的字符
    NSString * aChar;
    
    for (int q = 0; q < [newStr length]; q++) {
        aChar  = [newStr substringWithRange:NSMakeRange(q, 1)];
        if ([self isValidateNumber:aChar]) {// 判断是数字
            num++;
        }
        if ([self isValidateLetter:aChar]){// 判断是字母
            letter++;
        }
        if (![self isValidateLetter:aChar] && ![self isValidateNumber:aChar]){// 判断是特殊符号
            specialChar++;
        }
        
    }
    
    if (num > 0 && letter > 0 && specialChar > 0) {// 强密码
        return 2;
    }else{// 弱密码
        
        for(int i =0; i < [newStr length]; i++)
        {
            temp = [newStr substringWithRange:NSMakeRange(i, 1)];
            for (int j = 0; j < [newStr length]; j++) {
                same = [newStr substringWithRange:NSMakeRange(j, 1)];
                if ([same isEqualToString:temp]) {
                    count++;
                }
            }
            if (count < [newStr length]*2/3) {
                count = 0;
            }else{
                break;
            }
        }
        if (count >= [newStr length]*2/3) {
            NSLog(@"有 %ld 个相同的字符 %@",(long)count,temp);
            NSLog(@"不符合密码规则");
            return 0;
        }else{
            NSLog(@"没有超过2/3相同的字符");
            NSLog(@"符合密码规则，但是弱密码");
            return 1;
        }
        
    }
}

/**
 *  判断数字
 */
-(BOOL)isValidateNumber:(NSString *)phone
{
    NSString *mobileRegex = @"^[0-9]*$";//正则
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];//安装正则的断言器
    return [mobileTest evaluateWithObject:phone];
}

/**
 *  判断字母
 */
-(BOOL)isValidateLetter:(NSString *)phone
{
    NSString *mobileRegex = @"^[A-Za-z]+$";//正则
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];//安装正则的断言器
    return [mobileTest evaluateWithObject:phone];
}
/*
 *时间戳转换
 */
- (NSString *)dateFormatterWithDateFormat:(NSString *)format{
    NSTimeInterval tim=
    [self doubleValue]/1000;//+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:tim];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:format==nil?@"yyyy-MM-dd":format];
    
    return  [dateFormatter stringFromDate:detaildate];
}
//时间戳转换无时差

//MD5加密

- (NSString *) md5Input {
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return [digest uppercaseString];
}


//传入指定日期获取第二天日期
- (NSString *)dateToGetsecondDay:(NSString *)format{
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:format==nil?@"yyyy-MM-dd":format];
    
    
    NSDate *fromDate = [dateFormatter dateFromString:self];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:fromDate];
    [components setDay:([components day]+1)];
    
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    
    return [dateFormatter stringFromDate:beginningOfWeek];
    
}



@end
