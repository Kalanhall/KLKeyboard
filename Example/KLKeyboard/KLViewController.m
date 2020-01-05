//
//  KLViewController.m
//  KLKeyboard
//
//  Created by Kalanhall@163.com on 12/19/2019.
//  Copyright (c) 2019 Kalanhall@163.com. All rights reserved.
//

#import "KLViewController.h"
#import "KLChatLeftCell.h"
#import "KLChatRightCell.h"
@import KLKeyboard;
@import Masonry;
@import KLCategory;

@interface KLViewController () <UITableViewDelegate, UITableViewDataSource>

/// 聊天窗
@property (strong, nonatomic) UITableView *chatView;
/// 输入栏
@property (strong, nonatomic) KLKeyboardBar *keyboardbar;
/// 语音按钮
@property (strong, nonatomic) KLKeyboardBarItem *voiceItem;
/// 表情按钮
@property (strong, nonatomic) KLKeyboardBarItem *emojiItem;
/// 更多按钮
@property (strong, nonatomic) KLKeyboardBarItem *moreItem;
/// 表情键盘
@property (strong, nonatomic) KLEmojiKeyboard *emojiKeyboard;
/// 功能键盘
@property (strong, nonatomic) KLFuncKeyboard *funcKeyboard;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"表情键盘";
    self.view.backgroundColor = [UIColor kl_colorWithRGBA:250.0, 250.0, 250.0, 1.0, nil];
    
    // 设置背景图
    UIImage *image = [UIImage imageNamed:@"bg"];
    self.view.layer.contents = (id)image.CGImage;
    
    self.keyboardbar = KLKeyboardBar.alloc.init;
    [self.view addSubview:self.keyboardbar];
    [self.keyboardbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0); // 高度自增长，不需要设定
    }];
    
    [self.keyboardbar addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:nil];
    
    self.chatView = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.chatView.backgroundColor = UIColor.clearColor;
    self.chatView.delegate = self;
    self.chatView.dataSource = self;
    self.chatView.estimatedRowHeight = 50;
    self.chatView.estimatedSectionHeaderHeight = 0;
    self.chatView.estimatedSectionFooterHeight = 0;
    self.chatView.rowHeight = UITableViewAutomaticDimension;
    self.chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatView.showsVerticalScrollIndicator = NO;
    [self.view insertSubview:self.chatView belowSubview:self.keyboardbar];
    [self.chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.keyboardbar.mas_top);
    }];
    [self.chatView registerClass:KLChatLeftCell.class forCellReuseIdentifier:KLChatLeftCell.description];
    [self.chatView registerClass:KLChatRightCell.class forCellReuseIdentifier:KLChatRightCell.description];
    
    __weak typeof(self) weakself = self;
    
    self.keyboardbar.textViewShouldBeginEditing = ^{
        weakself.emojiItem.seq = 0;
        weakself.moreItem.tag = 0;
    };
    
    // MARK: 通过枚举KLKeyboardBarItemSeq完成按钮2种模式下的切换
    self.voiceItem = [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeLeft
                                                                  Image:[UIImage imageNamed:@"kl_voice"]
                                                       highlightedImage:[UIImage imageNamed:@"kl_voice_h"]
                                                               callBack:^(KLKeyboardBarItem * _Nonnull item) {
        weakself.voiceItem.seq = weakself.voiceItem.seq == 0 ? 1 : 0;
        
        if (weakself.voiceItem.seq == 1) {
            [weakself.keyboardbar inputViewResignTextFirstResponder];
            [weakself.keyboardbar hiddenRecordItem:NO cacheText:YES];
            NSLogDebug(@"录音");
        } else {
            [weakself.keyboardbar inputViewBecomeFirstResponder];
            [weakself.keyboardbar hiddenRecordItem:YES cacheText:YES];
            NSLogDebug(@"键盘");
        }
        
        // 还原表情按钮状态
        weakself.emojiItem.seq = 0;
        weakself.moreItem.tag = 0;
        // 隐藏表情键盘
        [weakself.emojiKeyboard hideKeyboardAnimated:YES];
        [weakself.funcKeyboard hideKeyboardAnimated:YES];
    }];
    // 第二种模式显示的图片样式
    [self.voiceItem setImage:[UIImage imageNamed:@"kl_keboard"] highlightedImage:[UIImage imageNamed:@"kl_keboard_h"] forSeq:1];
    
    //  MARK: 表情键盘调用
    self.emojiKeyboard = KLEmojiKeyboard.new;
    [self.emojiKeyboard bindingKeyboardBar:self.keyboardbar];
    self.emojiItem = [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_emoji"]
                          highlightedImage:[UIImage imageNamed:@"kl_emoji_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        
        weakself.emojiItem.seq = weakself.emojiItem.seq == 0 ? 1 : 0;
        if (weakself.emojiItem.seq == 1) {
            [weakself.emojiKeyboard showKeyboardInView:weakself.view animated:YES];
            [weakself.keyboardbar inputViewResignTextFirstResponder];
            NSLogDebug(@"表情");
        } else {
            [weakself.keyboardbar inputViewBecomeFirstResponder];
            [weakself.emojiKeyboard hideKeyboardAnimated:YES];
            NSLogDebug(@"键盘");
        }
        
        // 还原录音按钮状态
        weakself.voiceItem.seq = 0;
        weakself.moreItem.tag = 0;
        // 隐藏录音视图
        [weakself.keyboardbar hiddenRecordItem:YES  cacheText:NO];
    }];
    [self.emojiItem setImage:[UIImage imageNamed:@"kl_keboard"] highlightedImage:[UIImage imageNamed:@"kl_keboard_h"] forSeq:1];
    
    // MARK: 更多功能键盘调用
    self.funcKeyboard = KLFuncKeyboard.new;
    [self.funcKeyboard bindingKeyboardBar:self.keyboardbar];
    self.moreItem = [self.keyboardbar addKeyboardItemWithType:KLKeyboardBarItemTypeRight
                                     Image:[UIImage imageNamed:@"kl_more"]
                          highlightedImage:[UIImage imageNamed:@"kl_more_h"]
                                  callBack:^(KLKeyboardBarItem * _Nonnull item) {
        
        weakself.moreItem.tag = weakself.moreItem.tag == 0 ? 1 : 0;
        if (weakself.moreItem.tag == 1) {
            [weakself.funcKeyboard showKeyboardInView:weakself.view animated:YES];
            [weakself.keyboardbar inputViewResignTextFirstResponder];
            NSLogDebug(@"展示更多");
        } else {
            [weakself.keyboardbar inputViewBecomeFirstResponder];
            [weakself.funcKeyboard hideKeyboardAnimated:YES];
            NSLogDebug(@"隐藏更多");
        }
        
        // 还原表情按钮状态
        weakself.voiceItem.seq = 0;
        weakself.emojiItem.seq = 0;
        // 隐藏录音视图
        [weakself.keyboardbar hiddenRecordItem:YES cacheText:NO];
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

- (void)dealloc
{
    [self removeObserver:self.keyboardbar forKeyPath:@"transform"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"transform"]) {
        id temp = change[@"new"];
        CGAffineTransform transform = [temp CGAffineTransformValue];
        self.chatView.transform = CGAffineTransformMakeTranslation(0, transform.ty);
    }
}

- (void)resetKeyboard
{
    // 重置为原始样式
    [self.view endEditing:YES];
    self.emojiItem.seq = 0;
    self.moreItem.tag = 0;
    [self.emojiKeyboard hideKeyboardAnimated:YES];
    [self.funcKeyboard hideKeyboardAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        KLChatLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:KLChatLeftCell.description];
        cell.userName.text = [NSString stringWithFormat:@"Somebody - %@", @(indexPath.row)];
        cell.userIcon.image = [UIImage imageNamed:@"kl_emoji"];
        [cell kl_setTapCompletion:^(UITapGestureRecognizer *tapGesture) {
            [self resetKeyboard];
        }];
        return cell;
    } else {
        KLChatRightCell *cell = [tableView dequeueReusableCellWithIdentifier:KLChatRightCell.description];
        cell.userName.text = [NSString stringWithFormat:@"Somebody - %@", @(indexPath.row)];
        cell.userIcon.image = [UIImage imageNamed:@"kl_emoji_h"];
        [cell kl_setTapCompletion:^(UITapGestureRecognizer *tapGesture) {
            [self resetKeyboard];
        }];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self resetKeyboard];
}

@end
