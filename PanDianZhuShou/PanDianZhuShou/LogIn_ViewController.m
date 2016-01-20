//
//  LogIn_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "LogIn_ViewController.h"
#import "NavigationController.h"

@interface LogIn_ViewController ()

@end

@implementation LogIn_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置  textfield  placeholder  颜色
    [self text_placeholder];
    
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
    
   
    NavigationController*chaxun=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"navigationcontroller"];
    
    [self presentViewController:chaxun animated:YES completion:^{
        
//    [self setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        
    }];
    
    
    
}
@end
