//
//  KLEmojiKeyboard.m
//  KLKeyboard
//
//  Created by Kalan on 2019/12/21.
//

#import "KLEmojiKeyboard.h"
@import KLCategory;

@implementation KLEmojiKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.kl_randomColor;
        self.kl_keyboardHeight = 300;
    }
    return self;
}

@end
