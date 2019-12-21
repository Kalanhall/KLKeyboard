//
//  KLFuncKeyboard.m
//  KLKeyboard
//
//  Created by Kalan on 2019/12/21.
//

#import "KLFuncKeyboard.h"
@import KLCategory;

@implementation KLFuncKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.kl_randomColor;
    }
    return self;
}

@end
