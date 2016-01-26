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
#import "SheZhi_ViewController.h"
@interface ZhuYe_ViewController ()
- (IBAction)tiaoshezhi:(id)sender;

@end

@implementation ZhuYe_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//提交盘点结果点击事件
- (IBAction)TiJiao_Button:(id)sender {
     NSString*path=[NSString stringWithFormat:@"%@/Documents/shangchuanshuju.plist",NSHomeDirectory()];
    NSFileManager*fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
    //如果上传成功  需要删除本地所有plist文件
    [WarningBox warningBoxModeIndeterminate:@"提交数据中..." andView:self.view];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html",nil ];
    //接收数据类型
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    //上传数据类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求地址
    NSString *url = [NSString stringWithFormat:  @"%@upload",wangzhi ];
    //入参
        NSMutableArray*shang1chuan=[[NSMutableArray alloc] init];
        NSArray*guodu=[NSArray arrayWithContentsOfFile:path];
        for (NSDictionary*dd in guodu) {
            NSMutableDictionary*guo=[[NSMutableDictionary alloc] init];
            [guo setValue:[dd objectForKey:@"shuliang"] forKey:@"imp_quantity"];
            [guo setValue:[dd objectForKey:@"imp_detail_id"] forKey:@"imp_detail_id"];
            [guo setValue:@"" forKey:@"scrq"];
            [shang1chuan addObject:guo];
        }
    NSDictionary *params = @{@"username":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]],@"password":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"pass"]],@"data":shang1chuan};
    //post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
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
        [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] andView:self.view];
        //删除本地文件
        NSFileManager *defaultManager;
        defaultManager = [NSFileManager defaultManager];
        NSString*path=[NSString stringWithFormat:@"%@/Documents/shangchuanshuju.plist",NSHomeDirectory()];
        NSString*path1=[NSString stringWithFormat:@"%@/Documents/xiazaishuju.plist",NSHomeDirectory()];
        [defaultManager removeItemAtPath:path error:NULL];
        [defaultManager removeItemAtPath:path1 error:NULL];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@", error ] andView:self.view];
        NSLog(@"%@",error);
        
    }];

    }else{
        [WarningBox warningBoxModeText:@"请先盘点数据!" andView:self.view];
    }

}
//同步全部库存点击事假
- (IBAction)KuCun_Button:(id)sender {
    [WarningBox warningBoxModeIndeterminate:@"全部库存同步中..." andView:self.view];
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
        [WarningBox warningBoxHide:YES andView:self.view];
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
        [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] andView:self.view];
        NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
        [dic writeToFile:path atomically:YES];
        NSLog(@"%@",dic);
        NSLog(@"%@",NSHomeDirectory());
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
         [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@", error ] andView:self.view];
        NSLog(@"%@",error);
        
    }];
    

}
//同步异常数据点击事件
- (IBAction)ShuJu_Button:(id)sender {
    [WarningBox warningBoxModeText:@"异常数据同步中..." andView:self.view];
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
        [WarningBox warningBoxHide:YES andView:self.view];
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
        [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] andView:self.view];
        NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
        [dic writeToFile:path atomically:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@", error ] andView:self.view];
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
- (IBAction)tiaoshezhi:(id)sender {
    SheZhi_ViewController*shezhi=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"shezhi"];
    [self.navigationController pushViewController:shezhi animated:YES];
}
@end
