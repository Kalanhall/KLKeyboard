//
//  UIDevice+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/12/14.
//

#import "UIDevice+KLExtension.h"
#import <Security/Security.h>
#include <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation UIDevice (KLExtension)

+ (NSString *)kl_identifierByKeychain;
{
    //该类方法没有线程保护，所以可能因异步而导致创建出不同的设备唯一ID，故而增加此线程锁！
    @synchronized ([NSNotificationCenter defaultCenter])
    {
        NSString* service = @"KLVirtualDeviceIdentifierKeychainService";
        NSString* account = @"KLVirtualDeviceIdentifier";
        // 获取iOS系统推荐的设备唯一ID
        NSString* recommendDeviceIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        recommendDeviceIdentifier = [recommendDeviceIdentifier stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSMutableDictionary* queryDic = [NSMutableDictionary dictionary];
        [queryDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        [queryDic setObject:service forKey:(__bridge id)kSecAttrService];
        [queryDic setObject:(__bridge id)kCFBooleanFalse forKey:(__bridge id)kSecAttrSynchronizable];
        [queryDic setObject:account forKey:(__bridge id)kSecAttrAccount];
        // 默认值为kSecMatchLimitOne，表示返回结果集的第一个
        [queryDic setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
        [queryDic setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
        CFTypeRef keychainPassword = NULL;
        // 首先查询钥匙串是否存在对应的值，如果存在则直接返回钥匙串中的值
        OSStatus queryResult = SecItemCopyMatching((__bridge CFDictionaryRef)queryDic, &keychainPassword);
        if (queryResult == errSecSuccess) {
            NSString *pwd = [[NSString alloc] initWithData:(__bridge NSData * _Nonnull)(keychainPassword) encoding:NSUTF8StringEncoding];
            if ([pwd isKindOfClass:[NSString class]] && pwd.length > 0) {
                return pwd;
            } else {
                // 如果钥匙串中的相关数据不合法，则删除对应的数据重新创建
                NSMutableDictionary* deleteDic = [NSMutableDictionary dictionary];
                [deleteDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
                [deleteDic setObject:service forKey:(__bridge id)kSecAttrService];
                [deleteDic setObject:(__bridge id)kCFBooleanFalse forKey:(__bridge id)kSecAttrSynchronizable];
                [deleteDic setObject:account forKey:(__bridge id)kSecAttrAccount];
                OSStatus status = SecItemDelete((__bridge CFDictionaryRef)deleteDic);
                if (status != errSecSuccess) {
                    return recommendDeviceIdentifier;
                }
            }
        }
        if (recommendDeviceIdentifier.length > 0) {
            // 创建数据到钥匙串，达到APP即使被删除也不会变更的设备唯一ID，除非系统抹除数据，否则该数据将存储在钥匙串中
            NSMutableDictionary* createDic = [NSMutableDictionary dictionary];
            [createDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
            [createDic setObject:service forKey:(__bridge id)kSecAttrService];
            [createDic setObject:account forKey:(__bridge id)kSecAttrAccount];
            // 不可以使用iCloud同步钥匙串数据，否则导致同一个iCloud账户的多个设备获取的唯一ID相同
            [createDic setObject:(__bridge id)kCFBooleanFalse forKey:(__bridge id)kSecAttrSynchronizable];
            // 增加一道保险，防止钥匙串数据被同步到其他设备，保证设备ID绝对唯一。
            [createDic setObject:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
            [createDic setObject:[recommendDeviceIdentifier dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
            OSStatus createResult = SecItemAdd((__bridge CFDictionaryRef)createDic, nil);
            if (createResult != errSecSuccess) {
                NSLog(@"通过钥匙串创建设备唯一ID不成功！");
            }
        }
        return recommendDeviceIdentifier;
    }
}

+ (NSString *)kl_macAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

@end
