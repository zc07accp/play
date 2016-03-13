//
//  XXTiezi.m
//  玩儿
//
//  Created by 欢欢 on 16/2/20.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXTiezi.h"
#import "MJExtension.h"
#import "XXComment.h"
#import "XXUser.h"
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
//男性
#define XXUserSexM @"m"
//女性
#define XXUserSexF @"f"

#define  XXScreenW [UIScreen mainScreen].bounds.size.width
#define  XXScreenH [UIScreen mainScreen].bounds.size.height


@implementation XXTiezi

//自动替换
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image":@"image0",
             @"middle_image":@"image2",
             @"large_image":@"image1",
             @"ID":@"id"
             };
}
+(NSDictionary *)mj_objectClassInArray{
    
    
    return @{@"top_cmt":@"XXComment"};
}
-(CGFloat)cellHeight
{
    if(!_cellHeight)
    {
        //计算cell的高度
        CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-4*XXTopicCellMargin, CGFLOAT_MAX);
        
        CGFloat textH=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
        _cellHeight=XXTopicCellTextY+textH+XXTopicCellMargin;
    
        //如果帖子类型为图片
        if(self.type==XXTopicTypePicture)
        {
            //图片显示的宽度
            CGFloat pictureW=maxSize.width;
            //图片显示的高度
            CGFloat pictureH=pictureW *self.height/self.width;
            if(pictureH>=XXTopCellPictureMaxH)
            {
                self.bigPicture=YES;
            }
            //计算图片控件的frame
            CGFloat pictureX=XXTopicCellMargin;
            CGFloat pictureY=XXTopicCellTextY+textH+XXTopicCellMargin;
            _pictureViewFrame=CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight +=pictureH+XXTopicCellMargin;
            }
        //计算声音帖子的frame
           else if (self.type==XXTopicTypeVoice)
           {
               CGFloat voiceX= XXTopicCellMargin;
               CGFloat voiceY= XXTopicCellTextY+textH+XXTopicCellMargin;
               CGFloat voiceW= maxSize.width;
               CGFloat voiceH=voiceW *self.height/self.width ;
               _voiceViewFrame=CGRectMake(voiceX, voiceY, voiceW, voiceH);
               _cellHeight +=voiceH+XXTopicCellMargin;
               
            }
        //计算视频帖子的frame
        else if (self.type==XXTopicTypeVideo)
        {
            CGFloat voiceX= XXTopicCellMargin;
            CGFloat voiceY= XXTopicCellTextY+textH+XXTopicCellMargin;
            CGFloat voiceW= maxSize.width;
            CGFloat voiceH=voiceW *self.height/self.width ;
            _videoViewFrame=CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight +=voiceH+XXTopicCellMargin;
        }
        XXComment *cmt=[self.top_cmt firstObject];
        //如果有最热评论算一下cell的高
        if(cmt)
        {
            NSString *content=[NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
            CGFloat contentH=[content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight +=10+contentH+XXTopicCellMargin;
        }
        //底部工具条的高度
        _cellHeight +=XXTopicCellBottomBarH+XXTopicCellMargin ;
    }
    
    return _cellHeight;
    
}



@end
