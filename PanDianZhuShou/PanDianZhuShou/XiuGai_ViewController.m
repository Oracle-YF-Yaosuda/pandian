//
//  XiuGai_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "XiuGai_ViewController.h"
#import "WarningBox.h"

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
        return YES;
    }
    else if (textField == self.Newpass_Field)
    {
        [self.Newpass_Field_2 becomeFirstResponder];
        return YES;
    }
    else
    {
        [self.view endEditing:YES];
    }
    return YES;
}
//点击完成

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
    
    if (self.Oldpass_Field.text.length > 0 && self.Newpass_Field.text.length > 0 && self.Newpass_Field_2.text.length > 0)
    {
        if (![self newpass1:self.Newpass_Field.text])
        {
             [WarningBox warningBoxModeText:@"密码长度不够" andView:self.view];
        }
        else if (![self newpass_Deng:self.Newpass_Field_2.text])
        {
             [WarningBox warningBoxModeText:@"两次密码不一致，请重新输入" andView:self.view];
        }
        else
        {
            [WarningBox warningBoxModeText:@"修改成功" andView:self.view];
        }
    }
    else
    {
        [WarningBox warningBoxModeText:@"密码不能为空" andView:self.view];
    }
}
@end
