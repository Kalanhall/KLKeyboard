//
//  KLChatLeftCell.m
//  KLKeyboard_Example
//
//  Created by Logic on 2020/1/4.
//  Copyright © 2020 Kalanhall@163.com. All rights reserved.
//

#import "KLChatLeftCell.h"

@implementation KLChatLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

@end
