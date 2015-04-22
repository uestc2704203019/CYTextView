//
//  LYTextView.h
//  LUSIR
//
//  Created by longyuan on 15/4/22.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTextView : UITextView

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) int numberLimit;
@property (nonatomic, assign) BOOL limitNumberHidden;

@end
