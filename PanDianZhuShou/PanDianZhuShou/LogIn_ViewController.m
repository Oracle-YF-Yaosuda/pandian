//
//  LogIn_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "LogIn_ViewController.h"
#import "Header.h"
#import "NavigationController.h"

#import "AFHTTPRequestOperationManager.h"
#import "WarningBox.h"
#import "SBJsonWriter.h"

@interface LogIn_ViewController ()

@end

@implementation LogIn_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Password_Text.delegate=self;
    _Username_Text.delegate=self;
    _Username_Text.text=@"fdfapp";
    _Password_Text.text=@"123456";
    //设置  textfield  placeholder  颜色
    [self text_placeholder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_Username_Text) {
        [_Username_Text resignFirstResponder];
        [_Password_Text becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
        [self LogIn_Button:nil];
    }
    return YES;
}
//设置  textfield  placeholder  颜色
-(void)text_placeholder
{
    //账号textfield  placeholder  颜色
    self.Username_Text.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.Username_Text.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    //密码textfield  placeholder  颜色
    self.Password_Text.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.Password_Text.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (IBAction)LogIn_Button:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html",nil ];
    //接收数据类型
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    //上传数据类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求地址
    NSString *url = [NSString stringWithFormat:  @"%@login",wangzhi ];
    //入参
    NSDictionary *params = @{@"username":_Username_Text.text,@"password":_Password_Text.text };
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
  
        if ([[dic objectForKey:@"flag"] intValue]==1) {
            NavigationController*chaxun=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"navigationcontroller"];
            
            [self presentViewController:chaxun animated:YES completion:^{

            }];
  
        }
  
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}
@end
