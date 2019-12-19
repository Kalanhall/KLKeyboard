//
//  KLViewController.m
//  KLKeyboard
//
//  Created by Kalanhall@163.com on 12/19/2019.
//  Copyright (c) 2019 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
@import KLKeyboard;
@import Masonry;
@import KLCategory;

@interface KLViewController ()

@property (strong, nonatomic) KLKeyboardBar *keyboardbar;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"表情键盘";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.keyboardbar = KLKeyboardBar.new;
    [self.view addSubview:self.keyboardbar];
    [self.keyboardbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0); // 高度自增长，不需要设定
    }];
    
    __weak typeof(self) weakself = self;
    [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeLeft
                                     Image:[UIImage imageNamed:@"kl_voice"]
                          highlightedImage:[UIImage imageNamed:@"kl_voice_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        if (item.mode == KLKeyboardBarItemModeNomal) {
            [item setImage:[UIImage imageNamed:@"kl_keboard"] highlightedImage:[UIImage imageNamed:@"kl_keboard_h"] forMode:KLKeyboardBarItemModeAnother];
            [weakself.keyboardbar inputViewResignTextFirstResponder];
            [weakself.keyboardbar hiddenRecordItem:NO];
            NSLogDebug(@"录音");
        } else {
            [item setImage:[UIImage imageNamed:@"kl_voice"] highlightedImage:[UIImage imageNamed:@"kl_voice_h"] forMode:KLKeyboardBarItemModeNomal];
            [weakself.keyboardbar inputViewBecomeFirstResponder];
            [weakself.keyboardbar hiddenRecordItem:YES];
            NSLogDebug(@"键盘");
        }
    }];
    
    [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_emoji"]
                          highlightedImage:[UIImage imageNamed:@"kl_emoji_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        NSLogDebug(@"表情");
    }];
    
    [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_more"]
                          highlightedImage:[UIImage imageNamed:@"kl_more_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        NSLogDebug(@"更多");
    }];
    
    self.keyboardbar.sendTextCompletion = ^(NSString *text) {
        NSLogNetwork(@"发送消息：%@", text);
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
//    KLViewController *vc = KLViewController.new;
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
