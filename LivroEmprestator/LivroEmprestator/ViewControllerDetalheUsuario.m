//
//  ViewControllerDetalheUsuario.m
//  LivroEmprestator
//
//  Created by ALUNO on 06/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerDetalheUsuario.h"
#import "CollectionViewControllerEstante.h"

@interface ViewControllerDetalheUsuario ()
@property (weak, nonatomic) IBOutlet UILabel *apelido;
@property (weak, nonatomic) IBOutlet UILabel *nome;

@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;

@end

@implementation ViewControllerDetalheUsuario

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_usuarioSelecionado!=nil){
        
        [self.apelido setText:_usuarioSelecionado.apelido];
        [self.nome setText:_usuarioSelecionado.nome];
    //    [self.idade setText:sss];
        [self.email setText:_usuarioSelecionado.email];
        
        
        UIImage *imagemUsuario = [UIImage imageWithData:_usuarioSelecionado.imagem];
        [self.imagem setImage: imagemUsuario];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mostrarEstante:(UIButton *)sender {
    [self performSegueWithIdentifier:@"estanteOutros" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"estanteOutros"] ){
 
        CollectionViewControllerEstante *destino = segue.destinationViewController;
        [destino setUsuarioSelecionado:_usuarioSelecionado];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
