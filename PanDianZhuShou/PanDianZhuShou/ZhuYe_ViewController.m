//
//  ZhuYe_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "ZhuYe_ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Header.h"
#import "PanDian_ViewController.h"
#import "WarningBox.h"
@interface ZhuYe_ViewController ()

@end

@implementation ZhuYe_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//提交盘点结果点击事件
- (IBAction)TiJiao_Button:(id)sender {
    //如果上传成功  需要删除本地所有plist文件
    
}
//同步全部库存点击事假
- (IBAction)KuCun_Button:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html",nil ];
    //接收数据类型
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    //上传数据类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求地址
    NSString *url = [NSString stringWithFormat:  @"%@download",wangzhi ];
    //入参
    NSDictionary *params = @{@"username":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]] };
    //post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //返回数据转换json
        NSData *haha = responseObject;
        NSString *hehe =  [[NSString alloc]initWithData:haha encoding:NSUTF8StringEncoding];
        NSString* str = [hehe stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //转换为字典
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
      
        NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
        [dic writeToFile:path atomically:YES];
        NSLog(@"%@",NSHomeDirectory());
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

}
//同步异常数据点击事件
- (IBAction)ShuJu_Button:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html",nil ];
    //接收数据类型
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    //上传数据类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求地址
    NSString *url = [NSString stringWithFormat:  @"%@download",wangzhi ];
    //入参
    NSDictionary *params = @{@"username":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]] };
    //post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //返回数据转换json
        NSData *haha = responseObject;
        NSString *hehe =  [[NSString alloc]initWithData:haha encoding:NSUTF8StringEncoding];
        NSString* str = [hehe stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //转换为字典
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
        [dic writeToFile:path atomically:YES];
        NSLog(@"%@",dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}
//盘点药品点击事件
- (IBAction)PanDian_Button:(id)sender {
     NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [WarningBox warningBoxModeText:@"请同步数据!" andView:self.view];
    }else{
        PanDian_ViewController*pandian=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pandian"];
        [self.navigationController pushViewController:pandian animated:YES];
    }
    
}
@end
