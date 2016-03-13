//
//  UIView+XXFrameExtension.h
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XXFrameExtension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
//判断一个控件是否真正显示在主窗口
-(BOOL)isShowingOnKeyWindow;
@end
