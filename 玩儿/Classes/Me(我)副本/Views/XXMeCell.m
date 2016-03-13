//
//  XXMeCell.m
//  玩儿
//
//  Created by 欢欢 on 16/2/27.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "XXMeCell.h"
#import "UIView+XXFrameExtension.h"
@implementation XXMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.image=[UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView=imageView;
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.imageView.image==nil)
    {
        return ;
    }
    self.imageView.width=25;
    self.imageView.x=5;
    self.imageView.height=self.imageView.width;
    self.imageView.centerY=self.contentView.height/2;
    self.textLabel.x=CGRectGetMaxX(self.imageView.frame)+5;
    
}
//-(void)setFrame:(CGRect)frame
//{
//    frame.origin.y -=25;
//    
//    [super setFrame:frame];
////    
//}

@end
