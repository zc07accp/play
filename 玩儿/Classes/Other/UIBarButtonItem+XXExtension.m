//
//  UIBarButtonItem+XXExtension.m
//  玩儿
//
//  Created by 欢欢 on 16/2/16.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "UIBarButtonItem+XXExtension.h"

@implementation UIBarButtonItem (XXExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    button.frame=CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target  action:action forControlEvents:(UIControlEventTouchUpInside)];
   

    return [[self alloc]initWithCustomView:button];
    
}
@end
