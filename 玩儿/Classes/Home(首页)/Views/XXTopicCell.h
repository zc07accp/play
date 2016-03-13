//
//  XXTopicCell.h
//  玩儿
//
//  Created by 欢欢 on 16/2/18.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@class XXTiezi;

@interface XXTopicCell : UITableViewCell

//帖子数据
@property(nonatomic,strong)XXTiezi *topic;
@property(nonatomic,assign)NSInteger index;
+(instancetype)cell;

@end
