//
//  XXMeFootView.m
//  玩儿
//
//  Created by 欢欢 on 16/2/27.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXMeFootView.h"
#import "AFNetworking.h"
#import "XXSquare.h"
#import "MJExtension.h"
#import "UIButton+WebCache.h"
#import "XXSqaureButton.h"
#import "XXWebViewController.h"
#import "XXNavigationViewController.h"
#import "UIView+XXFrameExtension.h"
#define  XXScreenW [UIScreen mainScreen].bounds.size.width
#define  XXScreenH [UIScreen mainScreen].bounds.size.height
@implementation XXMeFootView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.height=570;
        self.backgroundColor=[UIColor clearColor];
        //参数
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        parameters[@"a"]=@"square";
        parameters[@"c"]=@"topic";
        
        //发送http请求
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
            NSArray *square=[XXSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建方块
            [self createSquare:square];
            
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       
                   }];
    }
    return self;
    
    
}
-(void)createSquare:(NSArray *)square
{
    //最大列数
    NSInteger Maxcol=4;
    //button的宽度
    CGFloat buttonW=XXScreenW/Maxcol;
    CGFloat buttonH=buttonW;
    
   
    for(NSInteger i=0;i<square.count;i++)
    {
       
        
        NSInteger row=i/Maxcol;
        NSInteger col=i%Maxcol;
        CGFloat x=col*buttonW;
        CGFloat y=row*buttonH;
        XXSqaureButton *button=[XXSqaureButton buttonWithType:(UIButtonTypeCustom)];
//        [button setTitle:squares.name forState:(UIControlStateNormal)];
//        //利用sdWebImage给button设置图片
//        [button sd_setImageWithURL:[NSURL URLWithString:squares.icon] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.square=square[i];
        button.frame=CGRectMake(x, y, buttonW, buttonH);
        [self addSubview:button];
    }
    
    
    
    
}



-(void)buttonClick:(XXSqaureButton*)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    XXWebViewController *web = [[XXWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    // 取出当前的导航控制器
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
    
    
    
    
}


@end
