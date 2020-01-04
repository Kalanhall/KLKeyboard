//
//  KLBaseKeyboard.m
//  KLKeyboard
//
//  Created by Logic on 2019/12/19.
//

#import "KLBaseKeyboard.h"
#import "KLKeyboardBar.h"
@import KLCategory;
@import Masonry;

NSString * const KLKeyboardWillShowNotification = @"KLKeyboardWillShowNotification";
NSString * const KLKeyboardWillHideNotification = @"KLKeyboardWillHideNotification";

#define KLKEYBOARDHEIGHT 260 + KLAutoBottomInset()

@interface KLBaseKeyboard ()

@property (assign, nonatomic) BOOL kl_show;
@property (strong, nonatomic) KLKeyboardBar *keyboardBar;

@end

@implementation KLBaseKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 对当前自定义键盘事件进行互斥处理
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:KLKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (![notification.object isKindOfClass:self.class]) {
        // 不是本类显示，其他类一律隐藏
        [self hideKeyboardWithoutNotification:NO animated:NO];
    }
}

- (void)showKeyboardInView:(UIView *)view animated:(BOOL)animated
{
    if (![view.subviews containsObject:self]) {
        [view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.kl_keyboardHeight);
        }];
    } else {
        [view bringSubviewToFront:self];
    }

    self.hidden = NO;
    self.alpha = 0;
    self.transform = CGAffineTransformMakeTranslation(0, self.keyboardBar.kl_normalLocation ? self.kl_keyboardHeight : self.kl_keyboardHeight * 0.5);
    [UIView animateWithDuration:KLAnimationTime animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
    
    [self.superview layoutIfNeeded];
    [NSNotificationCenter.defaultCenter postNotificationName:KLKeyboardWillShowNotification object:self];
    self.kl_show = YES;
}

- (void)hideKeyboardAnimated:(BOOL)animated
{
    [self hideKeyboardWithoutNotification:YES animated:animated];
}

- (void)hideKeyboardWithoutNotification:(BOOL)notification animated:(BOOL)animated
{
    self.hidden = YES;
    self.transform = CGAffineTransformMakeTranslation(0, self.kl_keyboardHeight);
    if (notification) {
        [NSNotificationCenter.defaultCenter postNotificationName:KLKeyboardWillHideNotification object:nil];
    }
    self.kl_show = NO;
}

- (void)bindingKeyboardBar:(KLKeyboardBar *)keyboardBar
{
    self.keyboardBar = keyboardBar;
}

- (CGFloat)kl_keyboardHeight
{
    if (_kl_keyboardHeight == 0) {
        return KLKEYBOARDHEIGHT;
    }
    return _kl_keyboardHeight;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

@end
