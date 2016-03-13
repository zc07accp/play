//
//  XXSetupTableViewController.m
//  玩儿
//
//  Created by 欢欢 on 16/2/27.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXSetupTableViewController.h"

@interface XXSetupTableViewController ()

@end

@implementation XXSetupTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];

}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    switch (indexPath.row)
    {
      
        
        case 0:
            
            cell.textLabel.text=@"帮助";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            break;
       
        case 1:
            
            cell.textLabel.text=@"关于我们";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            
            cell.textLabel.text=@"设备信息";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            
            cell.textLabel.text=@"隐私政策";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 4:
            
            cell.textLabel.text=@"打分支持一下我哦！";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;

            
        default:
            break;
    }
    
    
    
  
    return cell;
}


@end
