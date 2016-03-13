//
//  XXPictureView.m
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXPictureView.h"
#import "XXTiezi.h"
#import "UIImageView+WebCache.h"
@interface XXPictureView()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//gif标志
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
//查看大图按钮
@property (weak, nonatomic) IBOutlet UIButton *seeButton;



@end
@implementation XXPictureView

-(void)awakeFromNib
{
    
    self.autoresizingMask=UIViewAutoresizingNone;
    
}
+(instancetype)pictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"XXPictureView" owner:nil options:nil]lastObject];
    
    
}
-(void)setTopic:(XXTiezi *)topic
{
    _topic=topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //判断是否为gif图片
    NSString *extension=topic.large_image.pathExtension;
    self.gifView.hidden=![extension.lowercaseString isEqualToString:@"gif"];
    //判断是否显示大图
    self.seeButton.hidden=YES;
    
   


}
@end
