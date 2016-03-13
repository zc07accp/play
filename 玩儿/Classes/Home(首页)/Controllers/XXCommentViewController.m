//
//  XXCommentViewController.m
//  玩儿
//
//  Created by 欢欢 on 16/3/4.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXCommentViewController.h"
#import "XXTopicCell.h"
#import "XXTiezi.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "XXComment.h"
#import "XXCommentCell.h"
#import "UIView+XXFrameExtension.h"
#import "UIBarButtonItem+XXExtension.h"

#define  XXScreenW [UIScreen mainScreen].bounds.size.width
#define  XXScreenH [UIScreen mainScreen].bounds.size.height
@interface XXCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//最热评论
@property(nonatomic,strong)NSMutableArray *hotComments;
//最新评论
@property(nonatomic,strong)NSMutableArray *latesComment;
//当前页码
@property(nonatomic,assign)NSInteger page;
@end
static NSString *commentID=@"comment";
@implementation XXCommentViewController
//懒加载
-(NSMutableArray*)hotComments
{
    if(!_hotComments)
    {
        _hotComments=[NSMutableArray array];
    }
    
    return _hotComments;
}
-(NSMutableArray *)latesComment
{
    if(!_latesComment)
    {
        _latesComment=[NSMutableArray array];
    }
    return _latesComment;
    
}
- (void)viewDidLoad
{
    [super didReceiveMemoryWarning];
    [super viewDidLoad];
    //导航栏Item设置
    [self setupBasic];

    //添加刷新
    [self setupRefresh];
    
}
//添加下拉刷新
-(void)setupRefresh
{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    self.tableView.mj_footer.hidden=YES;
    
}
//下拉刷新数据
-(void)loadNewComments
{
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"dataList";
    parameters[@"c"]=@"comment";
    parameters[@"data_id"]=self.topic.ID;
    parameters[@"hot"]=@1;
    
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最热评论
        self.hotComments=[XXComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latesComment=[XXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //页码
        self.page=1;
        //刷新界面
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //控制底部视图的显示
        NSInteger total=[responseObject[@"total"]integerValue];
        if(self.latesComment.count>=total)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
        
    }];
    
    
}
//加载更多数据
-(void)loadMoreComment
{
    NSInteger page=self.page+1;
    
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"dataList";
    parameters[@"c"]=@"comment";
    parameters[@"data_id"]=self.topic.ID;
    parameters[@"page"]=@(page);
    XXComment *comment=[self.latesComment lastObject];
    parameters[@"lastcid"]=comment.ID;
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //最新评论
        NSArray*newComment=[XXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latesComment addObjectsFromArray:newComment];
        //页码
        self.page=page;
        //刷新界面
        [self.tableView reloadData];
        
        //控制底部视图的显示
        NSInteger total=[responseObject[@"total"]integerValue];
        if(self.latesComment.count>=total)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            //结束上拉刷新
            [self.tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        
        
    }];

    
    
    
    
    
    
    
}
-(void)setupBasic
{
    self.title=@"评论";

    //cell的高度设置
    self.tableView.estimatedRowHeight=44;
    //ios8以后自动计算cell的高度
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    //创建通知监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //注册commentCell
    [self.tableView registerNib:[UINib nibWithNibName:@"XXCommentCell" bundle:nil] forCellReuseIdentifier:commentID];
    
}

-(void)keyboardWillChangeFrame:(NSNotification*)not
{
    //键盘显示或者隐藏的frame
    CGRect frame=[not.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //底部工具栏底部的约束
    self.bottonSpace.constant=XXScreenH-frame.origin.y;
    //键盘弹出动画
    CGFloat duration=[not.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];//强制布局
    }];
    
    
}

//销毁通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
//返回第section组的数据
-(NSArray*)commentsInSection:(NSInteger)section
{
    if(section==0)
    {
        return self.hotComments.count?self.hotComments:self.latesComment;
    }
    return self.latesComment;
    
}
- (XXComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}
//返回
-(void)goBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark---UITableViewDelegate
//当tableView滚动的时候
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:NO];
    
}
#pragma mark--UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount=self.hotComments.count;
    NSInteger latesCount=self.latesComment.count;
    //有最热也有最新评论
    if(hotCount)
    {
        return 2;
    }
    //有最新评论
    else if (latesCount)
    {
        return 1;
    }
    //没有评论
    else
    {
        return 0;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount=self.hotComments.count;
    NSInteger latesCount=self.latesComment.count;
    //隐藏底部视图
    tableView.mj_footer.hidden=(latesCount==0);
    if(section==0)
    {
        return hotCount?hotCount:latesCount;
    }
    return  latesCount;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc]init];
    header.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];

    UILabel *label=[[UILabel alloc]init];
    label.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1];
    label.font=[UIFont systemFontOfSize:17];
    label.width=XXScreenW;
    label.x=10;
    label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    NSInteger hotCount=self.hotComments.count;
    if(section==0)
    {
        label.text=hotCount?@"最热评论":@"最新评论";
    }
    else
    {
        label.text=@"最新评论";
    }

    return header;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XXCommentCell*cell=[tableView dequeueReusableCellWithIdentifier:commentID];
    
    
    cell.comment=[self commentInIndexPath:indexPath];
    return cell;
}
@end
