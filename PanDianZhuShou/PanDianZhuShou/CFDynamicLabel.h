//
//  CFDynamicLabel.h
//  PanDianZhuShou
//
//  Created by csh on 16/7/11.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFDynamicLabel : UIView

@property(nonatomic, copy) NSString* text;
@property(nonatomic, strong) UIColor* textColor;
@property(nonatomic, strong) UIFont* font;
@property(nonatomic, assign) CGFloat speed;

@end
