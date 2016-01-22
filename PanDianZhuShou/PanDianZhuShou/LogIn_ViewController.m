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
        NSLog(@"xixi");
    }else{
        _Username_Text.text=[NSString stringWithFormat:@"%@",[defaults objectForKey:@"name"]];
        _Password_Text.text=[NSString stringWithFormat:@"%@",[defaults objectForKey:@"pass"]];
    }
    //设置  textfield  placeholder  颜色
    [self text_placeholder];
    
    //1.创建一个 NSNotificationCenter 对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    //2.监听键盘弹出的通知
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)keyboardWillChangeFrame:(NSNotification*)noteInfo{
    
    //view 整体上移
    //1.获取键盘显示完毕或者隐藏完毕后的Y值
    CGRect rectEnd =  [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y ;
    
    //用键盘的Y值减去屏幕的高度计算出平移的值
    //1.如果键盘弹出事件，那么计算出的值就是负的键盘的高度
    //2.如果是键盘的隐藏事件，那么计算出的值就是零，因为键盘在隐藏以后，键盘的Y值就等于屏幕的高度
    CGFloat tranformValue = keyboardY - self.view.frame.size.height - 90 ;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        //让控制器的view执行一次平移
        self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue + 90);
        self.Username_Text.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.Password_Text.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.img1.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.img2.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.img3.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.img4.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.img5.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.img6.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        self.LogIn_Button.transform = CGAffineTransformMakeTranslation(0,  tranformValue + 90);
        
    }];

    
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
