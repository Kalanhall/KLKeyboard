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
    
    // MARK: 通过枚举KLKeyboardBarItemSeq完成按钮2种模式下的切换
    __weak typeof(self) weakself = self;
    KLKeyboardBarItem *item = [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeLeft
                                                                  Image:[UIImage imageNamed:@"kl_voice"]
                                                       highlightedImage:[UIImage imageNamed:@"kl_voice_h"]
                                                               callBack:^(KLKeyboardBarItem * _Nonnull item) {
        item.seq = item.seq == 0 ? 110 : 0;
        
        if (item.seq == 110) {
            [weakself.keyboardbar inputViewResignTextFirstResponder];
            [weakself.keyboardbar hiddenRecordItem:NO];
            NSLogDebug(@"录音");
        } else {
            [weakself.keyboardbar inputViewBecomeFirstResponder];
            [weakself.keyboardbar hiddenRecordItem:YES];
            NSLogDebug(@"键盘");
        }
    }];
    // 第二种模式显示的图片样式
    [item setImage:[UIImage imageNamed:@"kl_keboard"] highlightedImage:[UIImage imageNamed:@"kl_keboard_h"] forSeq:110];
    
    //  MARK: 表情键盘调用
    [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_emoji"]
                          highlightedImage:[UIImage imageNamed:@"kl_emoji_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        NSLogDebug(@"表情");
    }];
    
    // MARK: 更多功能键盘调用
    [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_more"]
                          highlightedImage:[UIImage imageNamed:@"kl_more_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        NSLogDebug(@"更多");
    }];
    
    // MARK: 发送消息回调
    self.keyboardbar.sendTextCompletion = ^(NSString *text) {
        NSLogNetwork(@"发送消息：%@", text);
    };
    
    // MARK: 录音相关回调
    self.keyboardbar.recordItem.recordStartCompletion = ^{
        NSLogDebug(@"开始录音");
    };
    self.keyboardbar.recordItem.recordCancleCompletion = ^{
        NSLogDebug(@"取消录音");
    };
    self.keyboardbar.recordItem.recordEndCompletion = ^{
        NSLogDebug(@"结束录音");
    };
    self.keyboardbar.recordItem.recordWillEndCompletion = ^{
        NSLogDebug(@"移出按钮外，即将结束录音");
    };
    self.keyboardbar.recordItem.recordContinueCompletion = ^{
        NSLogDebug(@"由外部移入按钮内，继续录音");
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
//    KLViewController *vc = KLViewController.new;
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
