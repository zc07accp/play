//
//  XXTopicVoiceView.m
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXTopicVoiceView.h"
#import "UIImageView+WebCache.h"
#import "XXTiezi.h"
#import <AVFoundation/AVFoundation.h>
#import "XXTopicCell.h"
#import "XXVoiceTableViewController.h"
@class XXTopicCell;
@interface XXTopicVoiceView()


@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLael;
@property(nonatomic,strong)NSString * voiceURL;





@end
@implementation XXTopicVoiceView
+(AVPlayerViewController*)shareInstance
{
    static AVPlayerViewController *playVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        playVC=[[AVPlayerViewController alloc]init];
        
    });
    return playVC;
    
}
+(instancetype)voiceView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"XXTopicVoiceView" owner:nil options:nil] lastObject];
    
}
-(void)awakeFromNib
{
    
    self.autoresizingMask=UIViewAutoresizingNone;
    
}
-(void)setTopic:(XXTiezi *)topic
{
    _topic=topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLael.text=[NSString stringWithFormat:@"%ld播放",(long)topic.playcount];
    NSInteger minute=topic.voicetime/60;
    NSInteger second=topic.voicetime%60;
    self.voicelengthLabel.text=[NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second];
    self.voiceURL=topic.voiceuri;
//    topic.isPlaying=NO;
    
}



- (IBAction)clickPlay:(UIButton *)sender
{

    NSString *urlStr=self.voiceURL;
    NSURL *url=[NSURL URLWithString:urlStr];
    AVPlayerViewController *playVC =[XXTopicVoiceView shareInstance];
    playVC.player=[[AVPlayer alloc]initWithURL:url];
    if(sender.selected==NO)
    {
        [playVC.player play];
        self.playButton.selected=YES;
    }
    else
    {
        [playVC.player pause];
        self.playButton.selected=NO;
    }
}



@end
