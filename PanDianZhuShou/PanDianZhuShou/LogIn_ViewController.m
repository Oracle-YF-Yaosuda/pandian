//
//  LogIn_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "LogIn_ViewController.h"

#import "NavigationController.h"
#import "Header.h"
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
    NSString*jiekou=@"login";
    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html", nil];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    SBJsonWriter*writer=[[SBJsonWriter alloc] init];
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:_Username_Text.text,@"username",_Password_Text.text,@"password", nil];
   
    NSString*jsonstring=[writer stringWithObject:datadic];
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:jsonstring  ,@"params", nil];
    NSLog(@"json---%@",jsonstring);
    NSLog(@"datadic-----%@",datadic);
    NSString*url=[NSString stringWithFormat: @"%@%@",wangzhi,jiekou];
  
    NSString *url2 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet] ];
    NSLog(@"%@",url2);
    [manager POST:url2 parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *haha = responseObject;
        NSString *hehe =  [[NSString alloc]initWithData:haha encoding:NSUTF8StringEncoding];
        NSLog(@"------------%@",hehe);
//  NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"出错了!");
    }];
}
@end
