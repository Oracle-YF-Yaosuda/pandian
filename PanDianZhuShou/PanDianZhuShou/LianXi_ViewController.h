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
@property (weak, nonatomic) IBOutlet UIView *WeinXin_View;
@property (weak, nonatomic) IBOutlet UIButton *WeiXin_Button;
- (IBAction)WeiXin_Button:(id)sender;
//QQ
@property (weak, nonatomic) IBOutlet UIView *QQ_View;
@property (weak, nonatomic) IBOutlet UIButton *QQ_Button;
- (IBAction)QQ_Button:(id)sender;
//电话
@property (weak, nonatomic) IBOutlet UIView *DianHuan_View;
@property (weak, nonatomic) IBOutlet UIButton *DianHua_Button;
- (IBAction)DianHuan_Button:(id)sender;
@end
