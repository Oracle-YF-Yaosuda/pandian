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
    UILabel*pp;
    UITextField*tt;
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
    //上一条数据记录
    int tiao;
    //存储滑动tableview 数字不丢失
    int zi;
    int ji;
}

@end
/**
 *  textfield 消失再出现的时候文本也会跟着消失;
 */
@implementation PanDian_ViewController

- (void)viewDidLoad {
    ji=0;
    [super viewDidLoad];
    _sousuo.delegate=self;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
    NSDictionary*dic=[NSDictionary dictionaryWithContentsOfFile:path];
    //下载文件读取;
    arr=[dic objectForKey:@"data"];
    tiaoshu=[[NSMutableArray alloc] init];
    tiao=0;
    zi=0;
    
   
}
-(void)viewWillAppear:(BOOL)animated{
    [_sousuo becomeFirstResponder];
    [self textfuzhi:nil];
    
    liebiao=nil;
    [_tableview reloadData];
   
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField!=_sousuo) {
        
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        //下边这句话憋了我一天半  十分重要；tableview里textfield取值
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
    ji=0;
    if ([search isEqualToString:@""]) {
        [WarningBox warningBoxModeText:@"请输入条形码号!" andView:self.view];
    }else{
        zi=1;
        pop=[[NSMutableArray alloc] init];
        liebiao=[[NSMutableArray alloc] init];
        NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
        NSFileManager*fm=[NSFileManager defaultManager];
        //三个int  是逻辑判断的主要依据
        int p=0;int q=0; w=0;
        //下边的 if从句是二选一的意思  千万不要大意 因为可能还可能会做二次判断
        //上传文件存在
        if ([fm fileExistsAtPath:path1]) {
            
            NSArray*aa=[NSArray arrayWithContentsOfFile:path1];
            
            for (int i=0; i<[aa count]; i++) {
                
                if ([search isEqualToString:[aa[i] objectForKey:@"txm"]]) {
                    //上传文件里有
                    w++;
                    p++;q++;
                    [self textfuzhi:aa[i]];
                    [liebiao addObject:aa[i]];
                    
                }
            }
            [_tableview reloadData];
        }
        else{
            //上传文件不存在
            for (int i=0; i<arr.count; i++) {
                if ([search isEqualToString:[arr[i] objectForKey:@"txm"]]) {
                    q++;p++;
                    //下载文件里有
                    [liebiao addObject:arr[i]];
                    
                    [self textfuzhi:arr[i]];
                    
                }
                
            }
            [_tableview reloadData];
        }
        //搜索 上传文件  没有 符合  则p＝＝0
        //＊＊＊＊＊＊＊实现  先查上传列表  再查下载文件＊＊＊＊＊
        if (p==0) {
            
            for (int i=0; i<arr.count; i++) {
                if ([search isEqualToString:[arr[i] objectForKey:@"txm"]]) {
                    q++;
                    //下载文件里有
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
//这个不用看 跟逻辑没啥关系
-(void)textfuzhi:(NSDictionary*)dd{
    
    for (UIView*v in [self.vvvv subviews]) {
        if (v.tag==101) {
            [v removeFromSuperview];
        }
    }
    UILabel*xixi=[[UILabel alloc] init];
    UILabel*haha=[[UILabel alloc] init];
    if (dd==nil) {
        tt.text=@"";
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
    
    
    if (indexPath.row==0) {
        shuliang.text=@"药品数量:";
        tt=[[UITextField alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        tt.delegate=self;
        tt.tag=10000+indexPath.section;
        
        
        if (liebiao!=nil&&w!=0) {
            //有上传文件
            if ([liebiao[indexPath.section]objectForKey:@"shuliang"]==nil) {
                //但是  数据是在下载文件拿到的;
                tt.text=@"";
                [pop addObject:tt];
                //这个小的if从句  就是决解滑动tableview  数字消失的 方法
                if (zi==1) {
                    tt =pop[indexPath.section];
                }
            }else{
                //如果是在上传列表中取出的数据  那么  tt需要赋值
                tt.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section]objectForKey:@"shuliang"]];
                [pop addObject:tt];
                if (zi==1) {
                    tt =pop[indexPath.section];
                }
            }
        }else{
            //没有上传文件
            //直接下载列表
            tt.text=@"";
            [pop addObject:tt];
            if (zi==1) {
                tt =pop[indexPath.section];
            }
            
        }
        //查询之后，tableview中的第一个textfield成为第一响应者；
        NSLog(@"%ld-------%ld",pop.count , liebiao.count);
        if (pop.count==liebiao.count) {
            [pop[0] becomeFirstResponder];
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
    if (oo==0) {
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
    NSLog(@"%ld",pop.count);
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
        ji=1;
        tiao ++;
        NSArray*arp=[NSArray arrayWithContentsOfFile:path1];
        if ((int)arp.count - tiao < 0) {
            [WarningBox warningBoxModeText:@"已经没有上一条了!" andView:self.view];
            
        }else{
            w=1;
            _sousuo.text=[NSString stringWithFormat:@"%@",[arp[arp.count - tiao] objectForKey:@"txm"] ];
            [self textfuzhi:arp[arp.count - tiao]];
            liebiao=nil;
            pop=nil;
            NSArray*xixi=[[NSArray alloc] initWithObjects:arp[arp.count - tiao], nil];
            pop=[NSMutableArray array];
            liebiao=[NSMutableArray arrayWithArray:xixi];
            [_sousuo resignFirstResponder];
            [_tableview reloadData];
        }
    }
    
}

- (IBAction)chaxun:(id)sender {
    if(oo==1){
        [self queding];
    }else{
        tiao=0;
        [self shuosou:_sousuo.text];
    }
}


-(void)queding{
   
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    if (ji==1) {
        UITextField*xixi=pop[0];
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeSp = [NSString stringWithFormat:@"%.0f",a];
        [liebiao[0] setObject:timeSp forKey:@"date"];
        [liebiao[0] setObject:xixi.text forKey:@"shuliang"];
        NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
        int op=0;
        for (int kl=0; kl<arp.count-op; kl++) {
            if ([_sousuo.text isEqual:[NSString stringWithFormat:@
                                       "%@",[arp[kl] objectForKey:@"txm"]]]) {
                if([pp.text isEqual:[NSString stringWithFormat:@"%@",[arp[kl] objectForKey:@"ph" ]]]){
                    
                    [arp removeObjectAtIndex:kl-op];
                    op++;
                    NSLog(@"/*/*/*/*%ld",arp.count);
                }
                
            }
        }
        //添加新数据
        
        [arp addObject:liebiao[0]];
        
        //写入
        [arp writeToFile:path1 atomically:YES];
        [WarningBox warningBoxModeText:@"数据更改成功!" andView:self.view];
        oo=3;
        [self viewWillAppear:YES];
    }else{
        tiao=0;
        zi=0;
        //判断是否数量有空值
        int h=0;
        //有点小问题。。。。。
        
        if (pop.count<liebiao.count) {
            [WarningBox warningBoxModeText:@"请仔细检查数量问题!" andView:self.view];
        }else{
            for (int i=0; i<liebiao.count; i++) {
                UITextField*xixi=pop[i];
                if ([xixi.text isEqual:@""]) {
                    h=1;
                }
                
            }
            
            
            //如果没有空值
            if (h==0) {
                //先把数量添加到liebiao中；
                for (int m=0; m<liebiao.count; m++) {
                    UITextField*xixi=pop[m];
                    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                    NSTimeInterval a=[dat timeIntervalSince1970];
                    NSString *timeSp = [NSString stringWithFormat:@"%.0f",a];
                    [liebiao[m] setObject:timeSp forKey:@"date"];
                    [liebiao[m] setObject:xixi.text forKey:@"shuliang"];
                    
                }
                NSLog(@"%@",liebiao);
                if (![fm fileExistsAtPath:path1]) {
                    [liebiao writeToFile:path1 atomically:YES];
                }
                
                else{
                    if (w!=0) {
                        //这里有一点点 漏洞     应该好使了
                        NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
                        //删除文件中原有数据
                        int op=0;
                        for (int kl=0; kl<arp.count+op; kl++) {
                            if ([_sousuo.text isEqual:[NSString stringWithFormat:@
                                                       "%@",[arp[kl-op] objectForKey:@"txm"]]]) {
                                [arp removeObjectAtIndex:kl-op];
                                op++;
                                NSLog(@"/*/*/*/*%ld",arp.count);
                            }
                        }
                        //添加新数据
                        for (NSDictionary*d in liebiao) {
                            [arp addObject:d];
                        }
                        //写入
                        [arp writeToFile:path1 atomically:YES];
                        
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
    }
}
@end
