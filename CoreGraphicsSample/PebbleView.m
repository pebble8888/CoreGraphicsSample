//
//  PebbleView.m
//  CoreGraphicsSample
//
//  Created by pebble8888 on 2015/07/03.
//  Copyright © 2015年 pebble8888. All rights reserved.
//

#import "PebbleView.h"

@implementation PebbleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self ){
        self.opaque = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef cx = UIGraphicsGetCurrentContext();
    
    const int method_count = 3;
    NSTimeInterval time[method_count];
    for( int method = 0; method < method_count; ++method ){
        NSDate* date = [NSDate date];
        const CGFloat diff = 1;
        switch( method ){
            case 0:
            {
                // 一つずつFillRectする
                CGContextSetFillColorWithColor(cx, [UIColor blueColor].CGColor);
                int i = 0;
                for( CGFloat x = rect.origin.x; x < rect.size.width; x+=diff ){
                    CGFloat y;
                    if( i % 2 ){
                        y = rect.size.height/2.0;
                    } else {
                        y = 0;
                    }
                    CGRect rc = CGRectMake(x, y, 1.0, rect.size.height-y);
                    CGContextFillRect(cx, rc);
                    ++i;
                }
            }
                break;
            case 1:
            {
                // AddRectしてから一回でFillPathする
                CGContextSetFillColorWithColor(cx, [UIColor blueColor].CGColor);
                int i = 0;
                for( CGFloat x = rect.origin.x; x < rect.size.width; x+=diff ){
                    CGFloat y;
                    if( i % 2 ){
                        y = rect.size.height/2.0;
                    } else {
                        y = 0;
                    }
                    CGContextAddRect(cx, CGRectMake(x, y, 1.0, rect.size.height-y));
                    ++i;
                }
                CGContextFillPath(cx);
            }
                break;
            case 2:
            {
                // 線で囲み、一回でFillPathする
                CGContextSetFillColorWithColor(cx, [UIColor blueColor].CGColor);
                
                CGContextMoveToPoint(cx, 0, rect.size.height);
                int i = 0;
                for( CGFloat x = rect.origin.x; x < rect.size.width; x+=diff ){
                    CGFloat y;
                    if( i % 2 ){
                        y = rect.size.height/2.0;
                    } else {
                        y = 0;
                    }
                    CGContextAddLineToPoint(cx, x, y);
                    ++i;
                }
                CGContextAddLineToPoint(cx, rect.size.width, rect.size.height);
                CGContextAddLineToPoint(cx, 0, rect.size.height);
                CGContextFillPath(cx);
            }
                break;
        }
        
        time[method] = [[NSDate date] timeIntervalSinceDate:date];
    }
    for( int method = 0; method < method_count; ++method ){
        NSLog( @"[%f]sec", time[method] );
    }
    // 2015-07-03 21:59:38.148 CoreGraphicsSample[930:264025] [0.085257]sec
    // 2015-07-03 21:59:38.149 CoreGraphicsSample[930:264025] [0.063396]sec // 3割高速化
    // 2015-07-03 21:59:38.149 CoreGraphicsSample[930:264025] [0.027716]sec // 3倍高速化
    
    
    // 0.016 sec = 1/60sec
    // 0.033 sec = 1/30sec
}

@end
