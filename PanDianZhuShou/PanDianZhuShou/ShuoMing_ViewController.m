//
//  ShuoMing_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "ShuoMing_ViewController.h"
#define zitifont  [UIFont systemFontOfSize:15]
#define ziticolor [UIColor blackColor]
@interface ShuoMing_ViewController ()
{
    CGFloat width;
    CGFloat height;
}
@end

@implementation ShuoMing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    //解决多出部分
    self.automaticallyAdjustsScrollViewInsets = NO;
    //穿件
    [self chuanjian];
}
//穿件view
-(void)chuanjian
{
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, width-20, 42)];
    lab1.font =zitifont;
    lab1.numberOfLines = 0;
    lab1.textColor = ziticolor;
    lab1.text = @"1.首先打开手机蓝牙功能，将蓝牙扫码枪与手机进行配对连接。";
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 52, width-20, 63)];
    lab2.font =zitifont;
    lab2.numberOfLines = 0;
    lab2.textColor = ziticolor;
    lab2.text = @"2.连接成功后，打开“盘点助手”手机客户端，输入门店员工的用户名和密码后，点击“登录”按钮进入“盘点助手”的主页面。";
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 115, width-20, 63)];
    lab3.font =zitifont;
    lab3.numberOfLines = 0;
    lab3.textColor = ziticolor;
    lab3.text = @"3.停留在主页面，此时点击“同步全部库存”按钮，获取该门店的药品库存信息，然后点击“盘点药品”按钮进入药品盘点页面。";
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 178, width-20, 136)];
    lab4.font =zitifont;
    lab4.numberOfLines = 0;
    lab4.textColor = ziticolor;
    lab4.text = @"4.在“盘点药品”页面，用蓝牙码枪对准药品条形码扫描，显示药品信息，输入药品数量和生产日期后（合并药品批号盘点时，不需要输入日期），点击“确定”按钮完成药品盘点。对于没有条形码的药品，可以点击标题栏上的开关，打开手动输入模式录入药品编号进行药品盘点。";
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 314, width-20, 42)];
    lab5.font =zitifont;
    lab5.numberOfLines = 0;
    lab5.textColor = ziticolor;
    lab5.text = @"5.盘点结束后，回到主页面，点击“提交盘点结果”上传盘点数据，完成整个盘点操作。";
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 356, width-20, 63)];
    lab6.font =zitifont;
    lab6.numberOfLines = 0;
    lab6.textColor = ziticolor;
    lab6.text = @"6.对于在盘点计算完成后，无法核对正确数据的药品，点击“同步异常数据”可以将这些异常数据下载到本地，重新进行盘点提交。";
    
    [self.scroll_view addSubview:lab1];
    [self.scroll_view addSubview:lab2];
    [self.scroll_view addSubview:lab3];
    [self.scroll_view addSubview:lab4];
    [self.scroll_view addSubview:lab5];
    [self.scroll_view addSubview:lab6];
}


@end
