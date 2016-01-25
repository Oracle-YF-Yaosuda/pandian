//
//  PanDian_ViewController.h
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanDian_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *sousuo;
@property (weak, nonatomic) IBOutlet UIButton *chading;
@property (weak, nonatomic) IBOutlet UIView *vvvv;
@property (weak, nonatomic) IBOutlet UIView *yaoyao;
@property (weak, nonatomic) IBOutlet UIView *changchang;
- (IBAction)fanfanhui:(id)sender;
- (IBAction)ling:(id)sender;
- (IBAction)yi:(id)sender;
- (IBAction)er:(id)sender;
- (IBAction)san:(id)sender;
- (IBAction)si:(id)sender;
- (IBAction)wu:(id)sender;
- (IBAction)liu:(id)sender;
- (IBAction)qi:(id)sender;
- (IBAction)ba:(id)sender;
- (IBAction)jiu:(id)sender;
- (IBAction)qingkong:(id)sender;
- (IBAction)houtui:(id)sender;
- (IBAction)shangyitiao:(id)sender;
- (IBAction)chaxun:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *huowei;
@property (weak, nonatomic) IBOutlet UILabel *wenhao;
@property (weak, nonatomic) IBOutlet UILabel *guige;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
