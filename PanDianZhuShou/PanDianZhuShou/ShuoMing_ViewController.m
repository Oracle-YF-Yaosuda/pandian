//
//  ShuoMing_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "ShuoMing_ViewController.h"

@interface ShuoMing_ViewController ()

@end

@implementation ShuoMing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   self.ShuoMing.text = @"1.首先打开手机蓝牙功能，将蓝牙扫码枪与手机进行配对连接。\n\n2.连接成功后，打开“盘点助手”手机客户端，输入门店员工的用户名和密码后，点击“登录”按钮进入“盘点助手”的主页面。\n\n3.在主页面，点击“同步全部库存”按钮，获取该门店的药品库存信息，然后点击“盘点药品”按钮进入药品盘点页面。\n\n4.在“盘点药品”页面，用蓝牙码枪对准药品条形码扫描，显示药品信息，输入药品数量和生产日期后（合并药品批号盘点时，不需要输入日期），点击“确定”按钮完成药品盘点。对于没有条形码的药品，可以点击标题栏上的开关，打开手动输入模式录入药品编号进行药品盘点。\n\n5.盘点结束后，回到主页面，点击“提交盘点结果”上传盘点数据，完成整个盘点操作。\n\n6.对于在盘点计算完成后，无法核对正确数据的药品，点击“同步异常数据”可以将这些异常数据下载到本地，重新进行盘点提交。";
}

@end
