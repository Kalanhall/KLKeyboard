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

@property (strong, nonatomic) KLKeyboard *keyboard;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.keyboard = KLKeyboard.new;
    [self.view addSubview:self.keyboard];
    [self.keyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0); // 高度自增长，不需要设定
    }];
    
    __weak typeof(self) weakself = self;
    [self.keyboard addKeyboardItemWithType:KLKeyboardItemTypeLeft
                                     Image:[UIImage imageNamed:@"kl_voice"]
                          highlightedImage:[UIImage imageNamed:@"kl_voice_h"]
                                  callBack:^(KLKeyboardItem * _Nonnull item) {
        if (item.mode == KLKeyboardItemModeNomal) {
            [item setImage:[UIImage imageNamed:@"kl_keboard"] highlightedImage:[UIImage imageNamed:@"kl_keboard_h"] forMode:KLKeyboardItemModeAnother];
            [weakself.keyboard inputViewResignTextFirstResponder];
            [weakself.keyboard hiddenRecordItem:NO];
            NSLogDebug(@"录音");
        } else {
            [item setImage:[UIImage imageNamed:@"kl_voice"] highlightedImage:[UIImage imageNamed:@"kl_voice_h"] forMode:KLKeyboardItemModeNomal];
            [weakself.keyboard inputViewBecomeFirstResponder];
            [weakself.keyboard hiddenRecordItem:YES];
            NSLogDebug(@"键盘");
        }
    }];
    
    [self.keyboard addKeyboardItemWithType:KLKeyboardItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_emoji"]
                          highlightedImage:[UIImage imageNamed:@"kl_emoji_h"]
                                  callBack:^(KLKeyboardItem * _Nonnull item) {
        NSLogDebug(@"表情");
    }];
    
    [self.keyboard addKeyboardItemWithType:KLKeyboardItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_more"]
                          highlightedImage:[UIImage imageNamed:@"kl_more_h"]
                                  callBack:^(KLKeyboardItem * _Nonnull item) {
        NSLogDebug(@"更多");
    }];
    
    self.keyboard.sendTextCompletion = ^(NSString *text) {
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
