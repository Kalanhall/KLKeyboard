#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KLBaseKeyboard.h"
#import "KLEmojiKeyboard.h"
#import "KLFuncKeyboard.h"
#import "KLKeyboardBar.h"
#import "KLKeyboardBarItem.h"

FOUNDATION_EXPORT double KLKeyboardVersionNumber;
FOUNDATION_EXPORT const unsigned char KLKeyboardVersionString[];

