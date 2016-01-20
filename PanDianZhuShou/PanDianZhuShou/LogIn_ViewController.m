//
//  LogIn_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "LogIn_ViewController.h"

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
    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/plate",@"text/html", nil];
    SBJsonWriter*writer=[[SBJsonWriter alloc] init];
    NSDictionary*datadic=[NSDictionary dictionaryWithObjectsAndKeys:_Username_Text.text,@"username",_Password_Text.text,@"password", nil];
    NSString*jsonstring=[writer stringWithObject:datadic];
   
    NSString*url=@"http://222.171.242.146/stock/stockIntf/login";
    NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:jsonstring,@"params", nil];
 
   [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"%@",responseObject);
       if ([[responseObject objectForKey:@"flag"] intValue]==1) {
           NavigationController*chaxun=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"navigationcontroller"];
           
           [self presentViewController:chaxun animated:YES completion:^{
               
           }];
       }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"%@",error);
   }];
}
@end
