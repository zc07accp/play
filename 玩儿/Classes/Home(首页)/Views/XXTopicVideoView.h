//
//  XXTopicVideoView.h
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@class XXTiezi;
@interface XXTopicVideoView : UIView
//帖子数据
@property(nonatomic,strong)XXTiezi *topic;
+(instancetype)VideoView;
+(AVPlayerViewController*)shareInstance;
@end
