//
//  UIDevice+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (KLExtension)

/// 虚拟唯一标识符
+ (NSString *)kl_identifierByKeychain;
/// MAC地址
+ (NSString *)kl_macAddress;

@end

NS_ASSUME_NONNULL_END
