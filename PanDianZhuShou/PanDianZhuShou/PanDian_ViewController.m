//
//  PanDian_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "PanDian_ViewController.h"
#import "WarningBox.h"
@interface PanDian_ViewController (){
    //下载下来的数据列表
    NSArray*arr;
    //需要在tableview中显示出来的数据
    NSMutableArray* liebiao;
    //是否为搜索框；
    int oo;
    //判段是否为上传文档数据；
    int w;
    //接受点击的是哪个section里的textfield；
    int po;
    //把tt全部装进pop里;
    NSMutableArray*pop;
}

@end
/**
 *  现在我的思路就是点击一个tableview里的textfiled，取得对应tableview的section值，使po＝section值，在点击键盘的时候 改变的就是pop[po].text=[pop[po].text stringByAppendingString:@"0"];
 */
@implementation PanDian_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sousuo.delegate=self;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
    NSDictionary*dic=[NSDictionary dictionaryWithContentsOfFile:path];
    arr=[dic objectForKey:@"data"];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //一出来让tableview第一个textfield为  第一人称
    
    //[_sousuo becomeFirstResponder];
    //[(UITextField*)pop[0] becomeFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField!=_sousuo) {
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
    }else{
        oo=0;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun_press.png"] forState:UIControlStateHighlighted];
        
    }

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_sousuo) {
        [self shuosou:_sousuo.text];
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)shuosou:(NSString*)search{
    
    if ([_sousuo.text isEqualToString:@""]) {
        [WarningBox warningBoxModeText:@"请输入条形码号!" andView:self.view];
    }else{
        pop=[[NSMutableArray alloc] init];
        liebiao=[[NSMutableArray alloc] init];
        NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
        NSFileManager*fm=[NSFileManager defaultManager];
        int p=0;int q=0; w=0;
        if ([fm fileExistsAtPath:path1]) {
            NSArray*aa=[NSArray arrayWithContentsOfFile:path1];
           
            for (int i=0; i<[aa count]; i++) {
              
                if ([search isEqualToString:[aa[i] objectForKey:@"txm"]]) {
                    w++;
                    p++;q++;
                    [self textfuzhi:aa[i]];
                    [liebiao addObject:aa[i]];
                    
                }
            }
            [_tableview reloadData];
        }
        else{
            
            for (int i=0; i<arr.count; i++) {
                if ([search isEqualToString:[arr[i] objectForKey:@"txm"]]) {
                    q++;p++;
                    //            if (![fm fileExistsAtPath:path1]) {
                    //                NSMutableArray*aa=[[NSMutableArray alloc] init];
                    //                [aa addObject:arr[i]];
                    //                [aa writeToFile:path1 atomically:YES];
                    [liebiao addObject:arr[i]];
                    
                    [self textfuzhi:arr[i]];
                    //            }
                    //
                    //            else{
                    //
                    //                NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
                    //                NSDictionary*d=[NSDictionary dictionaryWithDictionary:arr[i]];
                    //                [arp addObject:d];
                    //                [liebiao addObject:arr[i]];
                    //                [arp writeToFile:path1 atomically:YES];
                    //                [self textfuzhi:arr[i]];
                    //                NSLog(@"%@",liebiao);
                    //
                    //            }
                    
                }
                
            }
            [_tableview reloadData];
        }
        //搜索 后plist  没有 符合  则p＝＝0
        //实现  先查上传列表  再查同步列表
        if (p==0) {
            
            for (int i=0; i<arr.count; i++) {
                if ([search isEqualToString:[arr[i] objectForKey:@"txm"]]) {
                    [liebiao addObject:arr[i]];
                    [self textfuzhi:arr[i]];
                }
                
            }
            [_tableview reloadData];
        }
        //列表里边没有要找的数据  q＝＝0
        if (q==0) {
            [WarningBox warningBoxModeText:@"没有找到您要找的药品～" andView:self.view];
            [self textfuzhi:nil];
            [_tableview reloadData];
        }
        
    }
}
-(void)textfuzhi:(NSDictionary*)dd{
    if (dd==nil) {
        _yaoming.text=@"";
        _bianhao.text=@"";
        _huowei.text=@"";
        _wenhao.text=@"";
        _changjia.text=@"";
        _guige.text=@"";
        
    }else{
        _yaoming.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypmc"]];
        _bianhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypbh"]];
        _huowei.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"hwh"]];
        _wenhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"pzwh"]];
        _changjia.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"sccj"]];
        _guige.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"gg"]];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id1 =@"mycell2";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    }
    UILabel*shuliang=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 75, 20)];
    UITextField*tt;
    UILabel*pp;
    if (indexPath.row==0) {
        shuliang.text=@"药品数量:";
        tt=[[UITextField alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        tt.delegate=self;
       
        [pop addObject:tt];
        
        if (liebiao!=nil&&w!=0) {
            if ([liebiao[indexPath.section]objectForKey:@"shuliang"]==nil) {
                tt.text=@"";
            }else
            //如果实在上传列表中取出的数据  那么  tt需要赋值
            tt.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section]objectForKey:@"shuliang"]];
        }
    }
    else{
        shuliang.text=@"批        号:";
        pp=[[UILabel alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        if (liebiao==nil||liebiao.count==0) {
            pp.text=@"";
        }else{
            pp.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section ] objectForKey:@"ph"]];
        }
    }
    
    [cell addSubview:shuliang];
    [cell addSubview:tt];
    [cell addSubview:pp];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (liebiao==nil) {
        return 1;
    }else if(liebiao.count==0){
        return 1;
    }
    else
        return liebiao.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.section);
}
- (IBAction)ling:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"0"];
    }else{
       // (UITextField*)pop[po].text=[(UITextField*)pop[po].text stringByAppendingString:@"0"];
    }
    
}

- (IBAction)yi:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"1"];
    }else{
        
    }
}

- (IBAction)er:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"2"];
    }else{
        
    }
}

- (IBAction)san:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"3"];
    }else{
        
    }
}

- (IBAction)si:(id)sender {
    if (oo==1) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"4"];
    }else{
        
    }
}

- (IBAction)wu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"5"];
    }else{
        
    }
}

- (IBAction)liu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"6"];
    }else{
        
    }
}

- (IBAction)qi:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"7"];
    }else{
        
    }
}

- (IBAction)ba:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"8"];
    }else{
        
    }
}

- (IBAction)jiu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"9"];
    }else{
        
    }
}

- (IBAction)qingkong:(id)sender {
    if (oo==0) {
        _sousuo.text=@"";
    }else{
        
    }
    
}

- (IBAction)houtui:(id)sender {
    if (oo==0) {
    if ([_sousuo.text isEqual:@""]) {
        [WarningBox warningBoxModeText:@"已经没有了..." andView:self.view];
    }else
        _sousuo.text= [_sousuo.text substringToIndex:[_sousuo.text length] - 1];
    }else{
        
    }
}

- (IBAction)shangyitiao:(id)sender {
}

- (IBAction)chaxun:(id)sender {
    if(oo==1){
        [self queding];
    }else{
        [self shuosou:_sousuo.text];
    }
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (textField!=_sousuo) {
//        
//    }else{
//    //找到当前cell
//    UITableViewCell *cell=(UITableViewCell*)[[textField superview] superview ];
//    
//    // 找到当前 没值 ?
//    NSIndexPath *index=[self.tableview indexPathForCell:cell];
//    
//    if([string isEqualToString:@""]){
//        
//        
//    return YES;
//}

-(void)queding{
    
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path1]) {
       
        for (int i=0; i<liebiao.count; i++) {
           
        }
        
       
        [liebiao writeToFile:path1 atomically:YES];
        
    }
    
    else{
        if (w!=0) {
            for (int i=0; i<liebiao.count; i++) {
            
            }
            [liebiao writeToFile:path1 atomically:YES];
            
        }else{
        for (int i=0; i<liebiao.count; i++) {
            
        }
        NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
        for (NSDictionary*d in liebiao) {
            [arp addObject:d];
        }
        [arp writeToFile:path1 atomically:YES];
    }
    }
    [self viewDidLoad ];
}
@end
