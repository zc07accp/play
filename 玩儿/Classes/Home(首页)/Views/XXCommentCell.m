//
//  XXCommentCell.m
//  玩儿
//
//  Created by 欢欢 on 16/3/7.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXCommentCell.h"
#import "XXComment.h"
#import "UIImageView+WebCache.h"
#import "XXUser.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UIView+XXFrameExtension.h"
//男性
#define XXUserSexM @"m"
@interface XXCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property(nonatomic,strong)NSString *voiceURL;
@end

@implementation XXCommentCell
+(AVPlayerViewController*)shareInstance
{
    static AVPlayerViewController *playVC=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        playVC=[[AVPlayerViewController alloc]init];
        
    });
    return playVC;
    
}
-(void)setComment:(XXComment *)comment
{
    _comment=comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.sexView.image=[comment.user.sex isEqualToString:XXUserSexM]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text=comment.content;
    self.usernameLabel.text=comment.user.username;
    self.likeCountLabel.text=[NSString stringWithFormat:@"%ld",(long)comment.like_count];
    self.voiceURL=comment.voiceuri;
    if(comment.voiceuri.length)
    {
        self.voiceButton.hidden=NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%ld''",(long)comment.voicetime] forState:(UIControlStateNormal)];
    }
    else
    {
        self.voiceButton.hidden=YES;
    }
    
}
- (IBAction)playButton
{
    NSString *url=self.voiceURL;
    NSURL *voiceurl=[NSURL URLWithString:url];
    AVPlayerViewController *playVC=[XXCommentCell shareInstance];
    playVC.player=[[AVPlayer alloc]initWithURL:voiceurl];
    static BOOL isPlaying=NO;
    if(isPlaying)
    {
        [playVC.player pause];
        isPlaying=YES;
    }
    else
    {
        [playVC.player play];
        
    }
    
    
}



@end
