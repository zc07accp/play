//
//  XXTopicVoiceView.h
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@class XXTiezi;
@interface XXTopicVoiceView : UIView
+(instancetype)voiceView;


+(AVPlayerViewController*)shareInstance;
//帖子数据
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)XXTiezi *topic;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property(nonatomic,copy)void(^didButton)(UIButton *button);

@end
