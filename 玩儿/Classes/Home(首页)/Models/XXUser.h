//
//  XXUser.h
//  玩儿
//
//  Created by 欢欢 on 16/3/2.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXUser : NSObject
//评论用户名
@property(nonatomic,strong)NSString *username;
//评论头像
@property(nonatomic,strong)NSString *profile_image;
//评论性别
@property(nonatomic,strong)NSString *sex;
@end
