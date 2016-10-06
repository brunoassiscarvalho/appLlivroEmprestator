//
//  ViewPentagono.m
//  LivroEmprestator
//
//  Created by hc05mac29 on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewPentagono.h"

@implementation ViewPentagono

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configurar];
    }
    return self;
}

- (void) configurar {
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath new];
    
    NSInteger rMaior = 75;
    //NSInteger  rMenor = 45;
    NSInteger quantidadePontas =5;
    float passo= 360/quantidadePontas;
    float angulo=54;
    
    // Converte de polar para Cartesiano
    float x1 = rMaior * cos(angulo/ 180 * M_PI);
    float y1 = rMaior * sin(angulo/ 180 * M_PI);
    
    //float x2 = 0;
    //float y2 = 0;
    
    [path moveToPoint:CGPointMake(x1+100, y1+100)];
    
    for(int i =0 ; i<= quantidadePontas-2 ; i++){
        
        //angulo+=passo;
       // x2 = rMenor * cos(angulo/ 180 * M_PI);
       // y2 = rMenor * sin(angulo/ 180 * M_PI);
      //  [path addLineToPoint:CGPointMake(x2+100, y2+100)];
        
        angulo+=passo;
        x1 = rMaior * cos(angulo/ 180 * M_PI);
        y1 = rMaior * sin(angulo/ 180 * M_PI);
        [path addLineToPoint:CGPointMake(x1+100, y1+100)];
    }
    
    //angulo+=passo;
    
   // x2 = rMenor * cos(angulo/ 180 * M_PI);
   // y2 = rMenor * sin(angulo/ 180 * M_PI);
   // [path addLineToPoint:CGPointMake(x2+100, y2+100)];
    
    [path closePath];
    
    UIColor *verde = [UIColor colorWithRed:10.0/255.0
                                     green:100.0/255.0
                                      blue:10.0/255.0
                                     alpha:1];
    
    
    UIColor *preto = [UIColor blackColor];
    
    [verde setFill];
    [preto setStroke];
    
    [path fill];
    [path stroke];
    /*
     CGRect frame = CGRectMake(72,65,200, 20);
     UILabel *nome = [[UILabel alloc] initWithFrame:frame];
     nome.text = @"BRUNO";
     nome.textColor = [UIColor redColor];
     [nome setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
     [self addSubview:nome];
     
     UIImage *imageObject = [UIImage imageNamed:@"YinYang"];
     [imageObject drawInRect:CGRectMake(75,85, 50, 50)];*/
    
}

@end
