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
    NSArray*arr;
    NSMutableArray* liebiao;
}

@end

@implementation PanDian_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _search.delegate=self;
    NSString *path =[NSHomeDirectory() stringByAppendingString:@"/Documents/xiazaishuju.plist"];
    NSDictionary*dic=[NSDictionary dictionaryWithContentsOfFile:path];
    arr=[dic objectForKey:@"data"];
    NSLog(@"arr---%@",dic);
    NSLog(@"%@",NSHomeDirectory());
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    liebiao=[[NSMutableArray alloc] init];
    NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
    NSFileManager*fm=[NSFileManager defaultManager];
    int p=0;int q=0;
    if ([fm fileExistsAtPath:path1]) {
        NSArray*aa=[NSArray arrayWithContentsOfFile:path1];
        for (int i=0; i<aa.count; i++) {
            if ([searchBar.text isEqualToString:[aa[i] objectForKey:@"txm"]]) {
                p++;
                [self textfuzhi:aa[i]];
                [liebiao addObject:aa[i]];
                
            }
        }
        [_tableview reloadData];
    }
    else{
    
    for (int i=0; i<arr.count; i++) {
        if ([searchBar.text isEqualToString:[arr[i] objectForKey:@"txm"]]) {
            q++;
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
    if (p==0) {
        
        for (int i=0; i<arr.count; i++) {
            if ([searchBar.text isEqualToString:[arr[i] objectForKey:@"txm"]]) {
                [liebiao addObject:arr[i]];
                [self textfuzhi:arr[i]];
            }
            
        }
        [_tableview reloadData];
    }
    if (q==0) {
        [WarningBox warningBoxModeText:@"" andView:self.view];
    }
}
-(void)textfuzhi:(NSDictionary*)dd{
    _yaoming.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypmc"]];
    _bianhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"ypbh"]];
    _huowei.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"hwh"]];
    _wenhao.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"pzwh"]];
    _changjia.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"sccj"]];
    _guige.text=[NSString stringWithFormat:@"%@",[dd objectForKey:@"gg"]];
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
        
    }else{
        
        shuliang.text=@"批        号:";
        pp=[[UILabel alloc] initWithFrame:CGRectMake(85, 10, 300, 20)];
        pp.text=[NSString stringWithFormat:@"%@",[liebiao[indexPath.section ] objectForKey:@"ph"]];
    }
    
    [cell addSubview:shuliang];
    [cell addSubview:tt];
    [cell addSubview:pp];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (liebiao!=nil) {
        
        return liebiao.count;
    }
    
    return 0;

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

- (IBAction)ling:(id)sender {
    _search.text=[_search.text stringByAppendingString:@"0"];
}

- (IBAction)yi:(id)sender {
    _search.text=[_search.text stringByAppendingString:@"1"];
}

- (IBAction)er:(id)sender {
    _search.text=[_search.text stringByAppendingString:@"2"];
}

- (IBAction)san:(id)sender {
   _search.text=[_search.text stringByAppendingString:@"3"];
}

- (IBAction)si:(id)sender {
   _search.text=[_search.text stringByAppendingString:@"4"];
}

- (IBAction)wu:(id)sender {
    _search.text=[_search.text stringByAppendingString:@"5"];
}

- (IBAction)liu:(id)sender {
   _search.text=[_search.text stringByAppendingString:@"6"];
}

- (IBAction)qi:(id)sender {
   _search.text=[_search.text stringByAppendingString:@"7"];
}

- (IBAction)ba:(id)sender {
   _search.text=[_search.text stringByAppendingString:@"8"];
}

- (IBAction)jiu:(id)sender {
    _search.text=[_search.text stringByAppendingString:@"9"];
}

- (IBAction)qingkong:(id)sender {
    _search.text=@"";
}

- (IBAction)houtui:(id)sender {
    if ([_search.text isEqual:@""]) {
        
    }else
    _search.text= [_search.text substringToIndex:[_search.text length] - 1];
}

- (IBAction)shangyitiao:(id)sender {
}

- (IBAction)chaxun:(id)sender {
    [self searchBarSearchButtonClicked:sender];
}
@end
