//
//  ViewControllerDetalheUsuario.m
//  LivroEmprestator
//
//  Created by ALUNO on 06/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerDetalheUsuario.h"
#import "CollectionViewControllerEstante.h"
#import "AppDelegate.h"


@interface ViewControllerDetalheUsuario ()<NSURLSessionDataDelegate,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *apelido;
@property (weak, nonatomic) IBOutlet UILabel *nome;

@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UIButton *btNao;
@property (weak, nonatomic) IBOutlet UIButton *btSim;
@property (weak, nonatomic) IBOutlet UIButton *btEstante;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirmacao;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

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
    if(_excluindo){
        [self.btNao setHidden:NO];
        [self.btSim setHidden:NO];
        [self.btEstante setHidden:YES];
        [self.lblConfirmacao setHidden:NO];
    
    }
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSPersistentContainer *persistentContainer = delegate.persistentContainer;
        
        NSFetchRequest *fetchRequest = [Usuario fetchRequest];
      
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"apelido" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:persistentContainer.viewContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        [_fetchedResultsController setDelegate:self];
    }
    

    
    return _fetchedResultsController;
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

- (IBAction)excluirCadastro:(UIButton *)sender {
    
    [self.fetchedResultsController.managedObjectContext deleteObject:_usuarioSelecionado];
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;

    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Erro ao excluir Cadastro: %@" , erroCoreData);
    }else{
        NSLog(@"Cadastro excluido");
        [self dismissViewControllerAnimated:YES completion:nil];
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
