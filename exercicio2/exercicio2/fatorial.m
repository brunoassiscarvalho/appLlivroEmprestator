//
//  fatorial.m
//  exercicio2
//
//  Created by ALUNO on 28/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "fatorial.h"

@implementation fatorial

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(float)factorial:(float)number1 {
    return tgammaf(++number1);
}

@end
