//
//  KLKeyboardBar.m
//  KLKeyboardBar
//
//  Created by Logic on 2019/12/19.
//

#import "KLKeyboardBar.h"
@import Masonry;
@import KLCategory;

#define KLTEXTVIEWHEIGHT    36.0    // 文本默认高度
#define KLTEXTVIEWMAXHEIGHT 111.5f  // 4行文本的高度，由实际测试得出的结果

@interface KLKeyboardBar () <UITextViewDelegate>

@property (strong, nonatomic) UIStackView *leftStack;
@property (strong, nonatomic) UIStackView *rightStack;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) KLKeyboardRecordItem *recordItem;
@property (copy, nonatomic) NSString *currentText;

@end

@implementation KLKeyboardBar

// MARK: - System
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor kl_colorWithRGBA:250.0, 250.0, 250.0, 1.0, nil];
        
        self.leftStack = UIStackView.alloc.init;
        self.leftStack.spacing = 0;
        self.leftStack.axis = UILayoutConstraintAxisHorizontal;
        self.leftStack.alignment = UIStackViewAlignmentFill;
        self.leftStack.distribution = UIStackViewDistributionFillEqually;
        [self addSubview:self.leftStack];
        
        self.rightStack = UIStackView.alloc.init;
        self.rightStack.spacing = 0;
        self.rightStack.axis = UILayoutConstraintAxisHorizontal;
        self.rightStack.alignment = UIStackViewAlignmentFill;
        self.rightStack.distribution = UIStackViewDistributionFillEqually;
        [self addSubview:self.rightStack];
        
        self.textView = UITextView.alloc.init;
        self.textView.font = KLAutoFont(16.0);
        self.textView.returnKeyType = UIReturnKeySend;
        self.textView.layer.masksToBounds = YES;
        self.textView.layer.cornerRadius = 3;
        self.textView.textContainerInset = UIEdgeInsetsMake(self.textView.textContainerInset.top, 5, self.textView.textContainerInset.bottom, 5);
        self.textView.delegate = self;
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(7);
            make.bottom.mas_equalTo(-7 - KLAutoBottomInset());
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(KLTEXTVIEWHEIGHT);
        }];
        
        self.recordItem = [KLKeyboardRecordItem buttonWithType:UIButtonTypeCustom];
        self.recordItem.layer.masksToBounds = YES;
        self.recordItem.layer.cornerRadius = 3;
        [self.recordItem setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.recordItem setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [self.recordItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.recordItem setBackgroundImage:KLImageColor(UIColor.whiteColor) forState:UIControlStateNormal];
        [self.recordItem setBackgroundImage:KLImageHex(0xE5E5E5) forState:UIControlStateHighlighted];
        self.recordItem.titleLabel.font = KLAutoFont(14.0);
        [self addSubview:self.recordItem];
        
        // 录音按钮默认隐藏
        self.recordItem.alpha = 0;
        
        // 系统键盘通知监听
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {} // 重写，阻挡传递到控制器的touchbegin方法中

// MARK: - UIKeyboardNotification
- (void)keyboardWillShow:(NSNotification *)notification
{
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.transform = CGAffineTransformIdentity;
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
}

// MARK: - Private
- (void)addKeyboardItemWithType:(KLKeyboardBarItemType)type Image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage callBack:(void (^)(KLKeyboardBarItem *item))callBack
{
    // 创建KeyboardBarItem
    KLKeyboardBarItem *item = [KLKeyboardBarItem buttonWithType:UIButtonTypeCustom];
    [item setImage:image forState:UIControlStateNormal];
    [item setImage:highlightedImage forState:UIControlStateHighlighted];
    
    // 事件处理
    __weak typeof(item) weakitem = item;
    [item kl_controlEvents:UIControlEventTouchUpInside completion:^(UIButton * _Nonnull sender) {
        if (callBack) {
            callBack(weakitem);
        }
    }];
    
    // 左右菜单视图更新
    if (type == KLKeyboardBarItemTypeLeft) {
        [self.leftStack addArrangedSubview:item];
        [self.leftStack mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-7 - KLAutoBottomInset());
            make.height.mas_equalTo(KLTEXTVIEWHEIGHT);
            make.width.mas_equalTo(self.leftStack.mas_height).multipliedBy(self.leftStack.arrangedSubviews.count);
        }];
    } else {
        [self.rightStack addArrangedSubview:item];
        [self.rightStack mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-7 - KLAutoBottomInset());
            make.height.mas_equalTo(KLTEXTVIEWHEIGHT);
            make.width.mas_equalTo(self.leftStack.mas_height).multipliedBy(self.rightStack.arrangedSubviews.count);
        }];
    }
    
    // 约束更新
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.bottom.mas_equalTo(-7 - KLAutoBottomInset());
        make.left.mas_equalTo(self.leftStack.mas_right).offset(10);
        make.right.mas_equalTo(self.rightStack.mas_left).offset(-10);
        make.height.mas_equalTo(KLTEXTVIEWHEIGHT);
    }];
    
    [self.recordItem mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.width.height.mas_equalTo(self.textView);
    }];
}

- (void)reloadTextViewWithAnimation:(BOOL)animation
{
    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.kl_width, MAXFLOAT)].height;
    CGFloat height = textHeight > KLTEXTVIEWHEIGHT ? textHeight : KLTEXTVIEWHEIGHT;
    height = (textHeight <= KLTEXTVIEWMAXHEIGHT ? textHeight : KLTEXTVIEWMAXHEIGHT);
    [self.textView setScrollEnabled:textHeight > height];
    if (height != self.textView.kl_height) {
        if (animation) {
            [UIView animateWithDuration:0.2 animations:^{
                [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(height);
                }];
                if (self.superview) {
                    [self.superview layoutIfNeeded];
                }
            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
                }
            }];
        } else {
            [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            if (self.superview) {
                [self.superview layoutIfNeeded];
            }
            if (textHeight > height) {
                [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
            }
        }
    } else if (textHeight > height) {
        if (animation) {
            CGFloat offsetY = self.textView.contentSize.height - self.textView.kl_height;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.textView setContentOffset:CGPointMake(0, offsetY) animated:YES];
            });
        } else {
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.kl_height) animated:NO];
        }
    }
}

- (void)sendInputText
{
    if (self.textView.text.length > 0 && self.sendTextCompletion) {
        self.sendTextCompletion(self.textView.text);
    }
    self.textView.text = nil;
    [self reloadTextViewWithAnimation:YES];
}

- (void)inputViewBecomeFirstResponder
{
    [self.textView becomeFirstResponder];
}

- (void)inputViewResignTextFirstResponder
{
    [self.textView resignFirstResponder];
}

- (void)hiddenRecordItem:(BOOL)hidden
{
    [UIView animateWithDuration:0.15 animations:^{ self.recordItem.alpha = hidden ? 0 : 1; }];
    
    if (hidden) {
        // 显示文本
        self.textView.text = self.currentText;
        self.currentText = nil;
    } else {
        // 隐藏文本
        self.currentText = self.textView.text;
        self.textView.text = nil;
    }
    [self reloadTextViewWithAnimation:YES];
}

// MARK: - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        // 发送消息
        [self sendInputText];
        return NO;
    } else if (textView.text.length > 0 && [text isEqualToString:@""]) { // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location--;
                length++;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    [self reloadTextViewWithAnimation:YES];
                    return NO;
                } else if (c == ']') {
                    return YES;
                }
            }
        }
    }

    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self reloadTextViewWithAnimation:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self reloadTextViewWithAnimation:YES];
}

@end
