//
//  XXWordTableViewController.m
//  玩儿
//
//  Created by 欢欢 on 16/3/8.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXWordTableViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "XXTiezi.h"
#import "MJRefresh.h"
#import "XXTopicCell.h"
#import "XXNavigationViewController.h"
#import "XXCommentViewController.h"
@interface XXWordTableViewController ()
//段子数据
@property(nonatomic,strong)NSMutableArray *topics;
//当前页码
@property(nonatomic,assign)NSInteger page;
//加载下一页数据时需要
@property(nonatomic,strong)NSString *maxtime;
//上一次请求的参数
@property(nonatomic,strong)NSDictionary *parameters;
@end
static NSString *cellID=@"topic";
@implementation XXWordTableViewController

//懒加载
-(NSMutableArray*)topics
{
    if(!_topics)
    {
        _topics=[NSMutableArray array];
    }
    
    return _topics;
}
- (void)viewDidLoad
{
    [super didReceiveMemoryWarning];
    [super viewDidLoad];
    //初始化tableview
    [self setupTableView];
    //加载刷新控件
    [self setupMJRefresh];
    
}
//初始化tableview
-(void)setupTableView
{
    //取消表格的分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"XXTopicCell" bundle:nil] forCellReuseIdentifier:cellID];
    
}
//添加下拉刷新
-(void)setupMJRefresh
{
    //添加头部下拉刷新控件
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    //添加上拉刷新底部控件
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
#pragma mark--数据请求处理
//加载新的段子数据
-(void)loadNewTopics
{
    //如果要下拉刷新，那么先结束下拉刷新，避免同时刷新
    [self.tableView.mj_footer endRefreshing];
    //参数
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"list";
    parameters[@"c"]=@"data";
    parameters[@"type"]=@"29";
    self.parameters=parameters;
    //发送http请求
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        //如果上一次的请求与本次请求不同
        if(self.parameters!=parameters)
        {
            return ;
        }
        //存储第一页的maxtime
        
        self.topics=[XXTiezi mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime=responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page=0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请稍后再试"];
        if(self.parameters!=parameters)
        {
            return ;
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
//加载更多数据
-(void)loadMoreTopics
{
    //如果要下拉刷新，那么先结束下拉刷新，避免同时刷新
    [self.tableView.mj_header endRefreshing];
    //页码每次+1
    self.page++;
    
    //请求参数
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"list";
    parameters[@"c"]=@"data";
    parameters[@"type"]=@"29";
    parameters[@"page"]=@(self.page);
    parameters[@"maxtime"]=self.maxtime;
    self.parameters=parameters;
    //发送http请求
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        //如果上一次的请求与本次请求不同
        if(self.parameters!=parameters)
        {
            return ;
        }
        //存储maxtime
        self.maxtime=responseObject[@"info"][@"maxtime"];
        //存储上拉刷新以后的数据
        NSArray* newTopics=[XXTiezi mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请稍后再试"];
        [self.tableView.mj_footer endRefreshing];
        //刷新失败，恢复页码
        self.page--;
        if(self.parameters!=parameters)
        {
            return ;
        }
    }];
    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell==nil)
    {
        cell=[[XXTopicCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellID];
    }
    cell.topic=self.topics[indexPath.row];
    return cell;
}

#pragma mark 设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXTiezi *topic=self.topics[indexPath.row];
    
    
    return topic.cellHeight;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XXCommentViewController *commentVC=[[XXCommentViewController alloc]init];
    
    commentVC.topic=self.topics[indexPath.row];
    
    [self.navigationController pushViewController:commentVC animated:YES];
    
}
@end
