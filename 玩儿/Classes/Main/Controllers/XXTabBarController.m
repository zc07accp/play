//
//  XXTabBarController.m
//  玩儿
//
//  Created by 欢欢 on 16/3/8.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXTabBarController.h"
#import "XXHomeViewController.h"
#import "XXMeViewController.h"
#import "XXThroughViewController.h"
#import "XXNavigationViewController.h"
@interface XXTabBarController ()
@property(nonatomic,strong)XXHomeViewController *home;
@property(nonatomic,strong)XXThroughViewController *through;
@property(nonatomic,strong)XXMeViewController *me;
@end

@implementation XXTabBarController
//懒加载子控制器
-(XXHomeViewController*)home
{
    if(!_home)
    {
        _home=[XXHomeViewController new];
    }
    
    return _home;
}
-(XXThroughViewController *)through
{
    if(!_through)
    {
        _through=[XXThroughViewController new];
    }
    
    return _through;
}
-(XXMeViewController*)me
{
    if(!_me)
    {
        _me=[XXMeViewController new];
        
    }
    
    return _me;
}
//设置tabbar
+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 // 添加所有的子控制器
    [self setupChildViewControllers];
    
    
    
}
-(void)setupChildViewControllers
{
    self.home = [[XXHomeViewController alloc] init];
    [self setupOneChildViewController:self.home title:@"首页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    self.through = [[XXThroughViewController alloc] init];
    [self setupOneChildViewController:self.through title:@"穿越" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    
    self.me = [[XXMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setupOneChildViewController:self.me title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

}
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[XXNavigationViewController alloc] initWithRootViewController:vc]];
}



@end
