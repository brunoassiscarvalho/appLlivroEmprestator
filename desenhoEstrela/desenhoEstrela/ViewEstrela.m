//
//  ViewEstrela.m
//  desenhoEstrela
//
//  Created by ALUNO on 24/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewEstrela.h"

@implementation ViewEstrela

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
    NSInteger  rMenor = 50;
    NSInteger quantidadePontas =6 ;
    float passo= 360/(quantidadePontas*2);
    float angulo= 0;
    
    // Converte de polar para Cartesiano
    float x1 = rMaior * cos(angulo);
    float y1 = rMaior * sin(angulo);
    
    [path moveToPoint:CGPointMake(x1+100, y1+100)];
   
    for(int i =0 ; i<= quantidadePontas ; i++){
       
        
        angulo+=passo;
        
        float x2 = rMenor * cos(angulo);
        float y2 = rMenor * sin(angulo);
        
        [path addLineToPoint:CGPointMake(x2+100, y2+100)];
        
        
        angulo+=passo;
        x1 = rMaior * cos(angulo);
        y1 = rMaior * sin(angulo);
        
        
        [path addLineToPoint:CGPointMake(x1+100, y1+100)];
        

      //[path moveToPoint:CGPointMake(0, 10)];
        
    }
    [path closePath];
    
    
    
    
    //10, 200, 10
    
    
    UIColor *verdeDoFelipe = [UIColor colorWithRed:10.0/255.0
                                             green:200.0/255.0
                                              blue:10.0/255.0
                                             alpha:1];
    
    
    UIColor *outraCor = [UIColor magentaColor];
    
    [verdeDoFelipe setFill];
    [outraCor setStroke];
    
    [path fill];
    [path stroke];
}

//- (void)drawRect:(CGRect)rect {
//    UIBezierPath *path = [UIBezierPath new];
//    
//    [path moveToPoint:CGPointMake(75, 10)];
//    [path addLineToPoint:CGPointMake(160, 150)];
//    [path addLineToPoint:CGPointMake(10, 150)];
//    [path closePath];
//    
//    
//    //10, 200, 10
//    
//    
//    UIColor *verdeDoFelipe = [UIColor colorWithRed:10.0/255.0
//                                             green:200.0/255.0
//                                              blue:10.0/255.0
//                                             alpha:1];
//    
//    
//    UIColor *outraCor = [UIColor magentaColor];
//    
//    [verdeDoFelipe setFill];
//    [outraCor setStroke];
//    
//    [path fill];
//    [path stroke];
//}



@end
