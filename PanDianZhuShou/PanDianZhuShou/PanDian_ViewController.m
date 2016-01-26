//
//  PanDian_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "PanDian_ViewController.h"
#import "WarningBox.h"
#import "TextFlowView.h"

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
    //储存查过的信息
    NSMutableArray*tiaoshu;
    int tiao;
//    6902083886417
//    6953150800508
//    6922507005033
//    6902083881559
}

@end
/**
 *  textfield 消失再出现的时候文本也会跟着消失;
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
    tiaoshu=[[NSMutableArray alloc] init];
    tiao=0;
   
}
-(void)viewWillAppear:(BOOL)animated{
    [_sousuo becomeFirstResponder];
    [self textfuzhi:nil];
    
    liebiao=nil;
    [_tableview reloadData];
    //一出来让tableview第一个textfield为  第一人称
    
    //[_sousuo becomeFirstResponder];
    //[(UITextField*)pop[0] becomeFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField!=_sousuo) {
        
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        po=(int)textField.tag-10000;
    }else{
        oo=0;
        _sousuo.text=@"";
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun_press.png"] forState:UIControlStateHighlighted];
        
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_sousuo) {
        [_sousuo resignFirstResponder];
        [self shuosou:_sousuo.text];
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)shuosou:(NSString*)search{
    
    if ([search isEqualToString:@""]) {
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

                    [liebiao addObject:arr[i]];
                    
                    [self textfuzhi:arr[i]];

                }
                
            }
            [_tableview reloadData];
        }
        //搜索 后plist  没有 符合  则p＝＝0
        //实现  先查上传列表  再查同步列表
        if (p==0) {
            
            for (int i=0; i<arr.count; i++) {
                if ([search isEqualToString:[arr[i] objectForKey:@"txm"]]) {
                    q++;
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
        
        [_sousuo resignFirstResponder];
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        
    }
}
-(void)textfuzhi:(NSDictionary*)dd{
   
    for (UIView*v in [self.vvvv subviews]) {
        if (v.tag==101) {
            [v removeFromSuperview];
        }
    }
    UILabel*xixi=[[UILabel alloc] init];
    UILabel*haha=[[UILabel alloc] init];
    if (dd==nil) {
        xixi.text=@"";
        _bianhao.text=@"";
        _huowei.text=@"";
        _wenhao.text=@"";
        haha.text=@"";
        _guige.text=@"";
        
    }else{
        xixi.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypmc"]];
        _bianhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypbh"]];
        _huowei.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"hwh"]];
        _wenhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"pzwh"]];
        haha.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"sccj"]];
        _guige.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"gg"]];
    }
    //使过长的字滚动
    TextFlowView* tete=[[TextFlowView alloc] initWithFrame:_yaoyao.frame Text:xixi.text textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] backgroundColor:[UIColor clearColor] alignLeft:YES];
     TextFlowView* te=[[TextFlowView alloc] initWithFrame:_changchang.frame Text:haha.text textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15] backgroundColor:[UIColor clearColor] alignLeft:YES];
    tete.tag=101;
    te.tag=101;
    [te addSubview:haha];
    [tete addSubview:xixi];
    [_vvvv addSubview:te];
    [_vvvv addSubview:tete];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *id1 =@"mycell2";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id1];
    }
    NSArray *row1=[cell.contentView subviews];
    for (UIView *vv2 in row1) {
        [vv2 removeFromSuperview];
    }
    
    UILabel*shuliang=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, 75, 20)];
    UITextField*tt;
    UILabel*pp;
    if (indexPath.row==0) {
        shuliang.text=@"药品数量:";
        tt=[[UITextField alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        tt.text=@"";
        tt.delegate=self;
        tt.tag=10000+indexPath.section;
        [pop addObject:tt];
        
        if (liebiao!=nil&&w!=0) {
            if ([liebiao[indexPath.section]objectForKey:@"shuliang"]==nil) {
                tt.text=@"";
            }else
                //如果实在上传列表中取出的数据  那么  tt需要赋值
                tt.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section]objectForKey:@"shuliang"]];
        }
        [cell addSubview:tt];
    }
    else{
        shuliang.text=@"批        号:";
        pp=[[UILabel alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        if (liebiao==nil||liebiao.count==0) {
            pp.text=@"";
        }else{
            pp.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section ] objectForKey:@"ph"]];
        }
        [cell addSubview:pp];
    }
    
    [cell addSubview:shuliang];
    
    
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

- (IBAction)fanfanhui:(id)sender {
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"退出提示" message:@"确定要结束本次盘点吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    

}

- (IBAction)ling:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"0"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"0"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
    
}

- (IBAction)yi:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"1"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"1"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)er:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"2"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"2"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)san:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"3"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"3"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)si:(id)sender {
    if (oo==1) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"4"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"4"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)wu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"5"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"5"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)liu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"6"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"6"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)qi:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"7"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"7"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)ba:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"8"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"8"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)jiu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"9"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"9"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
}

- (IBAction)qingkong:(id)sender {
    if (oo==0) {
        _sousuo.text=@"";
    }else{
        UITextField*xixi=pop[po];
        xixi.text=@"";
        
        [pop replaceObjectAtIndex:po withObject:xixi];
    }
    
}

- (IBAction)houtui:(id)sender {
    if (oo==0) {
        if ([_sousuo.text isEqual:@""]) {
            [WarningBox warningBoxModeText:@"已经没有了..." andView:self.view];
        }else
            _sousuo.text= [_sousuo.text substringToIndex:[_sousuo.text length] - 1];
    }else{
        UITextField*xixi=pop[po];
        
        if ([xixi.text isEqual:@""]) {
            [WarningBox warningBoxModeText:@"已经没有了..." andView:self.view];
        }else
            xixi.text= [xixi.text substringToIndex:[xixi.text length] - 1];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        
    }
}

- (IBAction)shangyitiao:(id)sender {
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path1]){
        [WarningBox warningBoxModeText:@"还没有添加数据哟..." andView:self.view];
    }else{
        tiao ++;
        
        NSArray*arp=[NSArray arrayWithContentsOfFile:path1];
        if ((int)arp.count - tiao <= 0) {
            [WarningBox warningBoxModeText:@"已经没有上一条了!" andView:self.view];
        }else{
            _sousuo.text=[NSString stringWithFormat:@"%@",[arp[arp.count - tiao] objectForKey:@"txm"] ];
            [self shuosou:[NSString stringWithFormat:@"%@",[arp[arp.count - tiao] objectForKey:@"txm"] ]];
        }
    }
    
    
}

- (IBAction)chaxun:(id)sender {
    if(oo==1){
        [self queding];
    }else{
        [self shuosou:_sousuo.text];
    }
}


-(void)queding{
    tiao=0;
    //判断是否数量有空值
    int h=0;
    NSLog(@"pop---%ld",pop.count);
    for (int i=0; i<liebiao.count; i++) {
        UITextField*xixi=pop[i];
        if ([xixi.text isEqual:@""]) {
            h=1;
        }
        
    }
    
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    //如果没有空值
    if (h==0) {
        //先把数量添加到liebiao中；
        for (int m=0; m<liebiao.count; m++) {
            UITextField*xixi=pop[m];
            [liebiao[m] setObject:xixi.text forKey:@"shuliang"];
        }
        NSLog(@"%@",liebiao);
        if (![fm fileExistsAtPath:path1]) {
            [liebiao writeToFile:path1 atomically:YES];
        }
        
        else{
            if (w!=0) {
                [liebiao writeToFile:path1 atomically:YES];
            }else{
                NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
                for (NSDictionary*d in liebiao) {
                    [arp addObject:d];
                }
                [arp writeToFile:path1 atomically:YES];
            }
        }
        [tiaoshu addObject:_sousuo.text];
        [WarningBox warningBoxModeText:@"数据添加成功!" andView:self.view];
        oo=3;
        [self viewWillAppear:YES];
    }
    else{
        [WarningBox warningBoxModeText:@"请填完整数量信息!" andView:self.view];
    }
    
}
@end
