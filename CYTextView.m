//
//  LYTextView.m
//  LUSIR
//
//  Created by longyuan on 15/4/22.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "CYTextView.h"
#define kDefaultFont [UIFont systemFontOfSize:14]
#define kPlaceHolderColor [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1]

@interface CYTextView () <UITextViewDelegate>
{
    UILabel *_tipLabel;
    UILabel *_numberLabel;
}
@end

@implementation CYTextView

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [self createContent];
    UIFont *tipFont = (self.font == nil)?kDefaultFont:self.font;
    CGSize size = [placeHolder sizeWithAttributes:@{NSFontAttributeName:tipFont}];
    CGRect tipFrame = _tipLabel.frame;
    tipFrame.size = size;
    _tipLabel.frame = tipFrame;
    _tipLabel.font = tipFont;
    _tipLabel.text = _placeHolder;
}

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    [self createContent];
    CGRect tipFrame = _tipLabel.frame;
    tipFrame.origin.x = 5;
    tipFrame.origin.y = 5;
    _tipLabel.frame = tipFrame;
    CGRect numberFrame = _numberLabel.frame;
    numberFrame.origin.y = frame.size.height-numberFrame.size.height;
    numberFrame.origin.x = frame.size.width-numberFrame.size.width;
    _numberLabel.frame = numberFrame;
}

- (void)setFont:(UIFont *)font
{
    super.font = font;
    [self createContent];
    _tipLabel.font = font;
    _numberLabel.font = font;
}

- (void)setNumberLimit:(int)numberLimit
{
    _numberLimit = numberLimit;
    [self createContent];
    UIFont *tipFont = (self.font == nil)?kDefaultFont:self.font;
    CGSize size = [[NSString stringWithFormat:@"%d",_numberLimit] sizeWithAttributes:@{NSFontAttributeName:tipFont}];
    CGRect tipFrame = _numberLabel.frame;
    tipFrame.size = size;
    tipFrame.origin.x -= size.width;
    tipFrame.origin.y -= size.height;
    _numberLabel.frame = tipFrame;
    _numberLabel.font = tipFont;
    _numberLabel.text = [NSString stringWithFormat:@"%d",_numberLimit];
}

- (void)setLimitNumberHidden:(BOOL)limitNumberHidden
{
    _limitNumberHidden = limitNumberHidden;
    [self createContent];
    if (_limitNumberHidden) {
        _numberLabel.hidden = YES;
    }else{
        _numberLabel.hidden = NO;
    }
}

- (void)createContent
{
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = kPlaceHolderColor;
        [self addSubview:_tipLabel];
    }
    if (self.delegate == nil) {
        self.delegate = self;
    }
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = kPlaceHolderColor;
        [self addSubview:_numberLabel];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *showText = [[NSMutableString alloc] initWithString:textView.text];
    [showText replaceCharactersInRange:range withString:text];
    if (showText.length>0) {
        _tipLabel.hidden = YES;
    }else{
        _tipLabel.hidden = NO;
    }
    if (showText.length <= _numberLimit) {
        _numberLabel.text = [NSString stringWithFormat:@"%d",_numberLimit-(int)showText.length];
        return YES;
    }else{
        return NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
