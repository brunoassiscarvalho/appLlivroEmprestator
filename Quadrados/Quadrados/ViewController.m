//
//  ViewController.m
//  Quadrados
//
//  Created by ALUNO on 21/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"

#import "IncrivelBehavior.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *tabuleiro;

@property (strong, nonatomic, readonly) UIDynamicAnimator *animator;
@property (strong, nonatomic, readonly) IncrivelBehavior *cairBehavior; //Nossa subclasse de UIDynamicBehavior

@property (strong, nonatomic) NSMutableArray *quadradinhos;
@property (strong, nonatomic, readonly) UISnapBehavior *elastico;


@end

@implementation ViewController
@synthesize animator = _animator;
@synthesize cairBehavior = _cairBehavior;
@synthesize elastico = _elastico;


static const CGSize TAMANHO_DO_QUADRADO = { 40, 40 };

#pragma mark - Lazy Load das Propriedades

//Lazy load da propriedade (ela é readonly por conta disso!)
- (IncrivelBehavior *)cairBehavior {
    if (!_cairBehavior) {
        _cairBehavior = [[IncrivelBehavior alloc] init];
        [self.animator addBehavior:_cairBehavior];
    }
    return _cairBehavior;
}

//Lazy load da propriedade (ela é readonly por conta disso!)
- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.tabuleiro];
        [_animator setDelegate:self];
    }
    return _animator;
}


#pragma mark - Ciclo de Vida

- (void)viewDidLoad {
    [super viewDidLoad];
    _quadradinhos = [NSMutableArray new];
   
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (IBAction)quadrado:(UIButton *)sender {
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = TAMANHO_DO_QUADRADO;
    
    
    int x = (arc4random()%(int)self.tabuleiro.bounds.size.width) / TAMANHO_DO_QUADRADO.width; //Cálculo para determinar onde o quadrado vai surgir
    frame.origin.x = x * TAMANHO_DO_QUADRADO.width;
    
    UIView *quadradinho = [[UIView alloc] initWithFrame:frame];
    [quadradinho setBackgroundColor:[self gerarCorAleatoria]];
    
    [self.tabuleiro addSubview:quadradinho];
    [self.cairBehavior adicionarItem:quadradinho];
    [self.quadradinhos addObject:quadradinho];
}

- (IBAction)explodir:(UIButton *)sender {
    if ([self.quadradinhos count]) {
        for (UIView *q in self.quadradinhos) {
            [self.cairBehavior removerItem:q];
        }
        [UIView animateWithDuration:2.0
                         animations:^{
                             for (UIView *q in self.quadradinhos) {
                                 int x = (arc4random()%(int)(self.tabuleiro.bounds.size.width*5)) - (int)self.tabuleiro.bounds.size.width*2;
                                 int y = self.tabuleiro.bounds.size.height;
                                 q.center = CGPointMake(x, -y);
                             }
                         }
                         completion:^(BOOL finished) {
                             [self.quadradinhos makeObjectsPerformSelector:@selector(removeFromSuperview)];
                         }];
    }
}

#pragma mark - Lógica

- (UIColor *)gerarCorAleatoria { //agora sim
    
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    
    return [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    
}

- (IBAction)tapCriarBotao:(id)sender {
    CGRect frame;
    CGPoint currentPos = [sender locationInView:self.view];
    frame.origin = currentPos;
    frame.size = TAMANHO_DO_QUADRADO;
    
    UIView *quadradinho = [[UIView alloc] initWithFrame:frame];
    [quadradinho setBackgroundColor:[self gerarCorAleatoria]];
    
    [self.tabuleiro addSubview:quadradinho];
    [self.cairBehavior adicionarItem:quadradinho];
    [self.quadradinhos addObject:quadradinho];
}
-(UISnapBehavior *) elastico {
    if (!_elastico) {
       // UISnapBehavior *snapBackBehavior = [[UISnapBehavior alloc] initWithItem:_elastico snapToPoint:_elastico];
        [ _elastico setDamping:2.0f ]; //faz com que as "paredes" da view sirvam de amortecedor
    }
    return _elastico;
}



@end
