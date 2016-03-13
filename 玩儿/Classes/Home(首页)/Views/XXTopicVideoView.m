//
//  XXTopicVideoView.m
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXTopicVideoView.h"
#import "UIImageView+WebCache.h"
#import "XXTiezi.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "XXTopicCell.h"
#import "XXVideoTableViewController.h"
@interface XXTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property(nonatomic,strong)NSString *videoURL;
@property (weak, nonatomic) IBOutlet UIButton *playButton;




@end


@implementation XXTopicVideoView

+(instancetype)VideoView

{
    return [[[NSBundle mainBundle]loadNibNamed:@"XXTopicVideoView" owner:nil options:nil] lastObject];
    
}
-(void)awakeFromNib
{
    
    self.autoresizingMask=UIViewAutoresizingNone;
    
}
-(void)setTopic:(XXTiezi *)topic
{
    _topic=topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text=[NSString stringWithFormat:@"%ld播放",(long)topic.playcount];
    NSInteger minute=topic.videotime/60;
    NSInteger second=topic.videotime%60;
    self.videoTimeLabel.text=[NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second];
    self.videoURL=topic.videouri;

}
+(AVPlayerViewController*)shareInstance
{
    static AVPlayerViewController *playVC1=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        playVC1=[[AVPlayerViewController alloc]init];
        
    });
    return playVC1;
    
}
- (IBAction)playVideo
{
    
   
   AVPlayerViewController *playVC=[XXTopicVideoView shareInstance];
    playVC.player=[AVPlayer playerWithURL:[NSURL URLWithString:self.videoURL]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playVC animated:YES completion:^{
        [playVC.player play];
    }];
    

}

@end
