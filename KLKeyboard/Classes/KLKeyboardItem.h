//
//  KLKeyboardItem.h
//  KLKeyboard
//
//  Created by Logic on 2019/12/19.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KLKeyboardItemType) {
    KLKeyboardItemTypeLeft,
    KLKeyboardItemTypeRight
};

typedef NS_ENUM(NSUInteger, KLKeyboardItemMode) {
    KLKeyboardItemModeNomal,
    KLKeyboardItemModeAnother
};

NS_ASSUME_NONNULL_BEGIN

// MARK: - 功能按钮
@interface KLKeyboardItem : UIButton

@property (assign, nonatomic) KLKeyboardItemMode mode;          // 用于功能形态切换 录音/键盘 互切

- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage forMode:(KLKeyboardItemMode)mode;

@end

// MARK: - 录音按钮
@interface KLKeyboardRecordItem : UIButton


@end

NS_ASSUME_NONNULL_END
