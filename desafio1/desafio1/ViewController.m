//
//  ViewController.m
//  desafio1
//
//  Created by ALUNO on 26/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerSegundaTela.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nome;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)proximo:(UIButton *)sender {
    
}

- (IBAction) unwindDaSegundaParaPrimeira: (UIStoryboardSegue *) segue {
    ViewControllerSegundaTela *origem = segue.sourceViewController;
    [self.nome setText:origem.nomeAlterado];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"primeiraParaSegundaSegue"]) {
        NSString *valor = self.nome.text;
        ViewControllerSegundaTela *destino = segue.destinationViewController;
        [destino setNomeAlterado:valor];
    }
}

@end
