//
//  ViewControllerIteracoes.m
//  LivroEmprestator
//
//  Created by ALUNO on 05/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerIteracoes.h"


@interface ViewControllerIteracoes ()
@property (weak, nonatomic) IBOutlet UIImageView *livroImagem;
@property (weak, nonatomic) IBOutlet UILabel *livroTitulo;
@property (weak, nonatomic) IBOutlet UILabel *livroAutor;

@property (weak, nonatomic) IBOutlet UILabel *usuarioApelido;
@property (weak, nonatomic) IBOutlet UIImageView *usuarioImagem;

@property (weak, nonatomic) IBOutlet UILabel *iteracaoRotulo;

@end

@implementation ViewControllerIteracoes

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.livroTitulo setText:_livroSelecionado.titulo];
    
    UIImage *imagemLivro = [UIImage imageWithData:_livroSelecionado.imagem];
    [self.livroImagem setImage:imagemLivro];
    
    [self.usuarioApelido setText:_usuarioSolicitado.apelido];
    UIImage *imagemUsuario = [UIImage imageWithData:_usuarioSolicitado.imagem];
    [self.usuarioImagem setImage:imagemUsuario];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
