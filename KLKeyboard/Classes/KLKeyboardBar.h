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

/// 录音按钮
@property (strong, nonatomic, readonly) KLKeyboardRecordItem *recordItem;

/// 添加输入框左右两边的功能按钮
///
/// @param type                               按钮的类型
/// @param image                             普通图片
/// @param highlightedImage    高亮图片
/// @param callBack                      点击按钮回调
///
/// @return 返回按钮实例
- (KLKeyboardBarItem *)addKeyboardItemWithType:(KLKeyboardBarItemType)type Image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage callBack:(void (^)(KLKeyboardBarItem *item))callBack;

/// 输入框注册响应者
- (void)inputViewBecomeFirstResponder;

/// 输入框注销响应者
- (void)inputViewResignTextFirstResponder;

/// 录音按钮控制
- (void)hiddenRecordItem:(BOOL)hidden;

@end
