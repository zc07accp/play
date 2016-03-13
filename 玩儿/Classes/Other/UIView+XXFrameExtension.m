//
//  UIView+XXFrameExtension.m
//  玩儿
//
//  Created by 欢欢 on 16/2/21.
//  Copyright © 2016年 欢欢. All rights reserved.
//

#import "UIView+XXFrameExtension.h"

@implementation UIView (XXFrameExtension)
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
-(BOOL)isShowingOnKeyWindow
{
    //主窗口
    UIWindow *keywindow=[UIApplication sharedApplication].keyWindow;
    //以主窗口左上角为原点，计算self的矩形框
    CGRect newFrame =[keywindow convertRect:self.frame fromView:self.superview];
    CGRect windowBounds=[UIApplication sharedApplication].keyWindow.bounds;
    //主窗口的bounds和self的矩形框是否有重叠
    BOOL intersects=CGRectIntersectsRect(newFrame, windowBounds);
    return !self.hidden&&self.alpha>0.01&&self.window==keywindow&&intersects;
    
    
}
@end
