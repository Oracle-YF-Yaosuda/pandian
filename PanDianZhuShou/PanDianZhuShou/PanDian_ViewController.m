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
#import "Color+Hex.h"
#import "DSKyeboard.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface PanDian_ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    //已经不知道是 判断啥的了
    int paue;
    //判断是那刷新的
    int qwer;
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
    //响应者
    int woshixiangying;
    //存储滑动tableview 数字不丢失
    int zi;
    int ji;
    //是否可以添加
    int tiji;
    ///添加批号
    //新建界面
    UIView * dabeijing;
    UIView * jiemian;
    //界面中的数据
    UILabel *ming1;//名称
    UITextField *pi1;//批号
    UITextField *shu1;//数量
    UILabel *wei1;//货位
    UILabel *bian1;//编号
    UILabel *ge1;//规格
    ///添加条码
    //新建界面
    UIView*jiemian1;
    //界面中的数据
    UILabel * tiaoma1;//条码
    UITextField *liang1;//数量
    UITextField *hao1;//批号
    UITextField *hwei1;//货位
    UITextField *biaohaoaa1;//编号
}
@property (weak, nonatomic) IBOutlet UITextField *hhhwww;
@property (weak, nonatomic) IBOutlet UIButton *xiugaianniu;
@property (nonatomic, retain) CBCentralManager *centralManager;
@end
/**
 *  textfield 消失再出现的时候文本也会跟着消失;
 */
@implementation PanDian_ViewController
- (IBAction)tianjia:(id)sender {
    [self tiji];
}
-(void)tiji{
    [self.view endEditing:YES];
    if (tiji==0) {
        [ WarningBox warningBoxModeText:@"请先查找药品" andView:self.view];
        
        
    }else{
        shu1.text=@"";
        pi1.text=@"";
        dabeijing.hidden=NO;
        jiemian.hidden=NO;
    }
}

- (void)viewDidLoad {
     self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    
    self.centralManager.delegate=self;
    
    
    
    
    woshixiangying=0;
    NSLog(@"%@",NSHomeDirectory());
    ji=0;
    [super viewDidLoad];
    tiji=0;
    paue=0;
    _hhhwww.layer.borderWidth=1;
    _hhhwww.layer.borderColor=[[UIColor grayColor] CGColor];
    _sousuo.hidden=YES;
    _sousuo.delegate=self;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [_xiugaianniu.layer setCornerRadius:5];
    NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
    NSDictionary*dic=[NSDictionary dictionaryWithContentsOfFile:path];
    //下载文件读取;
    arr=[dic objectForKey:@"data"];
    tiaoshu=[[NSMutableArray alloc] init];
    [_sousuo.layer setCornerRadius:5];
    tiao=0;
    zi=0;
    _hhhwww.delegate=self;
    [_hhhwww.layer setCornerRadius:5];
    [self tianjiapihao];
    [self tianjiatiaoma];
    
    
    
}
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString * state = nil;
    
    switch ([central state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"平台/硬件不支持蓝牙低能量。";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"这个应用程序未被授权使用蓝牙低能量。";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"目前蓝牙驱动。";
            break;
        case CBCentralManagerStatePoweredOn:{
            state = @"工作";
            
            [self scan];
            
        }
            break;
        case CBCentralManagerStateUnknown:
        default:
            ;
    }
    
    NSLog(@"Central manager state: %@", state);
}

-(void)scan{
    
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}



- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"name:%@",peripheral);
    
    if (!peripheral || !peripheral.name || ([peripheral.name isEqualToString:@""])) {
        return;
    }
    
    if (peripheral.state == CBPeripheralStateConnected) {
       
        NSLog(@"is connected");
        
//        [_sousuo becomeFirstResponder];
    }
    
    
}

-(void)tianjiapihao{
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height= [[UIScreen mainScreen] bounds].size.height;
    //新加添加view
    dabeijing=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    dabeijing.backgroundColor=[UIColor blackColor];
    dabeijing.alpha=0.7;
    [self.view addSubview:dabeijing];
    dabeijing.hidden=YES;
    //信息展示
    jiemian=[[UIView alloc] initWithFrame:CGRectMake(5, 150, width-10, 350)];
    [jiemian.layer setCornerRadius:5];
    jiemian.backgroundColor=[UIColor whiteColor];
    jiemian.alpha=1;
    [self.view addSubview:jiemian];
    jiemian.hidden=YES;
    UILabel*xinxi=[[UILabel alloc] initWithFrame:CGRectMake(5, 2,200, 40)];
    xinxi.font=[UIFont systemFontOfSize:20 weight:1.5];
    UIView * xianhe=[[UIView alloc] initWithFrame:CGRectMake(0, 40, jiemian.bounds.size.width, 1)];
    xianhe.backgroundColor=[UIColor  blackColor];
    UILabel *ming=[[UILabel alloc] initWithFrame:CGRectMake(10, 43, 100, 40)];
    UILabel *pi=[[UILabel alloc] initWithFrame:CGRectMake(10, 84, 100, 40)];
    UILabel *shu=[[UILabel alloc] initWithFrame:CGRectMake(10, 125, 100, 40)];
    UILabel *wei=[[UILabel alloc] initWithFrame:CGRectMake(10, 166, 100, 40)];
    UILabel *bian=[[UILabel alloc] initWithFrame:CGRectMake(10, 207, 100, 40)];
    UILabel *ge=[[UILabel alloc] initWithFrame:CGRectMake(10, 248, 100, 40)];
    xinxi.text=@"请添加药品信息";
    ming.text =@"药品名称:";
    pi.text   =@"药品批号:";
    shu.text  =@"药品数量:";
    wei.text  =@"货        位:";
    bian.text =@"药品编号:";
    ge.text   =@"药品规格:";
    UIView *baoqu=[[UIView alloc] initWithFrame:CGRectMake(20, 300, jiemian.bounds.size.width-40, 40)];
    UIButton *baocun=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width/3, 30)];
    UIButton *quxiao=[[UIButton alloc] initWithFrame:CGRectMake(baoqu.bounds.size.width-width/3, 0, width/3, 30)];
    baocun.tintColor=[UIColor blackColor];
    baocun.backgroundColor=[UIColor colorWithHexString:@"34c083"];
    quxiao.backgroundColor=[UIColor colorWithHexString:@"34c083"];
    [baocun addTarget:self action:@selector(baobao) forControlEvents:UIControlEventTouchUpInside];
    [quxiao addTarget:self action:@selector(ququ) forControlEvents:UIControlEventTouchUpInside];
    [baocun setTitle:@"保存" forState:UIControlStateNormal];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [baocun.layer setCornerRadius:5];
    [quxiao.layer setCornerRadius:5];
    [jiemian addSubview:xinxi];
    [jiemian addSubview:xianhe];
    [jiemian addSubview:ming];
    [jiemian addSubview:pi];
    [jiemian addSubview:shu];
    [jiemian addSubview:wei];
    [jiemian addSubview:bian];
    [jiemian addSubview:ge];
    [baoqu addSubview:baocun];
    [baoqu addSubview:quxiao];
    [jiemian addSubview:baoqu];
    
    ming1=[[UILabel alloc] initWithFrame:CGRectMake(110, 43, jiemian.bounds.size.width-110-20, 40)];
    pi1=[[UITextField alloc] initWithFrame:CGRectMake(110, 94, jiemian.bounds.size.width-110-20, 30)];
    pi1.delegate=self;
    [pi1.layer setBorderWidth:1];
    [pi1.layer setCornerRadius:5];
    shu1=[[UITextField alloc] initWithFrame:CGRectMake(110, 135, jiemian.bounds.size.width-110-20, 30)];
    [ZYCustomKeyboardTypeNumberView customKeyboardViewWithServiceTextField:shu1 Delegate:self];
    shu1.delegate=self;
    [shu1.layer setBorderWidth:1];
    [shu1.layer setCornerRadius:5];
    wei1=[[UILabel alloc] initWithFrame:CGRectMake(110, 166, 100, 40)];
    bian1=[[UILabel alloc] initWithFrame:CGRectMake(110, 207, 100, 40)];
    ge1=[[UILabel alloc] initWithFrame:CGRectMake(110, 248, 100, 40)];
    shu1.keyboardType=UIKeyboardTypeNumberPad;
    [jiemian addSubview:ming1];
    [jiemian addSubview:pi1];
    [jiemian addSubview:shu1];
    [jiemian addSubview:bian1];
    [jiemian addSubview:ge1];
    [jiemian addSubview:wei1];
}
-(void)tianjiatiaoma{
    float width = [[UIScreen mainScreen] bounds].size.width;
    //float height= [[UIScreen mainScreen] bounds].size.height;
    
    //信息展示
    jiemian1=[[UIView alloc] initWithFrame:CGRectMake(5, 150, width-10, 350)];
    jiemian1.backgroundColor=[UIColor whiteColor];
    jiemian1.alpha=1;
    [jiemian1.layer setCornerRadius:10];
    [self.view addSubview:jiemian1];
    jiemian1.hidden=YES;
    UILabel*xinxi=[[UILabel alloc] initWithFrame:CGRectMake(5, 2,200, 40)];
    xinxi.font=[UIFont systemFontOfSize:20 weight:1.5];
    UIView * xianhe=[[UIView alloc] initWithFrame:CGRectMake(0, 40, jiemian1.bounds.size.width, 1)];
    xianhe.backgroundColor=[UIColor  blackColor];
    UILabel *ming=[[UILabel alloc] initWithFrame:CGRectMake(10, 43, 100, 40)];
    UILabel *pi=[[UILabel alloc] initWithFrame:CGRectMake(10, 84, 100, 40)];
    UILabel *shu=[[UILabel alloc] initWithFrame:CGRectMake(10, 125, 100, 40)];
    UILabel *wei=[[UILabel alloc] initWithFrame:CGRectMake(10, 166, 100, 40)];
    UILabel *bian=[[UILabel alloc] initWithFrame:CGRectMake(10, 207, 100, 40)];
    
    xinxi.text=@"请添加药品信息";
    ming.text =@"条  形  码:";
    pi.text   =@"药品批号:";
    shu.text  =@"药品数量:";
    wei.text  =@"货        位:";
    bian.text =@"药品编号:";
    
    UIView *baoqu=[[UIView alloc] initWithFrame:CGRectMake(20, 300, jiemian1.bounds.size.width-40, 40)];
    UIButton *baocun=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width/3, 30)];
    UIButton *quxiao=[[UIButton alloc] initWithFrame:CGRectMake(baoqu.bounds.size.width-width/3, 0, width/3, 30)];
    baocun.tintColor=[UIColor blackColor];
    baocun.backgroundColor=[UIColor colorWithHexString:@"34c083"];
    quxiao.backgroundColor=[UIColor colorWithHexString:@"34c083"];
    [baocun addTarget:self action:@selector(cuncun) forControlEvents:UIControlEventTouchUpInside];
    [quxiao addTarget:self action:@selector(xiaoxiao) forControlEvents:UIControlEventTouchUpInside];
    [baocun setTitle:@"保存" forState:UIControlStateNormal];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [baocun.layer setCornerRadius:5];
    [quxiao.layer setCornerRadius:5];
    [jiemian1 addSubview:xinxi];
    [jiemian1 addSubview:xianhe];
    [jiemian1 addSubview:ming];
    [jiemian1 addSubview:pi];
    [jiemian1 addSubview:shu];
    [jiemian1 addSubview:wei];
    [jiemian1 addSubview:bian];
    
    [baoqu addSubview:baocun];
    [baoqu addSubview:quxiao];
    [jiemian1 addSubview:baoqu];
    
    tiaoma1=[[UILabel alloc] initWithFrame:CGRectMake(110, 43, jiemian1.bounds.size.width-110-20, 40)];
    hao1=[[UITextField alloc] initWithFrame:CGRectMake(110, 94, jiemian1.bounds.size.width-110-20, 30)];
    hao1.delegate=self;
    [hao1.layer setBorderWidth:1];
    [hao1.layer setCornerRadius:5];
    liang1=[[UITextField alloc] initWithFrame:CGRectMake(110, 135, jiemian1.bounds.size.width-110-20, 30)];
    [ZYCustomKeyboardTypeNumberView customKeyboardViewWithServiceTextField:liang1 Delegate:self];
    liang1.delegate=self;
    [liang1.layer setBorderWidth:1];
    [liang1.layer setCornerRadius:5];
    hwei1=[[UITextField alloc] initWithFrame:CGRectMake(110, 176, jiemian1.bounds.size.width-110-20, 30)];
    hwei1.delegate=self;
    [hwei1.layer setBorderWidth:1];
    [hwei1.layer setCornerRadius:5];
    biaohaoaa1=[[UITextField alloc] initWithFrame:CGRectMake(110, 217, jiemian1.bounds.size.width-110-20, 30)];
    biaohaoaa1.delegate=self;
    [biaohaoaa1.layer setBorderWidth:1];
    [biaohaoaa1.layer setCornerRadius:5];
    liang1.keyboardType=UIKeyboardTypeNumberPad;
    [jiemian1 addSubview:tiaoma1];
    [jiemian1 addSubview:hao1];
    [jiemian1 addSubview:liang1];
    [jiemian1 addSubview:biaohaoaa1];
    [jiemian1 addSubview:hwei1];
}
-(void)cuncun{
    [jiemian1 endEditing:YES];
    if ([tiaoma1.text isEqual:@""]||[liang1.text isEqual:@""]||[hao1.text isEqual:@""]||[hwei1.text isEqual:@""]||[biaohaoaa1.text isEqual:@""]) {
        [WarningBox warningBoxModeText:@"请填写完整信息!" andView:jiemian1];
    }else{
        NSMutableDictionary*dda=[[NSMutableDictionary alloc] init];
        [dda setValue:tiaoma1.text forKey:@"txm"];
        [dda setValue:liang1.text forKey:@"shuliang"];
        [dda setValue:hao1.text forKey:@"ph"];
        [dda setValue:hwei1.text forKey:@"hwh"];
        [dda setValue:biaohaoaa1.text forKey:@"ypbh"];
        [dda setValue:@"1" forKey:@"new_added"];
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeSp = [NSString stringWithFormat:@"%.0f",a];
        [dda setObject:timeSp forKey:@"imp_detail_id"];
        [dda setValue:@"1" forKey:@"hwh_flag"];
        [dda setValue:@"0" forKey:@"license_flag"];
        [liebiao addObject:dda];
        [self.view endEditing:YES];
        dabeijing.hidden=YES;
        jiemian1.hidden=YES;
        woshixiangying=1;
        _tableview.contentOffset=CGPointMake(0, 0);
        qwer=0;
        [_tableview reloadData];
        [self textfuzhi:liebiao[0]];
    }
}
-(void)xiaoxiao{
    _sousuo.text=@"";
    [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun.png"] forState:UIControlStateNormal];
    [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun_press.png"] forState:UIControlStateHighlighted];
    dabeijing.hidden=YES;
    jiemian1.hidden=YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [jiemian endEditing:YES];
}
-(void)baobao{
    if ([shu1.text isEqual:@""]||[pi1.text isEqual:@""]) {
        [WarningBox warningBoxModeText:@"请填写完整信息!" andView:jiemian];
    }else{
        int piupiu=0;
        for (int heheda=0; heheda<liebiao.count; heheda++) {
            if ([pi1.text isEqual:[liebiao[heheda] objectForKey:@"ph"]]) {
                piupiu=1;
            }
        }
        if (piupiu==0) {
            NSMutableDictionary * ca=[NSMutableDictionary dictionaryWithDictionary:liebiao[0]];
            NSDate* dat1 = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a1=[dat1 timeIntervalSince1970];
            NSString *timeSp1 = [NSString stringWithFormat:@"%.0f",a1];
            [ca setObject:pi1.text forKey:@"ph"];
            [ca setObject:shu1.text forKey:@"shuliang"];
            [ca setObject:@"1" forKey:@"license_flag"];
            [ca setObject:@"0" forKey:@"hwh_flag"];
            [ca setObject:timeSp1 forKey:@"imp_detail_id"];
            [liebiao addObject: ca];
            [self.view endEditing:YES];
            dabeijing.hidden=YES;
            jiemian.hidden=YES;
            paue=1;
            _tableview.contentOffset=CGPointMake(0, 0);
            qwer=1;
            [_tableview reloadData];
            
        }else{
            [WarningBox warningBoxModeText:@"不能添加已有批号!" andView:jiemian];
        }
    }
}
-(void)ququ{
    [self.view endEditing:YES];
    dabeijing.hidden=YES;
    jiemian.hidden=YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [_sousuo becomeFirstResponder];
    [self textfuzhi:nil];
    
    liebiao=nil;
    qwer=1;
    [_tableview reloadData];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)shuosou:(NSString*)search{
    ji=0;qwer=0;paue=0;
    if ([search isEqualToString:@""]) {
        tiji=0;
        [WarningBox warningBoxModeText:@"请输入条形码号!" andView:self.view];
    }else{
        tiaoma1.text=search;
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
            NSMutableArray*pkq=[NSMutableArray array];
            int wawawapi=0;
            for (int i=0; i<[aa count]; i++) {
                
                if ([[aa[i] objectForKey:@"txm"]isEqual:search]){
                    //上传文件里有
                    w++;
                    p++;q++;
                    [self textfuzhi:aa[i]];
                    [liebiao addObject:aa[i]];
                    tiji=1;
                    
                }
                else{
                    if ([(NSString*)[aa[i] objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                        [pkq addObject:aa[i]];
                        wawawapi=1;
                    }
                }
            }
            if(p==0){
                for (NSDictionary*xixi in pkq) {
                    NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                    for (NSString*nono in uty) {
                        if ([nono isEqualToString:search]) {
                            w++;
                            p++;q++;
                            tiji=1;
                            [self textfuzhi:xixi];
                            [liebiao addObject:xixi];
                        }
                    }
                }
            }
            
            
            NSLog(@"%@",liebiao);
            
            _tableview.contentOffset=CGPointMake(0, 0);
            [_tableview reloadData];
        }
        else{
            NSMutableArray*pkq=[NSMutableArray array];
            int wawawapi=0;
            //上传文件不存在
            for (int i=0; i<arr.count; i++) {
                if ([[arr[i] objectForKey:@"txm"] isEqual:search]) {
                    q++;p++;
                    //下载文件里有
                    tiji=1;
                    [arr[i] setObject:@"0" forKey:@"license_flag"];
                    [liebiao addObject:arr[i]];
                    [self textfuzhi:arr[i]];
                    
                }else{
                    if ([(NSString*)[arr[i] objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                        [pkq addObject:arr[i]];
                        wawawapi=1;
                    }
                }
            }
            if(p==0){
                for (NSDictionary*xixi in pkq) {
                    NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                    for (NSString*nono in uty) {
                        if ([nono isEqualToString:search]) {
                            q++;p++;
                            //下载文件里有
                            tiji=1;
                            [xixi setValue:@"0" forKey:@"license_flag"];
                            [liebiao addObject:xixi];
                            [self textfuzhi:xixi];
                        }
                    }
                }
            }

            _tableview.contentOffset=CGPointMake(0, 0);
            
            [_tableview reloadData];
        }
        //搜索 上传文件  没有 符合  则p＝＝0
        //＊＊＊＊＊＊＊实现  先查上传列表  再查下载文件＊＊＊＊＊
        if (p==0) {
            NSMutableArray*pkq=[NSMutableArray array];
            int wawawapi=0;
            for (int i=0; i<arr.count; i++) {
                if ([[arr[i] objectForKey:@"txm"] isEqual:search]) {
                    q++;
                    //下载文件里有
                    tiji=1;
                    [arr[i] setObject:@"0" forKey:@"license_flag"];
                    [liebiao addObject:arr[i]];
                    [self textfuzhi:arr[i]];
                }
                else{
                    if ([(NSString*)[arr[i] objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                        [pkq addObject:arr[i]];
                        wawawapi=1;
                    }
                }
            }
            if(q==0){
                for (NSDictionary*xixi in pkq) {
                    NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                    for (NSString*nono in uty) {
                        if ([nono isEqualToString:search]) {
                            q++;p++;
                            //下载文件里有
                            tiji=1;
                            [xixi setValue:@"0" forKey:@"license_flag"];
                            [liebiao addObject:xixi];
                            [self textfuzhi:xixi];
                        }
                    }
                }
            }

            
            
            _tableview.contentOffset=CGPointMake(0, 0);
            
            [_tableview reloadData];
        }
        [_sousuo resignFirstResponder];
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        //列表里边没有要找的数据  q＝＝0
        if (q==0) {
#pragma sss ok
            tiji=0;
            //添加aleter
            UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示:" message:@"没有查询到能匹配次条码的药品,需要新增吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                _sousuo.text=@"";[_sousuo becomeFirstResponder];
                tiji=0;
                [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun.png"] forState:UIControlStateNormal];
                [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun_press.png"] forState:UIControlStateHighlighted];
                
                
            }];
            UIAlertAction*action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                liang1.text=@"";
                hao1.text=@"";
                hwei1.text=@"";
                biaohaoaa1.text=@"";
                
                dabeijing.hidden=NO;
                jiemian1.hidden=NO;
                
            }];
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            
            [self textfuzhi:nil];
            _tableview.contentOffset=CGPointMake(0, 0);
            oo=0;qwer=1;
            [_tableview reloadData];
        }
        
        
        
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
        _hhhwww.text=@"";
        _wenhao.text=@"";
        haha.text=@"";
        _guige.text=@"";
        
    }else{
        if ([dd objectForKey:@"ypmc"]==nil||[[dd objectForKey:@"ypmc"] isEqual:@""]) {
            xixi.text=@"";
        }else
            xixi.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypmc"]];
        if ([dd objectForKey:@"ypbh"]==nil||[[dd objectForKey:@"ypbh"] isEqual:@""]) {
            _bianhao.text=@"";
        }else
            _bianhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypbh"]];
        if ([dd objectForKey:@"hwh"]==nil||[[dd objectForKey:@"hwh"] isEqual:@""]) {
            _hhhwww.text=@"";
        }else
            _hhhwww.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"hwh"]];
        if ([dd objectForKey:@"pzwh"]==nil||[[dd objectForKey:@"pzwh"] isEqual:@""]) {
            _wenhao.text=@"";
        }else
            _wenhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"pzwh"]];
        if ([dd objectForKey:@"sccj"]==nil||[[dd objectForKey:@"sccj"] isEqual:@""]) {
            haha.text=@"";
        }else
            haha.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"sccj"]];
        if ([dd objectForKey:@"gg"]==nil||[[dd objectForKey:@"gg"] isEqual:@""]) {
            _guige.text=@"";
        }else
            _guige.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"gg"]];
        if ([dd objectForKey:@"ypmc"]==nil||[[dd objectForKey:@"ypmc"] isEqual:@""]) {
            ming1.text=@"";
        }else
            ming1.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypmc"]];
        if ([dd objectForKey:@"ypbh"]==nil||[[dd objectForKey:@"ypbh"] isEqual:@""]) {
            bian1.text=@"";
        }else
            bian1.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypbh"]];
        if ([dd objectForKey:@"hwh"]==nil||[[dd objectForKey:@"hwh"] isEqual:@""]) {
            wei1.text=@"";
        }else
            wei1.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"hwh"]];
        if ([dd objectForKey:@"gg"]==nil||[[dd objectForKey:@"gg"] isEqual:@""]) {
            ge1.text=@"";
        }else
            ge1.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"gg"]];
        
        
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
    //    static NSString * identifer = @"identifer";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    //    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
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
    
    //[pop removeAllObjects];
    
    if (indexPath.row==0) {
        shuliang.text=@"药品数量:";
        tt=[[UITextField alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        [tt.layer setCornerRadius:5];
        tt.delegate=self;
        tt.tag=10000+indexPath.section;
        
        if (liebiao!=nil&&w!=0) {
            //有上传文件
            if ([liebiao[indexPath.section]objectForKey:@"shuliang"]==nil) {
                //但是  数据是在下载文件拿到的;
                tt.text=@"";
                int dapi=0;
                for (int pi=0; pi<pop.count; pi++) {
                    if (((UITextField*)pop[pi]).tag==tt.tag) {
                        dapi=1;
                    }
                }
                if (dapi==0) {
                    [pop addObject:tt];
                }
                
                //这个小的if从句  就是决解滑动tableview  数字消失的 方法
                if (zi==1) {
                    tt.text =((UITextField*)pop[indexPath.section]).text;
                }
            }
            else{
                //如果是在上传列表中取出的数据  那么  tt需要赋值
                tt.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section]objectForKey:@"shuliang"]];
                int dapi=0;
                for (int pi=0; pi<pop.count; pi++) {
                    if (((UITextField*)pop[pi]).tag==tt.tag) {
                        dapi=1;
                    }
                }
                if (dapi==0) {
                    [pop addObject:tt];
                }
                
                if (zi==1) {
                    tt.text =((UITextField*)pop[indexPath.section]).text;
                    //NSLog(@"%@",((UITextField*)pop[indexPath.section]).text);
                }
            }
        }
        else{
            //没有上传文件
            //直接下载列表
            tt.text=@"";
            if (paue==1) {
                if ([[liebiao[indexPath.section] allKeys ] containsObject:@"shuliang"]) {
                     tt.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section] objectForKey:@"shuliang"]];
                }
                
               
            }
            
            if (woshixiangying==1) {
                tt.text=[NSString stringWithFormat:@"%@",liang1.text];
                woshixiangying=0;
            }
            int dapi=0;
            for (int pi=0; pi<pop.count; pi++) {
                if (((UITextField*)pop[pi]).tag==tt.tag) {
                    dapi=1;
                }
            }
            if (dapi==0) {
                [pop addObject:tt];
            }
            NSLog(@"pop-------%@",pop);
            if (zi==1) {
                
                tt.text =((UITextField*)pop[indexPath.section]).text;
                //NSLog(@"%@",((UITextField*)pop[indexPath.section]).text);
            }
            
        }
        //查询之后，tableview中的第一个textfield成为第一响应者；
        
       // NSLog(@"%lu    %lu",pop.count,liebiao.count);
        if (qwer==0) {
            [pop[0] becomeFirstResponder];
        }
        
        
        
        
        // }
        
        
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
        tableView.hidden=YES;
        tiji=0;
        return 0;
    }else if(liebiao.count==0){
        tableView.hidden=YES;
        tiji=0;
        return 0;
    }
    else{
        tableView.hidden=NO;
        tiji=1;
        return liebiao.count;
    }
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
        qwer=1;
        [_tableview reloadData];
    }
    
}

- (IBAction)yi:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"1"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"1"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)er:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"2"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"2"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        
        NSLog(@"pop----%@",((UITextField*)pop[po]).text);
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)san:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"3"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"3"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)si:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"4"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"4"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
    
}

- (IBAction)wu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"5"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"5"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)liu:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"6"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"6"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)qi:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"7"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"7"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)ba:(id)sender {
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"8"];
    }else{
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"8"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)jiu:(id)sender {
   
    if (oo==0) {
        _sousuo.text=[_sousuo.text stringByAppendingString:@"9"];
    }else{
        
        
        UITextField*xixi=pop[po];
        xixi.text=[xixi.text stringByAppendingString:@"9"];
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
    }
}

- (IBAction)qingkong:(id)sender {
    if (oo==0) {
        _sousuo.text=@"";
    }else{
        UITextField*xixi=pop[po];
        xixi.text=@"";
        
        [pop replaceObjectAtIndex:po withObject:xixi];
        qwer=1;
        [_tableview reloadData];
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
        qwer=1;
        [_tableview reloadData];
        
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
            ///////////////////-------------/////////////////
            qwer=0;
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
    if([_hhhwww.text isEqual:@""]||_hhhwww==nil){
        [WarningBox warningBoxModeText:@"货位不能为空~" andView:self.view];
    }else{
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
            int op=0;int liuliu=0;
            NSMutableArray*pkq=[NSMutableArray array];
            int wawawapi=0;
            for (int kl=0; kl<arp.count-op; kl++) {
                if ([[NSString stringWithFormat:@
                                 "%@",[arp[kl] objectForKey:@"txm"]] isEqual:_sousuo.text]){
                    liuliu++;
                    if([pp.text isEqual:[NSString stringWithFormat:@"%@",[arp[kl] objectForKey:@"ph" ]]]){
                        
                        [arp removeObjectAtIndex:kl-op];
                        op++;
                        //NSLog(@"/*/*/*/*%ld",arp.count);
                    }
                }
                else{
                    if ([[NSString stringWithFormat:@"%@",[arp[kl] objectForKey:@"txm"]]rangeOfString:@","].location!=NSNotFound) {
                        [pkq addObject:arp[kl]];
                        wawawapi=1;
                    }
                }

            }
            if (liuliu==0) {
                int heh=0;
                for (int lp=0; lp<pkq.count-heh; lp++) {
                    NSArray*uty=[[pkq[lp] objectForKey:@"txm"]componentsSeparatedByString:@","];
                    for (NSString *nono in uty) {
                        if ([nono isEqual:_sousuo.text]) {
                            if([pp.text isEqual:[NSString stringWithFormat:@"%@",[pkq[lp] objectForKey:@"ph" ]]]){
                                
                                [arp removeObjectAtIndex:lp-heh];
                                heh++;
                                //NSLog(@"/*/*/*/*%ld",arp.count);
                            }

                        }
                    }
                }
            }
            //添加新数据
            
            [arp addObject:liebiao[0]];
            
            //写入
            tiji=0;
            if ([[liebiao[0] objectForKey:@"hwh"] isEqual:_hhhwww.text]) {
                for (NSDictionary*dd in liebiao) {
                    [dd setValue:@"0" forKey:@"hwh_flag"];
                }
                
                [arp writeToFile:path1 atomically:YES];
            }
            else{
                NSMutableArray*pkq=[NSMutableArray array];
                int wawawapi=0;
                int wahaha=0;
                for (NSDictionary*dd in arp) {
                    [dd setValue:@"0" forKey:@"hwh_flag"];
                    if ([dd objectForKey:@"new_added"]==nil) {
                            [dd setValue:@"0" forKey:@"new_added"];
                        }
                    if ([[dd objectForKey:@"txm"] isEqual:_sousuo.text]) {
                        wahaha++;
                        [dd setValue:@"1" forKey:@"hwh_flag"];
                        [dd setValue:_hhhwww.text forKey:@"hwh"];
                        
                    }
                    else{
                        if ([[dd objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                            [pkq addObject:dd];
                            wawawapi=1;
                        }
                    }
                }
                if (wahaha==0) {
                    for (NSDictionary*xixi in pkq) {
                        NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                        for (NSString*nono in uty) {
                            if ([nono isEqualToString:_sousuo.text]) {
                    
                                [xixi setValue:@"1" forKey:@"hwh_flag"];
                                [xixi setValue:_hhhwww.text forKey:@"hwh"];
                                if ([xixi objectForKey:@"new_added"]==nil) {
                                    [xixi setValue:@"0" forKey:@"new_added"];
                                }

                            
                            }
                        }
                    }
                }
                [arp writeToFile:path1 atomically:YES];
            }
            
            [WarningBox warningBoxModeText:@"数据更改成功!" andView:self.view];
            oo=3;
            tiji=0;
            [self viewWillAppear:YES];
        }
        else{
            tiao=0;
            zi=0;
            //判断是否数量有空值
            int h=0;
            //有点小问题。。。。。
            
            if (pop.count<liebiao.count) {
                [WarningBox warningBoxModeText:@"请仔细检查数量问题!" andView:self.view];
            }
            else{
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
                    tiji=0;
                    if (![fm fileExistsAtPath:path1]) {
                        if ([[liebiao[0] objectForKey:@"hwh"] isEqual:_hhhwww.text]) {
                            for (NSDictionary*dd in liebiao) {
                                [dd setValue:@"0" forKey:@"hwh_flag"];
                                if ([dd objectForKey:@"new_added"]==nil) {
                                    [dd setValue:@"0" forKey:@"new_added"];
                                }
                            }
                            [liebiao writeToFile:path1 atomically:YES];
                        }
                        else{
                            NSMutableArray*pkq=[NSMutableArray array];
                            int wawawapi=0;
                            int wahaha=0;
                            
                            for (NSDictionary*dd in liebiao) {
                                if ([dd objectForKey:@"new_added"]==nil) {
                                    [dd setValue:@"0" forKey:@"new_added"];
                                }
                                if ([[dd objectForKey:@"txm"] isEqual:_sousuo.text]) {
                                    wahaha++;
                                    [dd setValue:@"1" forKey:@"hwh_flag"];
                                    [dd setValue:_hhhwww.text forKey:@"hwh"];
                                }else{
                                    if ([(NSString*)[dd objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                                        [pkq addObject:dd];
                                        wawawapi=1;
                                    }
                                }

                                }
                            if (wahaha==0) {
                                for (NSDictionary*xixi in pkq) {
                                    NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                                    for (NSString*nono in uty) {
                                        if ([nono isEqualToString:_sousuo.text]) {
                                            [xixi setValue:@"1" forKey:@"hwh_flag"];
                                            [xixi setValue:_hhhwww.text forKey:@"hwh"];
                                        }
                                    }
                                }
                            }
                                
                            }
                            
                            [liebiao writeToFile:path1 atomically:YES];
                        }
                        
                        
                    
                    
                else{
                        tiji=0;
                        if (w!=0) {
                            //这里有一点点 漏洞     应该好使了
                            NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
                            //删除文件中原有数据
                            int op=0;
                            NSMutableArray*pkq=[NSMutableArray array];
                            int wawawapi=0;
                            int wahaha=0;
                            for (int kl=0; kl<arp.count+op; kl++) {
                                if ([[NSString stringWithFormat:@
                                      "%@",[arp[kl-op] objectForKey:@"txm"]] isEqual:_sousuo.text]){
                                    wahaha++;
                                    [arp removeObjectAtIndex:kl-op];
                                    op++;
                                    // NSLog(@"/*/*/*/*%ld",arp.count);
                                }
                                else{
                                    
                                    if (op==0) {
                                        if ([(NSString*)[arp[kl] objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                                        [pkq addObject:arp[kl]];
                                        wawawapi=1;
                                    }

                                    }
                                    
                                }
                            }
                            if (wahaha==0) {
                                int memede=0;
                                for (int kl=0; kl<arp.count+memede; kl++) {
                                    NSArray*uty=[[arp[kl-memede] objectForKey:@"txm"] componentsSeparatedByString:@","];
                                    for (NSString*nono in uty) {
                                        if ([nono isEqual:_sousuo.text]) {
                                            [arp removeObjectAtIndex:kl-memede];
                                            memede++;
                                            
                                        }
                                    }
                                }
                            }
                            //添加新数据
                            for (NSDictionary*d in liebiao) {
                                [arp addObject:d];
                            }
                            //写入
                            if ([[liebiao[0] objectForKey:@"hwh"] isEqual:_hhhwww.text]) {
                                
                                [arp writeToFile:path1 atomically:YES];
                            }
                            else{
                                NSMutableArray*pkq=[NSMutableArray array];
                                int wawawapi=0;
                                int wahaha=0;

                                for (NSDictionary*dd in arp) {
                                    if ([dd objectForKey:@"new_added"]==nil) {
                                        [dd setValue:@"0" forKey:@"new_added"];
                                    }
                                    if ([[dd objectForKey:@"txm"] isEqual:_sousuo.text]) {
                                        wahaha++;
                                        [dd setValue:@"1" forKey:@"hwh_flag"];
                                        [dd setValue:_hhhwww.text forKey:@"hwh"];
                                    }else{
                                        if ([(NSString*)[dd objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                                            [pkq addObject:dd];
                                            wawawapi=1;
                                        }
                                    }
                                }
                                if (wahaha==0) {
                                    for (NSDictionary*xixi in pkq) {
                                        NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                                        for (NSString*nono in uty) {
                                            if ([nono isEqualToString:_sousuo.text]) {
                                                [xixi setValue:@"1" forKey:@"hwh_flag"];
                                                [xixi setValue:_hhhwww.text forKey:@"hwh"];
                                            }
                                        }
                                    }

                                }
                                [arp writeToFile:path1 atomically:YES];
                            }
                            
                            
                        }
                        else{
                            NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
                            for (NSDictionary*d in liebiao) {
                                [arp addObject:d];
                            }
                            if ([[liebiao[0] objectForKey:@"hwh"] isEqual:_hhhwww.text]) {
                                [arp writeToFile:path1 atomically:YES];
                            }
                            else{
                                NSMutableArray*pkq=[NSMutableArray array];
                                int wawawapi=0;
                                int wahaha=0;
                                for (NSDictionary*dd in arp) {
                                    if ([dd objectForKey:@"new_added"]==nil) {
                                        [dd setValue:@"0" forKey:@"new_added"];
                                    }
                                    if ([[dd objectForKey:@"txm"] isEqual:_sousuo.text]) {
                                        wahaha=1;
                                        [dd setValue:@"1" forKey:@"hwh_flag"];
                                        [dd setValue:_hhhwww.text forKey:@"hwh"];
                                    }
                                    else{
                                        if ([(NSString*)[dd objectForKey:@"txm"] rangeOfString:@","].location!=NSNotFound) {
                                            [pkq addObject:dd];
                                            wawawapi=1;
                                        }
                                    }
                                }
                                if (wahaha==0) {
                                    for (NSDictionary*xixi in pkq) {
                                        NSArray*uty=[[xixi objectForKey:@"txm"] componentsSeparatedByString:@","];
                                        for (NSString*nono in uty) {
                                            if ([nono isEqualToString:_sousuo.text]) {
                                                [xixi setValue:@"1" forKey:@"hwh_flag"];
                                                [xixi setValue:_hhhwww.text forKey:@"hwh"];
                                            }
                                        }
                                    }

                                }
                                [arp writeToFile:path1 atomically:YES];
                            }
                            
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
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField!=_sousuo) {
        _sousuo.layer.borderWidth=0;
        oo=1;
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        //下边这句话憋了我一天半  十分重要；tableview里textfield取值
        po=(int)textField.tag-10000;
    }else{
        
        for (UITextField*ss in pop) {
            ss.layer.borderWidth=0;
        }
        _hhhwww.layer.borderWidth=1;
        _hhhwww.layer.borderColor=[[UIColor grayColor] CGColor];
        oo=0;
        _sousuo.text=@"";
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun_press.png"] forState:UIControlStateHighlighted];
        
    }

    if (textField==_hhhwww||textField==shu1||textField==liang1||textField==pi1||textField==hao1||textField==hwei1||textField==biaohaoaa1) {
        return YES;
    }
    [self.view endEditing:YES];
    for (UITextField*ss in pop) {
        ss.layer.borderWidth=0;
    }
    textField.layer.borderColor=[[UIColor greenColor] CGColor];
    textField.layer.borderWidth=1.0;
    
    
//    NSArray *aa=[self.centralManager retrieveConnectedPeripheralsWithServices:@[[CBUUID UUIDWithString:@"180F"]]];
//    
//    NSLog(@"---%@",aa);
    
    if (textField==_sousuo) {
//        if ([aa count]>0) {
            return YES;
//        }else
//            return NO;
    }
    
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField==_hhhwww||textField==pi1||textField==hao1||textField==hwei1||textField==biaohaoaa1) {
        [self setupCustomedKeyboard:textField];
    }
    
    
    
    
  
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.layer.borderWidth=0;
    if (textField==_hhhwww||textField==shu1||textField==liang1||textField==pi1||textField==hao1||textField==hwei1||textField==biaohaoaa1) {
        textField.layer.borderWidth=1;
        textField.layer.borderColor=[[UIColor blackColor] CGColor];
    
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    [(DSKyeboard *)textField.inputView clear];
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_hhhwww resignFirstResponder];
    if (textField==_sousuo) {
        [_sousuo resignFirstResponder];
        [self shuosou:_sousuo.text];
        oo=1;
        
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_chading setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        return YES;
    }
    

    return YES;
}

- (void)setupCustomedKeyboard:(UITextField*)tf {
    tf.inputView = [DSKyeboard keyboardWithTextField:tf];
    
    
    [(DSKyeboard *)tf.inputView dsKeyboardTextChangedOutputBlock:^(NSString *fakePassword) {
        
        tf.text = fakePassword;
    } loginBlock:^(NSString *password) {
        [tf resignFirstResponder];
        //        tf.text = [NSString stringWithFormat:@"%@", password];
    }];
}

@end
