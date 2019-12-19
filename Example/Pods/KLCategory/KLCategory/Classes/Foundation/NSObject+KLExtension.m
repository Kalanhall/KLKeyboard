//
//  NSObject+KLExtension.m
//  KLCategory
//
//  Created by Logic on 2019/11/30.
//

#import "NSObject+KLExtension.h"
#import "UIColor+KLExtension.h"
#import "UIImage+KLExtension.h"

@implementation NSObject (KLExtension)

// MARK: - Foundation
BOOL KLIsphone(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

BOOL KLIsphoneXabove(void) {
    return KLIsphone() && KLAutoBottomInset() > 0;
}

CGFloat KLScreenWidth(void) {
    return UIScreen.mainScreen.bounds.size.width;
}

CGFloat KLScreenHeight(void) {
    return UIScreen.mainScreen.bounds.size.height;
}

CGFloat KLAuto(CGFloat origin) {
    
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return origin;
    }
    
    CGFloat base = 375.0;
    CGFloat width = MIN(KLScreenWidth(), KLScreenHeight());
    
    CGFloat divisor = pow(10.0, MAX(0, 3));
    return round((origin * (width / base) * divisor)) / divisor;
}

CGFloat KLAutoStatus(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}

CGFloat KLAutoTop(void) {
    return UIApplication.sharedApplication.statusBarFrame.size.height + 44.0;
}

CGFloat KLAutoBottomInset(void) {
    CGFloat botomInset = 0;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        botomInset = window.safeAreaInsets.bottom;
    }
    return botomInset;
}

CGFloat KLAutoBottom(void) {
    return KLAutoBottomInset() + 49.0;
}

// MARK: - UIKit
UIFont *KLAutoFont(CGFloat size) {
    return [UIFont systemFontOfSize:KLAuto(size)];
}

UIFont *KLAutoBoldFont(CGFloat size) {
    return [UIFont boldSystemFontOfSize:KLAuto(size)];
}

UIFont *KLAutoNameFont(NSString *name, CGFloat size) {
    return [UIFont fontWithName:name size:KLAuto(size)];
}

UIColor *KLColor(unsigned int hexNumber) {
    return [UIColor kl_colorWithHexNumber:hexNumber];
}

UIColor *KLColorAlpha(unsigned int hexNumber, CGFloat alpha) {
    return [UIColor kl_colorWithHexNumber:hexNumber alpha:alpha];
}

UIImage *KLImageHex(unsigned int hexNumber) {
    return [UIImage kl_imageWithColor:KLColor(hexNumber)];
}

UIImage *KLImageColor(UIColor *color) {
    return [UIImage kl_imageWithColor:color];
}

UIImage *KLImageHexSize(unsigned int hexNumber, CGSize size) {
    return [UIImage kl_imageWithColor:KLColor(hexNumber) size:size];
}

UIImage *KLImageColorSize(UIColor *color, CGSize size) {
    return [UIImage kl_imageWithColor:color size:size];
}

UIViewController *KLCurrentController(void)
{ return [NSObject kl_findBestViewController:UIApplication.sharedApplication.keyWindow.rootViewController]; }

+ (UIViewController *)kl_findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        return [self kl_findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController* svc = (UISplitViewController*)vc;
        if (svc.viewControllers.count > 0) {
            return [self kl_findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*)vc;
        if (svc.viewControllers.count > 0) {
            return [self kl_findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self kl_findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

// MARK: - Math
CGFloat KLDegreesToRadian(CGFloat degrees) {
    return (M_PI * (degrees) / 180.0);
}

CGFloat KLRadianToDegrees(CGFloat radian) {
    return (radian * 180.0) / (M_PI);
}

CGFloat KLSumOfArray(NSArray *numbers) {
    CGFloat sum = 0;
    sum = [[numbers valueForKeyPath:@"@sum.floatValue"] floatValue];
    return sum;
}

CGFloat KLAverageOfArray(NSArray *numbers) {
    CGFloat avg = 0;
    avg = [[numbers valueForKeyPath:@"@avg.floatValue"] floatValue];
    return avg;
}

CGFloat KLMaxNumberOfArray(NSArray *numbers) {
    CGFloat max = 0;
    max = [[numbers valueForKeyPath:@"@max.floatValue"] floatValue];
    return max;
}

CGFloat KLMinNumberOfArray(NSArray *numbers) {
    CGFloat min = 0;
    min = [[numbers valueForKeyPath:@"@min.floatValue"] floatValue];
    return min;
}

@end
