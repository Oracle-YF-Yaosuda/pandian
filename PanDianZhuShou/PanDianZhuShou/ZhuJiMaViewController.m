//
//  ZhuJiMaViewController.m
//  PanDianZhuShou
//
//  Created by csh on 16/7/6.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "ZhuJiMaViewController.h"
#import "PanDian_ViewController.h"
#import "WarningBox.h"
#import "CFDynamicLabel.h"
#import "Color+Hex.h"
#import "DSKyeboard.h"


@interface ZhuJiMaViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    
    NSMutableArray *array;
    
    NSMutableArray *kong;
    
    int flog;
    
    int first;
    
}

@end

@implementation ZhuJiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flog=2;
    first=0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardwillShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    

    _mytf.delegate=self;
    _mytf.layer.borderWidth=1.0f;
    _mytf.layer.cornerRadius=8.0f;
    _mytf.layer.borderColor=[[UIColor grayColor]CGColor];
    _mytf.clearButtonMode = UITextFieldViewModeNever;
   [_mytf becomeFirstResponder];
    
    self.myTabel=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-110)];
    self.myTabel.delegate=self;
    self.myTabel.dataSource=self;
    [self.view addSubview:self.myTabel];

    
    NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
    NSDictionary*dic=[NSDictionary dictionaryWithContentsOfFile:path];
    self.arr=[dic objectForKey:@"data"];
    NSString *p = [[NSString alloc] init];
    for (int i=0; i<self.arr.count; i++) {
        p=[self.arr[i] objectForKey:@"pzwh"];
    }
    flog=2;
    
    // Do any additional setup after loading the view.
}

#pragma mark - keyboard

-(void)keyboardwillShown:(NSNotification*)aNotification{
    
    UIWindow *hahahap=[[[UIApplication sharedApplication]windows] objectAtIndex:[[UIApplication sharedApplication]windows].count-1];
    
    if (first==1)
        
        [hahahap setAlpha:0];
    
    else
        
        [hahahap setAlpha:1];

}
-(void)keyboardWasShown:(NSNotification*)a
{
    
}

//自定义键盘
- (void)setupCustomedKeyboard:(UITextField*)tf {
    
    tf.inputView = [DSKyeboard keyboardWithTextField:tf];
    
    [(DSKyeboard *)tf.inputView dsKeyboardTextChangedOutputBlock:^(NSString *fakePassword) {
        
        tf.text = fakePassword;
        
        array=[[NSMutableArray alloc] initWithCapacity:0];
        
        NSString *str =[tf.text uppercaseString];
        
        for (int i = 0; i<self.arr.count; i++) {
            
            NSString *str1=[self.arr[i] objectForKey:@"pzwh"];
            
            NSString *str2=[str1 uppercaseString];

            //比较字符串 只从前面开始比较
            if (str2.length<str.length) {
                
            }else{
                    NSString *str3=[str2 substringToIndex:str.length];

                if ([str isEqualToString:@""]) {
                    
                }else{
                    if ([str isEqualToString:str3]) {
                        
                        [array addObject:self.arr[i]];
                    }                
                }
            }
        }
        if ([array count]==0) {
            flog=2;
        }else{
            flog=1;
        }
      
        
        [self.myTabel reloadData];
    } loginBlock:^(NSString *password) {
        [tf resignFirstResponder];
    }];
}
#pragma mark - tableview

// 数据源方法,特例,重要~ 一共有多少个分组 (默认就是返回1)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 单组数据显示,无需分组,故返回 1,(默认就是返回1)
    if (flog==2) {
        tableView.hidden=YES;
        return 0;
    }else{
        tableView.hidden=NO;
        return array.count;
    }
}
// 数据源方法,每一组,有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=4) {
        return 45;
    }else{
        return 46;
    }
}
// 数据源方法,每一组的每一行应该显示怎么的界面(含封装的数据),重点!!!
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.myTabel.separatorColor = [UIColor clearColor];
    static NSString *str=@"cell";
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    
    UIView *hehe;
    
    UIView *haha;
    
    CFDynamicLabel *ll1;
    
    UILabel *lll1;
    
    if(flog==1){
        
        if (indexPath.row==0) {
            
            lll1=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 35)];
            lll1.textColor=[UIColor grayColor];
            lll1.backgroundColor=[UIColor clearColor];
            lll1.text=@"药品名称：";
            
            ll1=[[CFDynamicLabel alloc] initWithFrame:CGRectMake(100, 15, CGRectGetWidth(self.view.frame)-100,44)];
            ll1.speed=0.5;
            ll1.backgroundColor=[UIColor clearColor];
            ll1.text= [array[indexPath.section] objectForKey:@"ypmc"];
            ll1.font=[UIFont boldSystemFontOfSize:25];
            
            haha=[[UIView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.view.frame), 1)];
            haha.backgroundColor=[UIColor colorWithHexString:@"E6E6E6"];
        }
    }
    
    [cell.contentView addSubview:ll1];
    [cell.contentView addSubview:lll1];
    [cell.contentView addSubview:haha];
    
    
    CFDynamicLabel *ll2;
    
    UILabel *lll2;
    
    if(flog==1){
        
        if (indexPath.row==1) {
            
            lll2=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 35)];
            lll2.textColor=[UIColor grayColor];
            lll2.backgroundColor=[UIColor clearColor];
            lll2.text=@"药品编号：";
            
            ll2=[[CFDynamicLabel alloc] initWithFrame:CGRectMake(100, 22, CGRectGetWidth(self.view.frame)-100,44)];
            ll2.speed=0.5;
            ll2.backgroundColor=[UIColor clearColor];
            ll2.text= [array[indexPath.section] objectForKey:@"ypbh"];
            
            haha=[[UIView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.view.frame), 1)];
            haha.backgroundColor=[UIColor colorWithHexString:@"E6E6E6"];
        }
    }
    
    [cell.contentView addSubview:ll2];
    [cell.contentView addSubview:lll2];
    [cell.contentView addSubview:haha];
    
    
    CFDynamicLabel *ll3;
    
    UILabel *lll3;
    
    if(flog==1){
        
        if (indexPath.row==2) {
            
            lll3=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 35)];
            lll3.textColor=[UIColor grayColor];
            lll3.backgroundColor=[UIColor clearColor];
            lll3.text=@"批      号：";
            
            ll3=[[CFDynamicLabel alloc] initWithFrame:CGRectMake(100, 22, CGRectGetWidth(self.view.frame)-100,44)];
            ll3.speed=0.5;
            ll3.backgroundColor=[UIColor clearColor];
            ll3.text= [array[indexPath.section] objectForKey:@"ph"];
            
            haha=[[UIView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.view.frame), 1)];
            haha.backgroundColor=[UIColor colorWithHexString:@"E6E6E6"];
        }
    }
    
    [cell.contentView addSubview:ll3];
    [cell.contentView addSubview:lll3];
    [cell.contentView addSubview:haha];
    
    
    CFDynamicLabel *ll4;
    
    UILabel *lll4;
    
    if(flog==1){
        
        if (indexPath.row==3) {
            
            lll4=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 35)];
            lll4.textColor=[UIColor grayColor];
            lll4.backgroundColor=[UIColor clearColor];
            lll4.text=@"生产厂家：";
            
            ll4=[[CFDynamicLabel alloc] initWithFrame:CGRectMake(100, 22, CGRectGetWidth(self.view.frame)-100,44)];
            ll4.speed=0.5;
            ll4.backgroundColor=[UIColor clearColor];
            ll4.text= [array[indexPath.section] objectForKey:@"sccj"];
            ll4.font=[UIFont boldSystemFontOfSize:17];
            
            haha=[[UIView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.view.frame), 1)];
            haha.backgroundColor=[UIColor colorWithHexString:@"E6E6E6"];
        }
    }
    
    [cell.contentView addSubview:ll4];
    [cell.contentView addSubview:lll4];
    [cell.contentView addSubview:haha];
    
    
    CFDynamicLabel *ll5;
    
    UILabel *lll5;
    
    if(flog==1){
        
        if (indexPath.row==4) {
            
            lll5=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 35)];
            lll5.textColor=[UIColor grayColor];
            lll5.backgroundColor=[UIColor clearColor];
            lll5.text=@"药品规格：";
            
            ll5=[[CFDynamicLabel alloc] initWithFrame:CGRectMake(100, 22, CGRectGetWidth(self.view.frame)-100,44)];
            ll5.speed=0.5;
            ll5.backgroundColor=[UIColor clearColor];
            ll5.text= [array[indexPath.section] objectForKey:@"gg"];
            
            hehe=[[UIView alloc] initWithFrame:CGRectMake(0, 45, CGRectGetWidth(self.view.frame), 2)];
            hehe.backgroundColor=[UIColor greenColor];
        }
    }
    
    [cell.contentView addSubview:ll5];
    [cell.contentView addSubview:lll5];
    [cell.contentView addSubview:hehe];

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

//tableview滚动--键盘消失
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
    _mytf.layer.borderColor = [[UIColor blackColor]CGColor];

}
//tableview传值
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing) {
        
        return;
    }
    if (tableView == self.myTabel) {
        
        NSString *txm=[array[(long)indexPath.section] objectForKey:@"txm"];

        if (self.passValueBlock!=nil) {
            
            self.passValueBlock(txm);
        }
      
        [self.navigationController popViewControllerAnimated:YES];

    }
}

-(void)passValue:(PassValueBlock)block{
    
    self.passValueBlock = block;
}


#pragma mark - textfield


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField==_mytf) {
        
        [self setupCustomedKeyboard:textField];
        textField.layer.borderWidth=1;
        textField.layer.borderColor = [[UIColor greenColor]CGColor];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_mytf) {
    
    textField.layer.borderColor= [[UIColor greenColor] CGColor];
    textField.layer.borderWidth=1.0f;
    textField.layer.cornerRadius=8.0f;
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    [(DSKyeboard *)textField.inputView clear];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)fanhui:(id)sender {
    
//    PanDian_ViewController *fanhui = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pandian"];
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
