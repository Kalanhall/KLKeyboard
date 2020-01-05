//
//  KLChatRightCell.m
//  KLKeyboard_Example
//
//  Created by Logic on 2020/1/5.
//  Copyright © 2020 Kalanhall@163.com. All rights reserved.
//

#import "KLChatRightCell.h"
@import Masonry;

@implementation KLChatRightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.userIcon = UIImageView.alloc.init;
        self.userIcon.contentMode = UIViewContentModeScaleAspectFill;
        self.userIcon.clipsToBounds = YES;
        [self.contentView addSubview:self.userIcon];
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
        
        self.userName = UILabel.alloc.init;
        self.userName.textColor = UIColor.lightGrayColor;
        self.userName.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.userIcon.mas_left).offset(-10);
            make.top.mas_equalTo(self.userIcon);
        }];
    }
    return self;
}

@end
