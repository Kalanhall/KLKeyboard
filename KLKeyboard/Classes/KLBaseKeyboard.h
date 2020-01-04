//
//  KLBaseKeyboard.h
//  KLKeyboard
//
//  Created by Logic on 2019/12/19.
//


#import <UIKit/UIKit.h>

@class KLKeyboardBar;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const KLKeyboardWillShowNotification;
FOUNDATION_EXPORT NSString * const KLKeyboardWillHideNotification;

#define KLAnimationTime 0.25

@interface KLBaseKeyboard : UIView

/// 键盘高度
@property (assign, nonatomic) CGFloat kl_keyboardHeight;
/// 显示状态
@property (assign, nonatomic, readonly) BOOL kl_show;

/// 显示
- (void)showKeyboardInView:(UIView *)view animated:(BOOL)animated;

/// 隐藏
- (void)hideKeyboardAnimated:(BOOL)animated;

/// 检测bar当前状态，对show方法交互进行调整
- (void)bindingKeyboardBar:(KLKeyboardBar *)keyboardBar;

@end

NS_ASSUME_NONNULL_END
