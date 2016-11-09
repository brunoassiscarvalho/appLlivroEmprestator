//
//  ViewControllerLivro.m
//  LivroEmprestator
//
//  Created by ALUNO on 01/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerLivro.h"
#import "AppDelegate.h"
#import "Livro+CoreDataClass.h"

@interface ViewControllerLivro ()
@property (weak, nonatomic) IBOutlet UITextField *titulo;
@property (weak, nonatomic) IBOutlet UITextField *ano;
@property (weak, nonatomic) IBOutlet UITextField *edicao;
@property (weak, nonatomic) IBOutlet UITextField *resumo;


@end

@implementation ViewControllerLivro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_livroSelecionado!=nil){
       
        [self.titulo setText:_livroSelecionado.titulo];
        [self.ano setText:_livroSelecionado.ano];
        [self.edicao setText:_livroSelecionado.edicao];
        [self.resumo setText:_livroSelecionado.resumo];
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

-(void) salvaLivro{
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    Livro *livro =nil;
    if(_livroSelecionado!=nil){
        livro = _livroSelecionado;
    }else{
        livro = [NSEntityDescription insertNewObjectForEntityForName:@"Livro" inManagedObjectContext:context];
    }
    
    [livro setTitulo:self.titulo.text];
    [livro setAno:self.ano.text];
    [livro setResumo:self.resumo.text];
    [livro setEdicao:self.edicao.text];
    
    
    
    
    _livroSelecionado=nil;
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Deu Erro! %@" , erroCoreData);
    }else{
        NSLog(@"Produto incluido com sucesso!");
    }
    
}

- (IBAction)salvarLivro:(UIButton *)sender {
    [ self salvaLivro ];
}
- (IBAction)excluirLivro:(UIButton *)sender {
    [self excluiLivro];
}

-(void)excluiLivro{
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    [context  deleteObject:_livroSelecionado];
    _livroSelecionado=nil;
    NSError *erroCoreData;
    if (![context  save:&erroCoreData]) {
        NSLog(@"Deu erro: %@", erroCoreData);
    }
}

@end
