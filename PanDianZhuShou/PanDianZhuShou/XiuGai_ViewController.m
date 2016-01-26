//
//  XiuGai_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "XiuGai_ViewController.h"
#import "WarningBox.h"
#import "AFHTTPRequestOperationManager.h"
#import "SBJson.h"
#import "Header.h"
#import "LogIn_ViewController.h"

@interface XiuGai_ViewController ()

@end

@implementation XiuGai_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //按钮圆角
    self.QueRen_Button.layer.cornerRadius = 5.0;
    //textfield 代理
    _Oldpass_Field.delegate = self;
    _Newpass_Field.delegate = self;
    _Newpass_Field_2.delegate = self;
    //限制textField位数
    [self xianzhi];
}
#pragma mark - textfield方法
//光标下移
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.Oldpass_Field)
    {
        [self.Newpass_Field becomeFirstResponder];
    }
    else if (textField == self.Newpass_Field)
    {
        [self.Newpass_Field_2 becomeFirstResponder];
    }
    else
    {
        //结束编辑
        [self.view endEditing:YES];
        [self QueRen_Button];
    }
    return YES;
}
#pragma mark - 限制textField位数
-(void)xianzhi
{
    [self.Oldpass_Field addTarget:self action:@selector(oldPass) forControlEvents:UIControlEventEditingChanged];
    [self.Newpass_Field addTarget:self action:@selector(newPass1) forControlEvents:UIControlEventEditingChanged];
    [self.Newpass_Field_2 addTarget:self action:@selector(newPass2) forControlEvents:UIControlEventEditingChanged];
}
-(void)oldPass
{
    int MaxLen = 14;
    NSString* szText = [_Oldpass_Field text];
    if ([_Oldpass_Field.text length]> MaxLen)
    {
        _Oldpass_Field.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass1
{
    int MaxLen = 14;
    NSString* szText = [_Newpass_Field text];
    if ([_Newpass_Field.text length]> MaxLen)
    {
        _Newpass_Field.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass2
{
    int MaxLen = 14;
    NSString* szText = [_Newpass_Field_2 text];
    if ([_Newpass_Field_2.text length]> MaxLen)
    {
        _Newpass_Field_2.text = [szText substringToIndex:MaxLen];
    }
}
#pragma mark - 判断长度
-(BOOL)newpass1:(NSString *)new1
{
    if (self.Newpass_Field.text.length < 5) {
        return NO;
    }
    return YES;
}

-(BOOL)newpass_Deng:(NSString *)deng
{
    if (self.Newpass_Field_2.text != self.Newpass_Field.text) {
        return NO;
    }
     return YES;
}
#pragma mark - 确认按钮
- (IBAction)QueRen_Button:(id)sender {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (self.Oldpass_Field.text.length > 0 && self.Newpass_Field.text.length > 0 && self.Newpass_Field_2.text.length > 0)
    {
        if(self.Oldpass_Field.text != [NSString stringWithFormat:@"%@",[defaults objectForKey:@"pass"]])
        {
            [WarningBox warningBoxModeText:@"旧密码不正确" andView:self.view];
        }
        else if (![self newpass1:self.Newpass_Field.text])
        {
             [WarningBox warningBoxModeText:@"密码长度不够" andView:self.view];
        }
        else if (![self newpass_Deng:self.Newpass_Field_2.text])
        {
             [WarningBox warningBoxModeText:@"两次密码不一致，请重新输入" andView:self.view];
        }
        else
        {
            [WarningBox warningBoxModeIndeterminate:@"正在修改密码..." andView:self.view];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html",nil ];
            //接收数据类型
            manager.responseSerializer = [AFCompoundResponseSerializer serializer];
            
            //上传数据类型
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            //请求地址
            NSString *url = [NSString stringWithFormat:  @"%@resetpassword",wangzhi ];
            //入参
            
            NSDictionary *params = @{@"username":[NSString stringWithFormat:@"%@",[defaults objectForKey:@"name"]],@"oldpassword":[NSString stringWithFormat:@"%@",[defaults objectForKey:@"pass"]],@"newpassword":self.Newpass_Field_2.text };
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
                if ([[dic objectForKey:@"flag"] intValue]==1)
                {
                    
                    [WarningBox warningBoxModeText:@"修改成功" andView:self.view];
                    
                    LogIn_ViewController*login=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
                    
                    [self presentViewController:login animated:YES completion:^{
                        
                    }];

                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [WarningBox warningBoxHide:YES andView:self.view];
                [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@", error ] andView:self.view];
            }];

        }
    }
    else
    {
        [WarningBox warningBoxModeText:@"密码不能为空" andView:self.view];
    }
}
@end
