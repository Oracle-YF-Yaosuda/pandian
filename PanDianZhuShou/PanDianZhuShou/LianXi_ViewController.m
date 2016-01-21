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
    
    //设置view
    [self shezhi];
}
//设置VIEW
-(void)shezhi
{
    //微信
    self.WeinXin_View.layer.cornerRadius = 5.0;
    self.WeinXin_View.layer.borderWidth = 1.0;
    self.WeinXin_View.layer.borderColor = [UIColor colorWithHexString:@"00dcb4" alpha:1].CGColor;
    //QQ
    self.QQ_View.layer.cornerRadius = 5.0;
    self.QQ_View.layer.borderWidth = 1.0;
    self.QQ_View.layer.borderColor = [UIColor colorWithHexString:@"00dcb4" alpha:1].CGColor;
    //电话
    self.DianHuan_View.layer.cornerRadius = 5.0;
    self.DianHuan_View.layer.borderWidth = 1.0;
    self.DianHuan_View.layer.borderColor = [UIColor colorWithHexString:@"00dcb4" alpha:1].CGColor;
    }
//微信
- (IBAction)WeiXin_Button:(id)sender {
    
}
//qq
- (IBAction)QQ_Button:(id)sender {
    
}
//电话
- (IBAction)DianHuan_Button:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18390907126"]];
    
}
@end
