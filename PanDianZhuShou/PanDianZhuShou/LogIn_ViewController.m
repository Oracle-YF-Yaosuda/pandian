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

@interface LogIn_ViewController ()
{
    NSUserDefaults*defaults;
}
@end

@implementation LogIn_ViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[NSUserDefaults standardUserDefaults];
    _Password_Text.delegate=self;
    _Username_Text.delegate=self;
    if ([defaults objectForKey:@"name"]==nil) {
        
    }else{
        _Username_Text.text=[NSString stringWithFormat:@"%@",[defaults objectForKey:@"name"]];
        _Password_Text.text=[NSString stringWithFormat:@"%@",[defaults objectForKey:@"pass"]];
    }
    //设置  textfield  placeholder  颜色
    [self text_placeholder];
}
//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}
//视图上移的方法
- (void) animateTextField: (UITextField *) textField up: (BOOL) up
{
      if (self.view.frame.size.height == 480 ) {
          //设置视图上移的距离，单位像素
          const int movementDistance = 215; // tweak as needed
          //三目运算，判定是否需要上移视图或者不变
          int movement = (up ? -movementDistance : movementDistance);
          //设置动画的名字
          [UIView beginAnimations: @"Animation" context: nil];
          //设置动画的开始移动位置
          [UIView setAnimationBeginsFromCurrentState: YES];
          //设置动画的间隔时间
          [UIView setAnimationDuration: 0.20];
          //设置视图移动的位移
          self.view.frame = CGRectOffset(self.view.frame, 0, movement);
          //设置动画结束
          [UIView commitAnimations];
    }
    else if (self.view.frame.size.height == 568)
    {
        //设置视图上移的距离，单位像素
        const int movementDistance = 130; // tweak as needed
        //三目运算，判定是否需要上移视图或者不变
        int movement = (up ? -movementDistance : movementDistance);
        //设置动画的名字
        [UIView beginAnimations: @"Animation" context: nil];
        //设置动画的开始移动位置
        [UIView setAnimationBeginsFromCurrentState: YES];
        //设置动画的间隔时间
        [UIView setAnimationDuration: 0.20];
        //设置视图移动的位移
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        //设置动画结束
        [UIView commitAnimations];

    }
    else if (self.view.frame.size.height == 667)
    {
        //设置视图上移的距离，单位像素
        const int movementDistance = 30; // tweak as needed
        //三目运算，判定是否需要上移视图或者不变
        int movement = (up ? -movementDistance : movementDistance);
        //设置动画的名字
        [UIView beginAnimations: @"Animation" context: nil];
        //设置动画的开始移动位置
        [UIView setAnimationBeginsFromCurrentState: YES];
        //设置动画的间隔时间
        [UIView setAnimationDuration: 0.20];
        //设置视图移动的位移
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        //设置动画结束
        [UIView commitAnimations];

    }
    else
    {
        //设置视图上移的距离，单位像素
        const int movementDistance = 10; // tweak as needed
        //三目运算，判定是否需要上移视图或者不变
        int movement = (up ? -movementDistance : movementDistance);
        //设置动画的名字
        [UIView beginAnimations: @"Animation" context: nil];
        //设置动画的开始移动位置
        [UIView setAnimationBeginsFromCurrentState: YES];
        //设置动画的间隔时间
        [UIView setAnimationDuration: 0.20];
        //设置视图移动的位移
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        //设置动画结束
        [UIView commitAnimations];

    }
   
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
    [self.view endEditing:YES];
    if([_Username_Text.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入用户名!" andView:self.view];
    }else if([_Password_Text.text isEqualToString:@""]){
        [WarningBox warningBoxModeText:@"请输入密码!" andView:self.view];
    }else{
        [WarningBox warningBoxModeIndeterminate:@"正在登录..." andView:self.view];
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
            if ([[dic objectForKey:@"flag"] intValue]==1) {
                [defaults setObject:_Password_Text.text forKey:@"pass"];
                [defaults setObject:_Username_Text.text forKey:@"name"];
                
                NavigationController*chaxun=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"navigationcontroller"];
                
                [self presentViewController:chaxun animated:YES completion:^{
                    
                }];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [WarningBox warningBoxHide:YES andView:self.view];
            NSLog(@"%@",error);
            
        }];
    }
}
@end
