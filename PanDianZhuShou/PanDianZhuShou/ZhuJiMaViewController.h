//
//  ZhuJiMaViewController.h
//  PanDianZhuShou
//
//  Created by csh on 16/7/6.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^PassValueBlock)(NSString *str);

@interface ZhuJiMaViewController : UIViewController

- (IBAction)fanhui:(id)sender;

@property (nonatomic, copy) void (^backValue)(NSString *strValue);
@property (nonatomic, retain)NSString *str;


@property (weak, nonatomic) IBOutlet UITextField *mytf;
@property (strong,nonatomic)UITableView *myTabel;
@property (strong,nonatomic) NSMutableArray *arr;

//传值
@property (nonatomic,copy) PassValueBlock passValueBlock;
-(void)passValue:(PassValueBlock)block;


@end
