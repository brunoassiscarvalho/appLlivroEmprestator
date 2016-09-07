//
//  ViewCirculo.m
//  LivroEmprestator
//
//  Created by hc05mac29 on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewCirculo.h"

@implementation ViewCirculo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(100, 100)
                    radius:50.0
                    startAngle:0.0
                    endAngle:2.0 * M_PI
                    clockwise:NO];
    
    UIColor *verde = [UIColor colorWithRed:10.0/255.0
                                     green:100.0/255.0
                                      blue:10.0/255.0
                                     alpha:1];
    
    
    UIColor *preto = [UIColor blackColor];
    
    [verde setFill];
    [preto setStroke];
    
    [path fill];
    [path stroke];
    
}

@end
