//
//  IncrivelBehavior.m
//  Quadrados
//
//  Created by ALUNO on 21/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "IncrivelBehavior.h"

@interface IncrivelBehavior ()
@property (strong, nonatomic, readonly) UIGravityBehavior *gravidade;
@property (strong, nonatomic, readonly) UICollisionBehavior *colisao;



@end

@implementation IncrivelBehavior
@synthesize gravidade = _gravidade;
@synthesize colisao = _colisao;



//Override do inicializador padrão
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addChildBehavior:self.gravidade];
        [self addChildBehavior:self.colisao];
    }
    return self;
}

//Lazy load da propriedade (ela é readonly por conta disso!)
- (UIGravityBehavior *)gravidade {
    if (!_gravidade) {
        _gravidade = [[UIGravityBehavior alloc] init];
        [_gravidade setMagnitude:0.7];
    }
    return _gravidade;
}

//Lazy load da propriedade (ela é readonly por conta disso!)
- (UICollisionBehavior *)colisao {
    if (!_colisao) {
        _colisao = [[UICollisionBehavior alloc] init];
        [_colisao setTranslatesReferenceBoundsIntoBoundary:YES]; //faz com que as "paredes" da view sirvam para a colisão
    }
    return _colisao;
}


- (void) adicionarItem: (id<UIDynamicItem>) item {
    [self.gravidade addItem:item];
    [self.colisao addItem:item];
   // [self.elastico addItem:item];
    
}
- (void) removerItem: (id<UIDynamicItem>) item {
    [self.gravidade removeItem:item];
    [self.colisao removeItem:item];
 //   [self.elastico removeItem:item];
}



@end