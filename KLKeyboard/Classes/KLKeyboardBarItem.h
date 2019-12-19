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

typedef NS_ENUM(NSUInteger, KLKeyboardBarItemMode) {
    KLKeyboardBarItemModeNomal,
    KLKeyboardBarItemModeAnother
};

NS_ASSUME_NONNULL_BEGIN

// MARK: - 功能按钮
@interface KLKeyboardBarItem : UIButton

@property (assign, nonatomic) KLKeyboardBarItemMode mode;          // 用于功能形态切换 录音/键盘 互切

- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage forMode:(KLKeyboardBarItemMode)mode;

@end

// MARK: - 录音按钮
@interface KLKeyboardRecordItem : UIButton


@end

NS_ASSUME_NONNULL_END
