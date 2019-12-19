//
//  NSObject+KLExtension.h
//  KLCategory
//
//  Created by Logic on 2019/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KLExtension)

// MARK: - Foundation
/// 是否是苹果手机
extern BOOL KLIsphone(void);
/// 是否是iPhoneX系列刘海屏
extern BOOL KLIsphoneXabove(void);

/// 屏幕宽度
extern CGFloat KLScreenWidth(void);
/// 屏幕高度
extern CGFloat KLScreenHeight(void);
/// 等比例缩放计算, 以375pt为基准值
/// @param origin 以375pt为基准的参考值
extern CGFloat KLAuto(CGFloat origin);
/// 状态栏高度
extern CGFloat KLAutoStatus(void);
/// 导航栏高度
extern CGFloat KLAutoTop(void);
/// 选项栏高度
extern CGFloat KLAutoBottom(void);
/// iPhoneX底部安全高度
extern CGFloat KLAutoBottomInset(void);

// MARK: - UIKit
/// 自适配字体
extern UIFont *KLAutoFont(CGFloat size);
/// 自适配粗体字体
extern UIFont *KLAutoBoldFont(CGFloat size);
/// 自适配粗体字体
/// @param name 字体名称
/// @param size 字体大小
extern UIFont *KLAutoNameFont(NSString *name, CGFloat size);

/// 16进制颜色
extern UIColor *KLColor(unsigned int hexNumber);
/// 16进制透明通道颜色
extern UIColor *KLColorAlpha(unsigned int hexNumber, CGFloat alpha);

/// 纯色图片 size = {1,1}
extern UIImage *KLImageHex(unsigned int hexNumber);
/// 纯色图片 size = {1,1}
extern UIImage *KLImageColor(UIColor *color);
/// 指定尺寸纯色图片
extern UIImage *KLImageHexSize(unsigned int hexNumber, CGSize size);
/// 指定尺寸纯色图片
extern UIImage *KLImageColorSize(UIColor *color, CGSize size);

/// 获取应用当前控制器
///
/// 注意：需要等到控制器viewDidAppear之后才能获取到正确的控制器
/// 使用：KLCurrentController()
/// @return 应用顶层控制器实例
extern UIViewController *KLCurrentController(void);

// MARK: - Math
/// 角度转弧度
/// @param degrees 角度
extern CGFloat KLDegreesToRadian(CGFloat degrees);
/// 弧度转角度
/// @param radian 弧度
extern CGFloat KLRadianToDegrees(CGFloat radian);

/// 计算数组和
extern CGFloat KLSumOfArray(NSArray *numbers);
/// 计算数组平均值
extern CGFloat KLAverageOfArray(NSArray *numbers);
/// 获取数组最大值
extern CGFloat KLMaxNumberOfArray(NSArray *numbers);
/// 获取数组最小值
extern CGFloat KLMinNumberOfArray(NSArray *numbers);

@end

NS_ASSUME_NONNULL_END
