//
//  PASettingView.m
//  PaintCool
//
//  Created by iMac309 on 16.08.15.
//  Copyright (c) 2015 iMac309. All rights reserved.
//

#import "PASettingView.h"

@interface PASettingView()

#define CENTER_SQUARE_X 57
#define CENTER_SQUARE_Y 57

@end

@implementation PASettingView

- (void) drawLine: (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, rect.origin.x, 0);
    CGContextAddLineToPoint(context, rect.origin.x, rect.size.height);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
    
}
- (void) drawSquare: (CGRect) rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect square = CGRectMake(CGRectGetMinX(rect) + 5 , CGRectGetMinY(rect) + 450, 114, 114);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextAddRect(context, square);
    CGContextStrokePath(context);
}



- (void)drawRect:(CGRect)rect {
    [self drawLine:rect];
    //[self drawSquare:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rectengle = CGRectMake(CGRectGetMinX(rect) + 5 + CENTER_SQUARE_X - (self.weidthBrash/2),
                                  CGRectGetMinY(rect) + 450 + CENTER_SQUARE_Y - (self.weidthBrash/2),
                                  self.weidthBrash, self.weidthBrash);
    CGContextSetFillColorWithColor(context, [self.colorBrash CGColor]);
    CGContextSetAlpha(context, self.opacityBrash);
    CGContextAddEllipseInRect(context, rectengle);
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context,  [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 1.f);
    CGContextAddEllipseInRect(context, rectengle);
    CGContextStrokePath(context);
}


@end
