//
//  XXTopicCell.h
//  玩儿
//
//  Created by 欢欢 on 16/2/18.
//  Copyright © 2016年 欢欢. All rights reserved.
//
#import "XXTopicCell.h"
#import "XXTiezi.h"
#import "UIImageView+WebCache.h"
#import "XXTopicVoiceView.h"
#import "XXPictureView.h"
#import "XXTopicVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "XXTopicVideoView.h"
#import "XXTopicVoiceView.h"
#import "UMSocial.h"
#import "XXComment.h"
#import "XXUser.h"
#import "SVProgressHUD.h"
//精华，cell的间距
#define XXTopicCellMargin 10
//精华，cell底部工具条的高
#define XXTopicCellBottomBarH 35
//精华，cell文字的Y值
#define XXTopicCellTextY 60
//精华，顶部view的高度
#define XXTitleViewH 40
//精华顶部View的Y值
#define XXTitleViewY 64
//精华，cell图片最大高度
#define XXTopCellPictureMaxH 1000
//精华，cell图片如果超出的高度
#define XXTopCellPictureBreakH 250
//精华，cell最热评论标题高
#define XXTopCellTopCmtTitleH 20


#define  XXScreenW [UIScreen mainScreen].bounds.size.width
#define  XXScreenH [UIScreen mainScreen].bounds.size.height

@interface XXTopicCell()<UMSocialUIDelegate>
//头像
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

//踩
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

//分享
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

//评论
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

//段子的文字内容
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;
//声音的内容
@property(nonatomic,weak)XXTopicVoiceView *voiceView;
//图片的内容
@property(nonatomic,weak)XXPictureView *pictureView;
//视频的内容
@property(nonatomic,weak)XXTopicVideoView *videoView;
//最热评论内容
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
//最热评论整体View
@property (weak, nonatomic) IBOutlet UIView *topCmtView;



@end

@implementation XXTopicCell
+(instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:@"XXTopicCell" owner:nil options:nil]firstObject];
    
}
//懒加载
-(XXPictureView*)pictureView
{
    if(!_pictureView)
    {
        XXPictureView *pictureView=[XXPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView=pictureView;
    }
    return _pictureView;
}
-(XXTopicVoiceView*)voiceView
{
    if(!_voiceView)
    {
        XXTopicVoiceView *voiceView=[XXTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView=voiceView;
    }
    return _voiceView;
}
-(XXTopicVideoView*)videoView
{
    
    if(!_videoView)
    {
        XXTopicVideoView *videoView=[XXTopicVideoView VideoView];
        [self.contentView addSubview:videoView];
        _videoView=videoView;
    }
    return _videoView;
}




- (void)awakeFromNib
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=imageView;
    self.autoresizingMask=UIViewAutoresizingNone;
    
}
-(void)setTopic:(XXTiezi *)topic
{
    
    _topic=topic;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaulUsersIcon"]];
    self.nameLabel.text=topic.name;
    self.createTimeLabel.text=topic.create_time;
    [self.dingButton setTitle:[NSString stringWithFormat:@"%ld",(long)topic.ding] forState:(UIControlStateNormal)];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%ld",(long)topic.cai] forState:(UIControlStateNormal)];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",(long)topic.repost] forState:(UIControlStateNormal)];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",(long)topic.comment] forState:(UIControlStateNormal)];
    
    self.myTextLabel.text=topic.text;
    
    if(topic.type==XXTopicTypePicture)
    {   self.pictureView.hidden=NO;
        self.pictureView.topic=topic;
        self.pictureView.frame=topic.pictureViewFrame;
        self.voiceView.hidden=YES;
        self.videoView.hidden=YES;
    }
    else if (topic.type==XXTopicTypeVoice)
    {
        self.voiceView.hidden=NO;
        self.voiceView.topic=topic;
        self.voiceView.frame=topic.voiceViewFrame;
        self.pictureView.hidden=YES;
        self.videoView.hidden=YES;
        [self prepareForReuse];
    }
    else if (topic.type==XXTopicTypeVideo)
    {
        self.videoView.hidden=NO;
        self.videoView.topic=topic;
        self.videoView.frame=topic.videoViewFrame;
        self.pictureView.hidden=YES;
        self.voiceView.hidden=YES;
        [self prepareForReuse];
    }
    else 
    {
        self.pictureView.hidden=YES;
        self.voiceView.hidden=YES;
        self.videoView.hidden=YES;
    }
    XXComment *cmt=[topic.top_cmt firstObject];
    if(cmt)
    {
        self.topCmtView.hidden=NO;
        self.topCmtLabel.text=[NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
        
    }
    else
    {
         self.topCmtView.hidden=YES;
        
    }
    
   
}
-(void)setFrame:(CGRect)frame
{
    
    frame.origin.x=XXTopicCellMargin;
    frame.size.width -=2*frame.origin.x;
    frame.size.height=self.topic.cellHeight-XXTopicCellMargin;
    frame.origin.y+=XXTopicCellMargin;
    [super setFrame:frame];
    
    
    
}



-(void)prepareForReuse
{
    [super prepareForReuse];

    
    if([XXTopicVideoView shareInstance].view.superview)
    {
        [[XXTopicVideoView shareInstance].view removeFromSuperview];
        [XXTopicVideoView shareInstance].player=nil;
    }



}
//友盟第三方分享
- (IBAction)share:(id)sender
{
    [UMSocialSnsService presentSnsIconSheetView:[UIApplication sharedApplication].keyWindow.rootViewController
                                         appKey:@"56d4f87ce0f55a194d00334b"
                                      shareText:@"欢迎来到玩儿社区~~~"
                                     shareImage:[UIImage imageNamed:@"AppIconShare28@2x"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToEmail,UMShareToWechatTimeline,UMShareToWhatsapp,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:self];
}



//举报
- (IBAction)report:(id)sender
{
//    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"举报" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"色情",@"广告",@"政治",@"其他", nil];
//    [sheet showInView:self.window];
    
    UIAlertController*actionSheet=[UIAlertController alertControllerWithTitle:@"举报"message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"政治" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
    }];
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"其他" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
    }];
    
    UIAlertAction *action4=[UIAlertAction actionWithTitle:@"广告" style:(UIAlertActionStyleDefault)handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
    } ];
    UIAlertAction *action5=[UIAlertAction actionWithTitle:@"色情" style:(UIAlertActionStyleDefault)handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showSuccessWithStatus:@"举报成功"];
    } ];
    [actionSheet addAction:action5];
    [actionSheet addAction:action4];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action1];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheet animated:YES completion:nil];

    
    
}

@end
