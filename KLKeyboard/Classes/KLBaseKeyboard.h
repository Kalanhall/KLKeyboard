//
//  KLBaseKeyboard.h
//  KLKeyboard
//
//  Created by Logic on 2019/12/19.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const KLKeyboardWillShowNotification;
FOUNDATION_EXPORT NSString * const KLKeyboardWillHideNotification;

#define KLAnimationTime 0.25

@interface KLBaseKeyboard : UIView

- (void)showKeyboardInView:(UIView *)view animated:(BOOL)animated;
- (void)hideKeyboardAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
