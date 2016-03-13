//
//  XXTopWindow.m
//  玩儿
//
//  Created by 欢欢 on 16/3/9.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXTopWindow.h"
#import <UIKit/UIKit.h>
#import "UIView+XXFrameExtension.h"

static UIWindow *_window;
@implementation XXTopWindow

+(void)initialize
{
    _window=[[UIWindow alloc]init];
    _window.frame=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 20);
    _window.windowLevel=UIWindowLevelAlert;
    [_window addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
    
    
}
+(void)show
{
    
   
    _window.hidden=NO;
    _window.rootViewController=nil;
    
    
}
//监听窗口的点击
+(void)windowClick
{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+(void)searchScrollViewInView:(UIView*)superView
{
    for(UIScrollView *subView in superView.subviews)
    {
      
        //如果是scrollView，就滚到最顶部
        if([subView isKindOfClass:[UIScrollView class]]&&subView.isShowingOnKeyWindow)
        {
         
            CGPoint offset=subView.contentOffset;
            offset.y=-subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:subView];
        
    }

    
    
    
    
    
    
}
@end
