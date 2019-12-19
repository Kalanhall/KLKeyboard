//
//  KLKeyboardBar.h
//  KLKeyboardBar
//
//  Created by Logic on 2019/12/19.
//

#import <UIKit/UIKit.h>
#import "KLKeyboardBarItem.h"

@interface KLKeyboardBar : UIView

@property (strong, nonatomic) void (^sendTextCompletion)(NSString *text);

- (void)addKeyboardItemWithType:(KLKeyboardBarItemType)type Image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage callBack:(void (^)(KLKeyboardBarItem *item))callBack;

// 输入框注册响应者
- (void)inputViewBecomeFirstResponder;

// 输入框注销响应者
- (void)inputViewResignTextFirstResponder;

// 录音按钮控制
- (void)hiddenRecordItem:(BOOL)hidden;

@end
