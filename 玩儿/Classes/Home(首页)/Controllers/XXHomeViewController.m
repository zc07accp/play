//
//  XXHomeViewController.m
//  玩儿
//
//  Created by 欢欢 on 16/3/8.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXHomeViewController.h"
#import "XXAllTableViewController.h"
#import "XXVideoTableViewController.h"
#import "XXVoiceTableViewController.h"
#import "XXPictureTableViewController.h"
#import "XXWordTableViewController.h"
//精华，顶部view的高度
#define XXTitleViewH 40
//精华顶部View的Y值
#define XXTitleViewY 64
@interface XXHomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)XXAllTableViewController *all;
@property(nonatomic,strong)XXVideoTableViewController *video;
@property(nonatomic,strong)XXVoiceTableViewController *voice;
@property(nonatomic,strong)XXPictureTableViewController *picture;
@property(nonatomic,strong)XXWordTableViewController *word;
//选中指示View
@property(nonatomic,weak)UIView *indexView;
//标签视图
@property(nonatomic,strong)UIView*titleView;
//当前选中的按钮
@property(nonatomic,weak)UIButton*currentSelectButton;
//滚动视图
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation XXHomeViewController
//懒加载
-(XXAllTableViewController*)all
{
    if(!_all)
    {
        _all=[XXAllTableViewController new];
    }
    
    return _all;
}
-(XXVideoTableViewController*)video
{
    if(!_video)
    {
        _video=[XXVideoTableViewController new];
    }
    
    return _video;
}
-(XXVoiceTableViewController*)voice
{
    if(!_voice)
    {
        _voice=[XXVoiceTableViewController new];
    }
    
    return _voice;
}
-(XXPictureTableViewController*)picture
{
    if(!_picture)
    {
        _picture=[XXPictureTableViewController new];
    }
    
    return _picture;
}
-(XXWordTableViewController*)word
{
    if(!_word)
    {
        _word=[XXWordTableViewController new];
        
        
    }
    return _word;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置背景色
     self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    //清理内存
    [super didReceiveMemoryWarning];
    //初始化导航栏
    [self setupNav];
    //初始化子控制器
    [self setupChildVC];
    
    //设置顶部标签
    [self setupTitleView];
    //设置底部的滚动视图
    [self setupScrollView];
    
    
}

-(void)setupNav
{
    //设置导航栏的标题
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}
//初始化子控制器
-(void)setupChildVC
{
    self.all=[[XXAllTableViewController alloc]init];
    self.all.title=@"全部";
    [self addChildViewController:self.all];
    self.video=[[XXVideoTableViewController alloc]init];
    self.video.title=@"视频";
    [self addChildViewController:self.video];
    self.voice=[[XXVoiceTableViewController alloc]init];
    self.voice.title=@"声音";
    [self addChildViewController:self.voice];
    self.picture=[[XXPictureTableViewController alloc]init];
    self.picture.title=@"图片";
    [self addChildViewController:self.picture];
    self.word=[[XXWordTableViewController alloc]init];
    self.word.title=@"段子";
    [self addChildViewController:self.word];

}
//设置顶部标签
-(void)setupTitleView
{
    //设置标签栏背景半透明
    self.titleView=[[UIView alloc]initWithFrame:CGRectMake(0, XXTitleViewY, self.view.bounds.size.width, XXTitleViewH)];
    self.titleView.backgroundColor=[[UIColor redColor]colorWithAlphaComponent:1];
    [self.view addSubview:self.titleView];
    //按钮底部的指示器
    UIView*indexView=[[UIView alloc]init];
    indexView.backgroundColor=[UIColor whiteColor];
    indexView.tag=-1;
    self.indexView=indexView;
    //设置indexView的Y和高
    CGRect btnframe=self.indexView.frame;
    btnframe.size.height=3;
    btnframe.origin.y=self.titleView.bounds.size.height-6;
    self.indexView.frame=btnframe;
    
    
    //设置标签栏上的按钮
    
    for(int i=0;i<self.childViewControllers.count;i++)
    {
        UIButton *button=[[UIButton alloc]init];
        button.tag=i;
        UIViewController *vc=self.childViewControllers[i];
        button.frame=CGRectMake(i*(self.titleView.bounds.size.width/self.childViewControllers.count), 0, self.titleView.bounds.size.width/self.childViewControllers.count, self.titleView.bounds.size.height);
        [button setTitle:vc.title forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        button.titleLabel.font=[UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(titleclick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.titleView addSubview:button];
        //默认选中第一个按钮
        if(i==0)
        {
            button.enabled=NO;
            self.currentSelectButton=button;
            button.titleLabel.font=[UIFont boldSystemFontOfSize:22];
            //让按钮内部的label根据文字计算尺寸
            [button.titleLabel sizeToFit];
            CGRect btnframe=self.indexView.frame;
            btnframe.origin.x=button.center.x-22;
            btnframe.size.width=button.titleLabel.bounds.size.width;
            self.indexView.frame=btnframe;
            
        }
        
    }
    [self.titleView addSubview:self.indexView];

    
    
    
    
}
//设置底部的滚动视图
-(void)setupScrollView
{
    //不自动调整inset
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView* scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    scrollView.delegate=self;
    scrollView.pagingEnabled=YES;
    scrollView.contentSize=CGSizeMake(scrollView.bounds.size.width*self.childViewControllers.count, 0);
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView=scrollView;
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    
}
//设置按钮点击方法
-(void)titleclick:(UIButton*)button
{
    //当前按钮的状态来决定放大和缩小文字
    if(self.currentSelectButton.enabled==YES)
    {
        self.currentSelectButton.titleLabel.font=[UIFont boldSystemFontOfSize:22];
        
    }
    else
    {
        self.currentSelectButton.titleLabel.font=[UIFont systemFontOfSize:16];
    }
    //修改按钮的选中状态
    self.currentSelectButton.enabled=YES;
    //让按钮进入选中状态
    button.enabled=NO;
    self.currentSelectButton=button;
    [UIView animateWithDuration:0.15 animations:^{
        //更改indexView的x来实现移动
        CGRect btnframe=self.indexView.frame;
        btnframe.origin.x=button.center.x-18;
        btnframe.size.width=button.titleLabel.bounds.size.width;
        self.indexView.frame=btnframe;
        //当前按钮的状态来决定放大文字
        if(self.currentSelectButton.enabled==NO)
        {
            self.currentSelectButton.titleLabel.font=[UIFont boldSystemFontOfSize:22];
            
        }
        
    }];
    //切换子控制器
    CGPoint offset=self.scrollView.contentOffset;
    offset.x=button.tag*self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
}
#pragma mark--UIScrollViewDeleagate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //添加子控制器的view
    
    //当前的索引(偏移量除以宽)
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    //取出子控制器
    UITableViewController *vc=self.childViewControllers[index];
    vc.view.frame=CGRectMake(scrollView.contentOffset.x, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    CGFloat bottom=self.tabBarController.tabBar.bounds.size.height;
    CGFloat top=CGRectGetMaxY(self.titleView.frame);
    vc.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);
    [scrollView addSubview:vc.view];
    
}
//滚动结束后让索引条变动到当前按钮
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算滚动视图偏移量对应的indexView
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self titleclick:self.titleView.subviews[index]];
}



@end
