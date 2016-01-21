//
//  XiuGai_ViewController.h
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiuGai_ViewController : UIViewController
//旧密码
@property (weak, nonatomic) IBOutlet UITextField *OldPass_Field;
//新密码
@property (weak, nonatomic) IBOutlet UITextField *NewPass_Field;
//确认新密码
@property (weak, nonatomic) IBOutlet UITextField *NewPass1_Field;
//确认
@property (weak, nonatomic) IBOutlet UIButton *QueRen_Button;
- (IBAction)QueRen_Button:(id)sender;


@end
