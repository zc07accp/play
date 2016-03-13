//
//  XXTiezi.h
//  玩儿
//
//  Created by 欢欢 on 16/2/20.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

typedef enum
{
    XXTopicTypeAll=1,
    XXTopicTypeVideo=41,
    XXTopicTypeVoice=31,
    XXTopicTypePicture=10,
    XXTopicTypeWord=29
}XXTopicType;
@interface XXTiezi : NSObject
//名字
@property(nonatomic,strong)NSString *name;
//头像的URL
@property(nonatomic,strong)NSString *profile_image;
//发帖时间
@property(nonatomic,strong)NSString *create_time;
//文字内容
@property(nonatomic,strong)NSString *text;
//顶的数量
@property(nonatomic,assign)NSInteger ding;
//踩的数量
@property(nonatomic,assign)NSInteger cai;
//转发的数量
@property(nonatomic,assign)NSInteger repost;
//评论的数量
@property(nonatomic,assign)NSInteger comment;

//cell高度
@property(nonatomic,assign)CGFloat cellHeight;
//图片的宽度
@property(nonatomic,assign)CGFloat width;
//图片的高度
@property(nonatomic,assign)CGFloat height;
//小图片的URL
@property(nonatomic,strong)NSString *small_image;
//中图片的URL
@property(nonatomic,strong)NSString *middle_image;
//大图片的URL
@property(nonatomic,strong)NSString *large_image;
//帖子的ID
@property(nonatomic,strong)NSString *ID;
//帖子的类型
@property(nonatomic,assign)XXTopicType type;
//图片控件的frame
@property(nonatomic,assign,readonly)CGRect pictureViewFrame;
//声音控件的frame
@property(nonatomic,assign,readonly)CGRect voiceViewFrame;
//视频控件的frame
@property(nonatomic,assign,readonly)CGRect videoViewFrame;
//图片是否超过最大限制
@property(nonatomic,assign,getter=isBigPicture)BOOL bigPicture;
//音频时长
@property(nonatomic,assign)NSInteger voicetime;
//音频播放的URL
@property(nonatomic,strong)NSString *voiceuri;
//视频时长
@property(nonatomic,assign)NSInteger videotime;
//视频播放的URL
@property(nonatomic,strong)NSString *videouri;
//音频播放次数
@property(nonatomic,assign)NSInteger playcount;
//播放器
@property(nonatomic,strong)AVPlayer *player;
//最热评论
@property(nonatomic,strong)NSArray *top_cmt;














@end
