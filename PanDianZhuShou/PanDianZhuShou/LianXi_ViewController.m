//
//  LianXi_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "LianXi_ViewController.h"
#import "Color+Hex.h"
@interface LianXi_ViewController ()

@end

@implementation LianXi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置view圆角
    [self View_yuanjiao];
   
}

//设置view圆角
-(void)View_yuanjiao
{
    //微信
    //圆角
    self.WeiXin_View.layer.cornerRadius = 5.0;
    //边框颜色
    self.WeiXin_View.layer.borderColor = [UIColor colorWithHexString:@"00eac3" alpha:1].CGColor;
    //边框宽度
    self.WeiXin_View.layer.borderWidth = 1.0;
    //qq
    //圆角
    self.QQ_View.layer.cornerRadius = 5.0;
     //边框颜色
    self.QQ_View.layer.borderColor = [UIColor colorWithHexString:@"00eac3" alpha:1].CGColor;
    //边框宽度
    self.QQ_View.layer.borderWidth = 1.0;
    //电话
    //圆角
    self.DianHua_View.layer.cornerRadius = 5.0;
     //边框颜色
    self.DianHua_View.layer.borderColor = [UIColor colorWithHexString:@"00eac3" alpha:1].CGColor;
    //边框宽度
    self.DianHua_View.layer.borderWidth = 1.0;
}

//微信点击事件
- (IBAction)WeiXin_Button:(id)sender {
}
//QQ点击事件
- (IBAction)QQ_Button:(id)sender {
}
//电话点击事件
- (IBAction)DianHuan_Button:(id)sender {
}
@end
