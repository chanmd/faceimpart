//
//  NSString+YYAdditions.m
//  YYProject
//
//  Created by cg on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+YYAdditions.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (YYAdditions)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    CFStringRef sRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)self,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(encoding));
    NSString *re = [NSString stringWithFormat:@"%@",sRef];
    CFRelease(sRef);
    return re;
}

-(NSString *)urlEncodeWithEncodingUTF8{
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}


-(NSString *)unicodeDecodeString{
    NSString *unicodeStr = self;
	NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
	NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
	NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
	NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
	return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (BOOL)isMobileNumber
{
    NSMutableString *selfCopy = [NSMutableString stringWithString:self];
    NSString * selfCopy1= [selfCopy stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [selfCopy length])];
    NSMutableString *stringSelfCopy = [NSMutableString stringWithString:selfCopy1];
    
    if (!stringSelfCopy.length) {
        return NO;
    }
    if (![stringSelfCopy isPureInt]) {
        return NO;
    }
    
    NSString *stringResult = @"";
    if ([stringSelfCopy hasPrefix:@"+86"]) {
        stringResult = [stringSelfCopy substringFromIndex:3];
    }
    else if([stringSelfCopy hasPrefix:@"86"]){
        stringResult = [stringSelfCopy substringFromIndex:2];
    }
    else if ([stringSelfCopy hasPrefix:@"0086"]){
        stringResult = [stringSelfCopy substringFromIndex:4];
    }
    else if([stringSelfCopy hasPrefix:@"+"]){
        stringResult = [stringSelfCopy substringFromIndex:4];
    }
    
    if (stringResult.length == 11 && [stringResult hasPrefix:@"1"]) {
        return YES;
    }
    
    if (stringResult.length == 0 && stringSelfCopy.length == 11 && [stringSelfCopy hasPrefix:@"1"]) {
        return YES;
    }
    return NO;
    
}

- (NSString *)mobileNumberString
{
    NSMutableString *selfCopy = [NSMutableString stringWithString:self];
    NSString * selfCopy1= [selfCopy stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [selfCopy length])];
    NSMutableString *stringSelfCopy = [NSMutableString stringWithString:selfCopy1];
    
    if (!stringSelfCopy.length) {
        return @"";
    }
    if (![stringSelfCopy isPureInt]) {
        return @"";
    }
    
    NSString *stringResult = @"";
    if ([stringSelfCopy hasPrefix:@"+86"]) {
        stringResult = [stringSelfCopy substringFromIndex:3];
    }
    else if([stringSelfCopy hasPrefix:@"86"]){
        stringResult = [stringSelfCopy substringFromIndex:2];
    }
    else if ([stringSelfCopy hasPrefix:@"0086"]){
        stringResult = [stringSelfCopy substringFromIndex:4];
    }
    else if([stringSelfCopy hasPrefix:@"+"])
    {
       stringResult = [stringSelfCopy substringFromIndex:1];
    }
    
    if (stringResult.length == 11 && [stringResult hasPrefix:@"1"]) {
        return stringResult;
    }
    
    if (stringResult.length == 0 && stringSelfCopy.length == 11 && [stringSelfCopy hasPrefix:@"1"]) {
        return stringSelfCopy;
    }
    return @"";
    
}

-(BOOL)isEmailString{
    NSString *StringTemplate = @".+@.+\\.[a-z]+";
    NSPredicate *regextesEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", StringTemplate];
    if ([regextesEmail evaluateWithObject:self] == YES) {
        return YES;
    }else{
        return NO;
    }
}


// 消除头尾的空格和换行
-(NSString *) trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// 是否包含某个字符串
-(BOOL)containWithString:(NSString *)string{
    if ([self rangeOfString:string].location == NSNotFound) {
        return NO;
    }
    return YES;
}

// 格式化输出数字，使用千位分隔符，保留2位小数
-(NSString*) moneyFormat{
    NSNumber *num = [NSNumber numberWithDouble:[self doubleValue]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterDecimalStyle;
	formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 2;
    return [formatter stringFromNumber:num];
}

//纯数字
-(BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
//比较大小
-(BOOL)isBiggerThanString:(NSString *)stringCopare{
  NSComparisonResult result =  [self compare:stringCopare];
    if (result == NSOrderedAscending) {
        return NO;
    }else if(result == NSOrderedSame){
        return NO;
    }else{
        return YES;
    }
}


+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (NSString *)stringRemoveEmoji:(NSString *)string {
    __block NSMutableString *stringResult = [NSMutableString stringWithString:@""];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         BOOL returnValue = NO;
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
         if (!returnValue) {
             [stringResult appendString:substring];
         }
     }];
    
    return [NSString stringWithString:stringResult];
}
@end
