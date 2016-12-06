//
//  ViewControllerDetalheLivro.m
//  LivroEmprestator
//
//  Created by ALUNO on 22/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerDetalheLivro.h"
#import "Livro+CoreDataClass.h"
#import "TableViewControllerContatos.h"



@interface ViewControllerDetalheLivro ()
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *autor;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;


@end

@implementation ViewControllerDetalheLivro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_livroSelecionado!=nil){
        
        [self.titulo setText:_livroSelecionado.titulo];
/*        [self.ano setText:_livroSelecionado.ano];
        [self.edicao setText:_livroSelecionado.edicao];
        [self.resumo setText:_livroSelecionado.resumo];*/
        
        UIImage *imagemLivro = [UIImage imageWithData:_livroSelecionado.imagem];
        [self.imagem setImage: imagemLivro];
    }
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueLivroListaUsuarios"]){
        TableViewControllerContatos *destino = segue.destinationViewController;
        
        [destino setLivroSelecionado:_livroSelecionado];
        [destino setValor:@"pegarEmprestado"];
        
    }
}
- (IBAction)pegarEmprestado:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueLivroListaUsuarios" sender:sender];

}

@end
