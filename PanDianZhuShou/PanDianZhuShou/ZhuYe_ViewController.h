//
//  ZhuYe_ViewController.h
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuYe_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *TiJian_Button;
- (IBAction)TiJiao_Button:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *KuCun_Button;
- (IBAction)KuCun_Button:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *ShuJu_Button;
- (IBAction)ShuJu_Button:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *PanDian_Button;
- (IBAction)PanDian_Button:(id)sender;


@end
