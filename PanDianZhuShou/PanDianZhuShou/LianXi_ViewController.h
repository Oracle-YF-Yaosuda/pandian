//
//  LianXi_ViewController.h
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LianXi_ViewController : UIViewController
//微信
//view
@property (weak, nonatomic) IBOutlet UIView *WeiXin_View;
//按钮
@property (weak, nonatomic) IBOutlet UIButton *WeiXin_Button;
- (IBAction)WeiXin_Button:(id)sender;
//qq
//view
@property (weak, nonatomic) IBOutlet UIView *QQ_View;
//按钮
@property (weak, nonatomic) IBOutlet UIButton *QQ_Button;
- (IBAction)QQ_Button:(id)sender;
//电话
//view
@property (weak, nonatomic) IBOutlet UIView *DianHua_View;
//按钮
@property (weak, nonatomic) IBOutlet UIButton *DianHua_Button;
- (IBAction)DianHuan_Button:(id)sender;



@end
