//
//  UIViewController+LogKLExtension.m
//  KLExtensions
//
//  Created by Logic on 2019/11/20.
//

#import "UIViewController+KLLogExtension.h"
#import "NSLogger.h"
#import "NSRuntime.h"

@implementation UIViewController (KLLogKLExtension)

#ifdef DEBUG

+ (void)load {
    KLExchangeImplementations(self, @selector(viewDidLoad), self, @selector(kl_viewDidLoad));
    KLExchangeImplementations(self, NSSelectorFromString(@"dealloc"), self, @selector(kl_dealloc));
}

- (void)kl_viewDidLoad {
    NSLogNotice(@"%@ viewDidLoad", self);
    [self kl_viewDidLoad];
}

- (void)kl_dealloc {
    NSLogNotice(@"%@ dealloc", self);
    [self kl_dealloc];
}

#endif

@end
