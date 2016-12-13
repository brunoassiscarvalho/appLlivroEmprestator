//
//  ViewControllerIteracoes.m
//  LivroEmprestator
//
//  Created by ALUNO on 05/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerIteracoes.h"
#import "AppDelegate.h"
#import "Interacoes+CoreDataClass.h"
#import "Autor+CoreDataClass.h"


@interface ViewControllerIteracoes ()
@property (weak, nonatomic) IBOutlet UIImageView *livroImagem;
@property (weak, nonatomic) IBOutlet UILabel *livroTitulo;
@property (weak, nonatomic) IBOutlet UILabel *livroAutor;

@property (weak, nonatomic) IBOutlet UILabel *usuarioApelido;
@property (weak, nonatomic) IBOutlet UIImageView *usuarioImagem;
@property (weak, nonatomic) IBOutlet UIButton *btConfirmarIteracao;

@property (weak, nonatomic) IBOutlet UILabel *iteracaoRotulo;
@property Usuario *usuarioLogado;

@end

@implementation ViewControllerIteracoes

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
    
    NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
    
    self.usuarioLogado = [context objectWithID:idSolicitante];

    
    if(_iteracaoSelecionada!=nil){
        _livroSelecionado=_iteracaoSelecionada.livro;
        _usuarioSolicitado=_iteracaoSelecionada.usuarioSolicitado;
         _usuarioSolicitante=_iteracaoSelecionada.usuarioSolicitante;
        
        if(_usuarioSolicitante==self.usuarioLogado){
            if(_iteracaoSelecionada.tipoIteracao==1){
                [self.iteracaoRotulo setText:@"Você solicitou o emprestimo deste livro em:"];
                self.btConfirmarIteracao.hidden = YES;
            }else if(_iteracaoSelecionada.tipoIteracao==2){
                [self.iteracaoRotulo setText:@"A autorização do emprestimo foi feita em:"];
                
            }else if(_iteracaoSelecionada.tipoIteracao==3){
                [self.iteracaoRotulo setText:@"Você recebeu o livro em:"];
            }else if(_iteracaoSelecionada.tipoIteracao==4){
                [self.iteracaoRotulo setText:@"Seu emprestimo não foi autorizado:"];
                self.btConfirmarIteracao.hidden = YES;
            }else if(_iteracaoSelecionada.tipoIteracao==5){
                [self.iteracaoRotulo setText:@"Você pediu pra devolver o livro em:"];
            }else if(_iteracaoSelecionada.tipoIteracao==6){
                self.btConfirmarIteracao.hidden = YES;
                [self.iteracaoRotulo setText:@"Você devolveu o livro em:"];
            }
            
        
        }else if(_usuarioSolicitado==self.usuarioLogado){
            if(_iteracaoSelecionada.tipoIteracao==1){
                [self.iteracaoRotulo setText:@"Foi solicitado o emprestimo em:"];
            }else if(_iteracaoSelecionada.tipoIteracao==2){
                
                 self.btConfirmarIteracao.hidden = YES;
                [self.iteracaoRotulo setText:@"Você autorizou o emprestimo em:"];
               
                
            }else if(_iteracaoSelecionada.tipoIteracao==3){
                
                [self.iteracaoRotulo setText:@"Você entregou o livro em:"];
                
            }else if(_iteracaoSelecionada.tipoIteracao==4){
                self.btConfirmarIteracao.hidden = YES;
                [self.iteracaoRotulo setText:@"Você não autorizou o emprestimo em:"];
                
            }else if(_iteracaoSelecionada.tipoIteracao==5){
                self.btConfirmarIteracao.hidden = YES;
                [self.iteracaoRotulo setText:@"Foi solicitada a devolução do livro em:"];
                
            }else if(_iteracaoSelecionada.tipoIteracao==6){
                [self.iteracaoRotulo setText:@"Você recebeu o livro em:"];
            }
            
            
        }
    }
    
    [self.livroTitulo setText:_livroSelecionado.titulo];
    
    UIImage *imagemLivro = [UIImage imageWithData:_livroSelecionado.imagem];
    [self.livroImagem setImage:imagemLivro];
    
    [self.usuarioApelido setText:_usuarioSolicitado.apelido];
    UIImage *imagemUsuario = [UIImage imageWithData:_usuarioSolicitado.imagem];
    [self.usuarioImagem setImage:imagemUsuario];
    
    NSSet *autores = _livroSelecionado.autor;
    Autor *autor;
    NSMutableString *concatenaAutores=[NSMutableString string];
    
    
    for(autor in autores){
        NSMutableString *mutableString = [autor.nome mutableCopy];
        [concatenaAutores appendString:mutableString ];
        [concatenaAutores appendString:@", " ];
    }
    [self.livroAutor setText:concatenaAutores];
    
    
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
- (IBAction)botaoConfirmar:(UIButton *)sender {
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
       Interacoes *interacao;
    
    NSDate *currDate = [NSDate date];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
    if(_iteracaoSelecionada==nil){
        interacao = [NSEntityDescription insertNewObjectForEntityForName:@"Interacoes" inManagedObjectContext:context];
        [interacao setLivro:_livroSelecionado];
        [interacao setUsuarioSolicitado:_usuarioSolicitado];
        [interacao setUsuarioSolicitante:self.usuarioLogado];
        [interacao setTipoIteracao:1];
         self.btConfirmarIteracao.hidden = YES;
        [self.iteracaoRotulo setText:@"solicitado emprestimo"];
       
        _iteracaoSelecionada = interacao;
        
    }else{
        
        //iteracoes
        /*
         1- solicitante - solicita livro
         2- Solicitado - aceita solicitacao
         3 - Solicitante - confirma recebimento
         4 - solicitado - Recusa solicitacao
         5 - Solicitante - Aponta devolucao
         6 - Solicitado - Confirma devolucao
         
         */
        if(_usuarioSolicitante==self.usuarioLogado){
            if(_iteracaoSelecionada.tipoIteracao==2){
                //confirma recebimento do livro
                [_iteracaoSelecionada setTipoIteracao:3];
                [interacao setTimestamp:currDate];
            }else if(_iteracaoSelecionada.tipoIteracao==3){
                //aponta devolucao
                [_iteracaoSelecionada setTipoIteracao:5];
                [interacao setTimestamp:currDate];
            }
        }else if(_usuarioSolicitado==self.usuarioLogado){
            if(_iteracaoSelecionada.tipoIteracao==1){
                //aceita solicitacao
                [_iteracaoSelecionada setTipoIteracao:2];
                [interacao setTimestamp:currDate];
            }else if(_iteracaoSelecionada.tipoIteracao==5){
                //confirma devolucao
                [_iteracaoSelecionada setTipoIteracao:6];
                [interacao setTimestamp:currDate];
            }
        }
    }
    
    
/*    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *data = [formatter dateFromString:self.dataNascimento.text];*/
    
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Erro ao salvar INTERACAO: %@" , erroCoreData);
    }else{
        NSLog(@"Interação Incluida");
    }
    
}

@end
