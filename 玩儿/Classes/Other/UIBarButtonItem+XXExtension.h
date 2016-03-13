//
//  UIBarButtonItem+XXExtension.h
//  玩儿
//
//  Created by 欢欢 on 16/2/16.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XXExtension)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
