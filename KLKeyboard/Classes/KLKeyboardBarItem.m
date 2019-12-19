//
//  KLKeyboardBarItem.m
//  KLKeyboardBarItem
//
//  Created by Logic on 2019/12/19.
//

#import "KLKeyboardBarItem.h"
@import KLCategory;

@interface KLKeyboardBarItem ()

@property (strong, nonatomic) NSMutableDictionary *imageInfo;

@end

@implementation KLKeyboardBarItem

- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage forSeq:(KLKeyboardBarItemSeq)seq
{
    NSAssert(image != nil && highlightedImage != nil, @"图片不可为空!");
    [self.imageInfo setValue:@[image, highlightedImage] forKey:@(seq).description];
    if (self.imageInfo.allKeys.count == 1) {
        // 首次添加，设为默认显示图片
        self.seq = seq;
    }
}

- (NSMutableDictionary *)imageInfo
{
    if (_imageInfo == nil) {
        _imageInfo = NSMutableDictionary.dictionary;
    }
    return _imageInfo;
}

- (void)setSeq:(KLKeyboardBarItemSeq)seq
{
    _seq = seq;
    // 设置当前图片样式
    NSArray *imageInfo = [self.imageInfo valueForKey:@(seq).description];
    [self setImage:imageInfo.firstObject forState:UIControlStateNormal];
    [self setImage:imageInfo.lastObject forState:UIControlStateHighlighted];
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
    if (self.recordStartCompletion) {
        self.recordStartCompletion();
    }
}

/// 停止录音
- (void)talkButtonUpInside:(UIButton *)sender
{
    if (self.recordEndCompletion) {
        self.recordEndCompletion();
    }
}

/// 取消录音
- (void)talkButtonUpOutside:(UIButton *)sender
{
    if (self.recordCancleCompletion) {
        self.recordCancleCompletion();
    }
}

/// 由外部移入按钮内，继续录音
- (void)talkButtonDragInside:(UIButton *)sender
{
    if (self.recordContinueCompletion) {
        self.recordContinueCompletion();
    }
}

/// 移出按钮外，即将结束录音
- (void)talkButtonDragOutside:(UIButton *)sender
{
    if (self.recordWillEndCompletion) {
        self.recordWillEndCompletion();
    }
}

@end
