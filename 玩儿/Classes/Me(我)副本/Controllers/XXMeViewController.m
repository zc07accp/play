//
//  XXMeViewController.m
//  玩儿
//
//  Created by 欢欢 on 16/2/15.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXMeViewController.h"
#import "XXMeCell.h"
#import "XXMeFootView.h"
#import "XXSetupTableViewController.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
#import "XXNavigationViewController.h"
#import "UIBarButtonItem+XXExtension.h"
#import "UMSocial.h"
@interface XXMeViewController ()<UMSocialUIDelegate>

@property(nonatomic,assign)CGFloat size;
@end
static NSString *ID=@"cell";
@implementation XXMeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的";
    //设置导航栏右边的按钮
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(buttonClick)];
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];


    //调整头部视图和底部视图的高
    self.tableView.sectionFooterHeight=10;
    self.tableView.sectionHeaderHeight=0;
    //调整内边距
    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
    //设置footView
    self.tableView.tableFooterView=[[XXMeFootView alloc]init];
    
    [self.tableView registerClass:[XXMeCell class] forCellReuseIdentifier:ID];
    }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XXMeCell *cell=[[XXMeCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:ID];
        if(indexPath.section==0)
        {cell.imageView.image=[UIImage imageNamed:@"setup-head-default"];
         cell.textLabel.text=@"推荐给朋友";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
      else if (indexPath.section==1)
      {
          cell.textLabel.text=@"当前版本1.0";
          cell.accessoryType=UITableViewCellAccessoryNone;
          cell.selectionStyle=UITableViewCellEditingStyleNone;
      }
    else
    {
        CGFloat size=[SDImageCache sharedImageCache].getSize/1000.0/1000;
        cell.textLabel.text=[NSString stringWithFormat:@"清除缓存（已使用%.1fMB）",size];
    }
    
    cell.textLabel.font=[UIFont systemFontOfSize:18];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    switch (indexPath.section)
    {
        case 0:
        {
            //添加友盟分享
            [UMSocialSnsService presentSnsIconSheetView:[UIApplication sharedApplication].keyWindow.rootViewController
                                                 appKey:@"56d4f87ce0f55a194d00334b"
                                              shareText:@"欢迎来到玩儿社区~~~"
                                             shareImage:[UIImage imageNamed:@"AppIconShare28@2x"]
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToEmail,UMShareToWechatTimeline,UMShareToWhatsapp,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                               delegate:self];
        }
            break;
        case 2:
        
            [[SDImageCache sharedImageCache] clearDisk];
           
            [self.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"缓存已清除"];
 
           
            break;
            
        default:
            break;
    }
    
    
}
-(void)buttonClick
{
    
    XXSetupTableViewController *setupVC=[[XXSetupTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    setupVC.title=@"设置";
   
    [self.navigationController pushViewController:setupVC animated:YES];
    
    
}
@end
