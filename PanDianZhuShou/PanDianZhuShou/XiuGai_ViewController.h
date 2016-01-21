//
//  XiuGai_ViewController.h
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiuGai_ViewController : UIViewController<UITextFieldDelegate>
//旧密码
@property (weak, nonatomic) IBOutlet UITextField *Oldpass_Field;
//新密码
@property (weak, nonatomic) IBOutlet UITextField *Newpass_Field;
//确认新密码
@property (weak, nonatomic) IBOutlet UITextField *Newpass_Field_2;
//确认
@property (weak, nonatomic) IBOutlet UIButton *QueRen_Button;
- (IBAction)QueRen_Button:(id)sender;


@end
