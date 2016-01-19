//
//  LogIn_ViewController.h
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogIn_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *Username_Text;

@property (weak, nonatomic) IBOutlet UITextField *Password_Text;

@property (weak, nonatomic) IBOutlet UIButton *LogIn_Button;

- (IBAction)LogIn_Button:(id)sender;

@end
