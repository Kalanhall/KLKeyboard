//
//  KLKeyboardBarItem.h
//  KLKeyboardBarItem
//
//  Created by Logic on 2019/12/19.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KLKeyboardBarItemType) {
    KLKeyboardBarItemTypeLeft,
    KLKeyboardBarItemTypeRight
};

typedef NSInteger KLKeyboardBarItemSeq;

NS_ASSUME_NONNULL_BEGIN

// MARK: - 功能按钮
@interface KLKeyboardBarItem : UIButton

/// 用于扩展多种模式切换，使用序号进行标识，默认seq = 0
@property (assign, nonatomic) KLKeyboardBarItemSeq seq;

/// 添加另一种模式的按钮图片样式，等待下一次切换使用
///
/// @param image                            普通图片
/// @param highlightedImage    高亮图片
- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage forSeq:(KLKeyboardBarItemSeq)seq;

@end

// MARK: - 录音按钮
@interface KLKeyboardRecordItem : UIButton

@property (strong, nonatomic) void (^recordStartCompletion)(void);
@property (strong, nonatomic) void (^recordWillEndCompletion)(void);
@property (strong, nonatomic) void (^recordEndCompletion)(void);
@property (strong, nonatomic) void (^recordContinueCompletion)(void);
@property (strong, nonatomic) void (^recordCancleCompletion)(void);

@end

NS_ASSUME_NONNULL_END
