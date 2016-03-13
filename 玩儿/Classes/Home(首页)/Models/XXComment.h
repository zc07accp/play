//
//  XXComment.h
//  玩儿
//
//  Created by 欢欢 on 16/3/2.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXUser;
@interface XXComment : NSObject
//评论的文字内容
@property(nonatomic,strong)NSString *content;
//评论音频文件时长
@property(nonatomic,assign)NSInteger voicetime;
//评论的URL
@property(nonatomic,strong)NSString *voiceuri;
//被点赞的数量
@property(nonatomic,assign)NSInteger like_count;
//用户
@property(nonatomic,strong)XXUser *user;
//下一页数据的id
@property(nonatomic,strong)NSString *ID;

@end
