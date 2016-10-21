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
@interface ZhuYe_ViewController (){
    int hahaha;
}
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
        
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提交提示" message:@"确定要提交盘点结果吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            hahaha=1;
            [self shang:path];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }else{
        [WarningBox warningBoxModeText:@"请先盘点数据!" andView:self.view];
    }
    
}
-(void)shang:(NSString*)path{
    //如果上传成功  需要删除本地所有plist文件
    [WarningBox warningBoxModeIndeterminate:@"提交数据中..." andView:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html",nil ];
    //接收数据类型
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    //上传数据类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求地址
    NSString *url = [NSString stringWithFormat:@"%@upload",wangzhi ];
    //入参
    NSMutableArray*shang1chuan=[[NSMutableArray alloc] init];
    NSArray*guodu=[NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary*dd in guodu) {
        NSMutableDictionary*guo=[[NSMutableDictionary alloc] init];
        [guo setValue:[dd objectForKey:@"shuliang"] forKey:@"imp_quantity"];//数量
        [guo setValue:[dd objectForKey:@"imp_detail_id"] forKey:@"imp_detail_id"];//id
        [guo setValue:[dd objectForKey:@"date"] forKey:@"scrq"];//时间
        [guo setValue:[dd objectForKey:@"ypbh"] forKey:@"code"];//编号
        [guo setValue:[dd objectForKey:@"ph"] forKey:@"license_number"];//批号
        [guo setValue:[dd objectForKey:@"license_flag"] forKey:@"license_flag"];//数据标识
        [guo setValue:[dd objectForKey:@"hwh"] forKey:@"hwh"];//货位号
        [guo setValue:[dd objectForKey:@"hwh_flag"] forKey:@"hwh_flag"];//货位标识
        [guo setValue:[dd objectForKey:@"txm"] forKey:@"txm"];//条形码
        [guo setValue:[dd objectForKey:@"new_added"] forKey:@"new_added"];//新增产品标识
        [shang1chuan addObject:guo];
    }
    
    NSLog(@"%@",shang1chuan);
    
    NSDictionary *params = @{@"username":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"name"]],@"password":[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"pass"]],@"data":shang1chuan};
    // NSLog(@"%@",params);
    
    //post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [WarningBox warningBoxHide:YES andView:self.view];
        @try
        {
            
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
            NSLog(@"%@",dic);
            if([[dic objectForKey:@"flag"] intValue]==1){
                
                [WarningBox warningBoxModeText:[NSString stringWithFormat:@"成功提交%lu 条数据，请等待后台处理",(unsigned long)shang1chuan.count ] andView:self.view];
                
            }else{
                [WarningBox warningBoxModeText:@"提交未成功，请重试..." andView:self.view];
            }
        }
        @catch (NSException * e) {
            [WarningBox warningBoxModeText:@"请仔细检查你的网络!" andView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败!" andView:self.view];
        NSLog(@"%@",error);
        
    }];
    
    
}
-(void)tongbulea{
    
    if (hahaha==0) {
        [WarningBox warningBoxModeIndeterminate:@"异常数据同步中..." andView:self.view];
    }
    else
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
        @try
        {
            //删除本地文件
            NSFileManager *defaultManager;
            defaultManager = [NSFileManager defaultManager];
            NSString*path=[NSString stringWithFormat:@"%@/Documents/shangchuanshuju.plist",NSHomeDirectory()];
            NSString*path1=[NSString stringWithFormat:@"%@/Documents/xiazaishuju.plist",NSHomeDirectory()];
            [defaultManager removeItemAtPath:path error:NULL];
            [defaultManager removeItemAtPath:path1 error:NULL];
            
            
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
            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"flag"]intValue]==1) {
                for (int i=0; i<[[dic objectForKey:@"data"] count]; i++) {
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"gg"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"gg"];
                        
                        
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"mnemonic_code"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"mnemonic_code"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"hwh"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"hwh"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"'imp_detail_id'"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"'imp_detail_id'"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"ph"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"ph"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"pzwh"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"pzwh"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"sccj"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"sccj"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"txm"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"txm"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"ypbh"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"ypbh"];
                    }
                    if ([[[dic objectForKey:@"data"][i] objectForKey:@"ypmc"]isEqual:[NSNull null]]) {
                        [[dic objectForKey:@"data"][i] setObject:@"" forKey:@"ypmc"];
                    }
                }
                if (hahaha==0) {
                    [WarningBox warningBoxModeText:@"同步异常数据成功!" andView:self.view];
                }else
                    [WarningBox warningBoxModeText:@"同步全部库存成功!" andView:self.view];
                NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
                [dic writeToFile:path atomically:YES];
                NSLog(@"%@",dic);
                NSLog(@"%@",NSHomeDirectory());
                
            }
            else{
                [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] andView:self.view];
            }
        }
        @catch (NSException * e) {
            [WarningBox warningBoxModeText:@"请仔细检查你的网络!" andView:self.view];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败!" andView:self.view];
        NSLog(@"%@",error);
        
    }];
    
    
}
//同步全部库存点击事假
- (IBAction)KuCun_Button:(id)sender {
    
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path1]) {
        hahaha=1;
        [self tongbulea];
    }else{
        
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"同步提示" message:@"同步全部库存将会清空本次盘点未提交的数据,确定要同步全部数据吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            hahaha=1;
            [self tongbulea];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}
//同步异常数据点击事件
- (IBAction)ShuJu_Button:(id)sender {
    
    
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path1]) {
        hahaha=0;
        [self tongbulea];
    }else{
        
        
        
        
        UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"同步提示" message:@"同步异常数据将会清空本次盘点未提交的数据,确定要同步异步数据吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            hahaha=0;
            [self tongbulea];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
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
