//
//  KLKeyboardBarItem.m
//  KLKeyboardBarItem
//
//  Created by Logic on 2019/12/19.
//

#import "KLKeyboardBarItem.h"
@import KLCategory;

@implementation KLKeyboardBarItem

- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage forMode:(KLKeyboardBarItemMode)mode
{
    self.mode = mode;
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
}

@end

@implementation KLKeyboardRecordItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        [self addTarget:self action:@selector(talkButtonDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(talkButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(talkButtonUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(talkButtonDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(talkButtonDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    }
    return self;
}

/// 开始录音
- (void)talkButtonDown:(UIButton *)sender
{
    NSLogDebug(@"开始录音");
}

/// 停止录音
- (void)talkButtonUpInside:(UIButton *)sender
{
    NSLogDebug(@"结束录音");
}

/// 取消录音
- (void)talkButtonUpOutside:(UIButton *)sender
{
    NSLogDebug(@"取消录音");
}

/// 取消录音
- (void)talkButtonDragInside:(UIButton *)sender
{
    NSLogDebug(@"继续录音");
}

/// 取消录音
- (void)talkButtonDragOutside:(UIButton *)sender
{
    NSLogDebug(@"松开结束");
}

@end
