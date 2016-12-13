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
#import "Autor+CoreDataClass.h"
#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"



@interface ViewControllerDetalheLivro ()
@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UILabel *autor;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *resumo;
@property (weak, nonatomic) IBOutlet UIButton *btEuTenho;


@end

@implementation ViewControllerDetalheLivro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_livroSelecionado!=nil){
        
        [self.titulo setText:_livroSelecionado.titulo];
/*        [self.ano setText:_livroSelecionado.ano];
        [self.edicao setText:_livroSelecionado.edicao];
        [self.resumo setText:_livroSelecionado.resumo];*/
        NSSet *autores = _livroSelecionado.autor;
        Autor *autorObj;
        NSMutableString *concatenaAutores=[NSMutableString string];
        
        
        for(autorObj in autores){
            NSMutableString *mutableString = [autorObj.nome mutableCopy];
            [concatenaAutores appendString:mutableString ];
            [concatenaAutores appendString:@", " ];
        }
        [self.autor setText:concatenaAutores];
        [self.resumo setText:_livroSelecionado.resumo];
        
        
        
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
        
    }else if([segue.identifier isEqualToString:@"segueEstante"]){
        AppDelegate *delegate = (AppDelegate *)
        [[UIApplication sharedApplication]delegate];
        NSPersistentContainer *container = delegate.persistentContainer;
        NSManagedObjectContext *context = container.viewContext;
        NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
        
        NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
        
        Usuario *usuarioLogado = [context objectWithID:idSolicitante];
        
        [usuarioLogado addLivroObject:_livroSelecionado];
        self.btEuTenho.hidden=YES;
        
        NSError *erroCoreData;
        if(![context save:&erroCoreData]){
            NSLog(@"Deu Erro! %@" , erroCoreData);
        }else{
            NSLog(@"Livro vinculado ao usuario!");
        }

        
    }
    
}
- (IBAction)pegarEmprestado:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueLivroListaUsuarios" sender:sender];

}
- (IBAction)colocarEstante:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueEstante" sender:sender];
}

@end
