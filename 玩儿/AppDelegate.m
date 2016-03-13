//
//  AppDelegate.m
//  玩儿
//
//  Created by 欢欢 on 16/3/8.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "AppDelegate.h"
#import "XXTabBarController.h"
#import "XXTopWindow.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#define AppKey @"56d4f87ce0f55a194d00334b"
#define WXID @"wx69d5d71f4328bcd5"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
    [UMSocialData setAppKey:AppKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXID appSecret:AppKey url:@"http://www.budejie.com/"];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    XXTabBarController *tabbar=[[XXTabBarController alloc]init];
    self.window.rootViewController=tabbar;
    
    
    [self.window makeKeyAndVisible];
  
  
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    //添加一个window，点击这个window用来处理scrollView回到顶部
//    [XXTopWindow show];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
