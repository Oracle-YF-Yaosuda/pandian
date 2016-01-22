//
//  PanDian_ViewController.m
//  PanDianZhuShou
//
//  Created by suokun on 16/1/19.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "PanDian_ViewController.h"

@interface PanDian_ViewController (){
    NSArray*arr;
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
  
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    for (int i=0; i<arr.count; i++) {
        if ([searchBar.text isEqualToString:[arr[i] objectForKey:@"txm"]]) {
            NSString *path1 =[NSHomeDirectory() stringByAppendingString:@"/Documents/shangchuanshuju.plist"];
            NSFileManager*fm=[NSFileManager defaultManager];
            if (![fm fileExistsAtPath:path1]) {
                [arr[i] writeToFile:path1 atomically:YES];
                [self textfuzhi:arr[i]];
            }
            
            else{
                
                NSMutableArray*arp=[NSMutableArray arrayWithContentsOfFile:path1];
                [arp addObject:arr[i]];
                [arp writeToFile:path1 atomically:YES];
                [self textfuzhi:arr[i]];
            }

        }
        
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
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
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
}

- (IBAction)yi:(id)sender {
}

- (IBAction)er:(id)sender {
}

- (IBAction)san:(id)sender {
}

- (IBAction)si:(id)sender {
}

- (IBAction)wu:(id)sender {
}

- (IBAction)liu:(id)sender {
}

- (IBAction)qi:(id)sender {
}

- (IBAction)ba:(id)sender {
}

- (IBAction)jiu:(id)sender {
}

- (IBAction)qingkong:(id)sender {
}

- (IBAction)houtui:(id)sender {
}

- (IBAction)shangyitiao:(id)sender {
}

- (IBAction)chaxun:(id)sender {
}
@end
