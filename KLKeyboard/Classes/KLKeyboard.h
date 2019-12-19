//
//  KLKeyboard.h
//  KLKeyboard
//
//  Created by Logic on 2019/12/19.
//

#import <UIKit/UIKit.h>
#import "KLKeyboardItem.h"

@interface KLKeyboard : UIView

@property (strong, nonatomic) void (^sendTextCompletion)(NSString *text);

- (void)addKeyboardItemWithType:(KLKeyboardItemType)type Image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage callBack:(void (^)(KLKeyboardItem *item))callBack;

// 输入框注册响应者
- (void)inputViewBecomeFirstResponder;

// 输入框注销响应者
- (void)inputViewResignTextFirstResponder;

// 录音按钮控制
- (void)hiddenRecordItem:(BOOL)hidden;

@end
