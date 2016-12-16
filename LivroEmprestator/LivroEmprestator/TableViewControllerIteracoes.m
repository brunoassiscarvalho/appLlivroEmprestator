//
//  TableViewControllerIteracoes.m
//  LivroEmprestator
//
//  Created by ALUNO on 22/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewControllerIteracoes.h"
#import "AppDelegate.h"
#import "TableViewCellInteracoes.h"
#import "Interacoes+CoreDataClass.h"
#import "Livro+CoreDataClass.h"
#import "Usuario+CoreDataClass.h"
#import "ViewControllerIteracoes.h"

@interface TableViewControllerIteracoes () <NSURLSessionDataDelegate, NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property Usuario *usuarioLogado;
@property (strong, nonatomic) NSMutableArray<Interacoes*> *arrayIteracoes;

@end

@implementation TableViewControllerIteracoes

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
    
    NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
    
    self.usuarioLogado = [context objectWithID:idSolicitante];
    
    NSSet *usuarioSolicitado = _usuarioLogado.iteracoesSolicitado;
    NSSet *usuarioSolicitante = _usuarioLogado.iteracoesSolicitante;
    
    
    
    
    if(usuarioSolicitado != nil){
        [ self.arrayIteracoes addObjectsFromArray: [usuarioSolicitado allObjects]];
        // contato = [myArray objectAtIndex:(indexPath.row)];
    }
   
    NSSet *usuarioSolicitantes = _usuarioLogado.iteracoesSolicitante;
    if(usuarioSolicitantes != nil){
       [self.arrayIteracoes addObjectsFromArray: [usuarioSolicitante allObjects]];
        // contato = [myArray objectAtIndex:(indexPath.row)];
    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSPersistentContainer *persistentContainer = delegate.persistentContainer;
        
        NSFetchRequest *fetchRequest = [Interacoes fetchRequest];
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:persistentContainer.viewContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        [_fetchedResultsController setDelegate:self];
    }
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCellInteracoes" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TableViewCellInteracoes"];
    
    return _fetchedResultsController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSError *erro;
    if (![self.fetchedResultsController performFetch:&erro]) {
        NSLog(@"Erro ao recuperar interações: %@", erro);
        
    }else {
        [self.tableView reloadData];
    }
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayIteracoes.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celulaLivro"
     forIndexPath:indexPath];*/
    TableViewCellInteracoes *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellInteracoes" forIndexPath:indexPath];
    [self configurarCelula:cell noIndexPath:indexPath];
    return cell;
}

- (void) configurarCelula: (TableViewCellInteracoes*) cell noIndexPath: (NSIndexPath *) indexPath {
    
    Interacoes *iteracao = [self.arrayIteracoes objectAtIndex:indexPath.row];
    Livro *livroIteracao =iteracao.livro;
    Usuario *solicitado =iteracao.usuarioSolicitado;

    UIImage *imagemLivro = [UIImage imageWithData: livroIteracao.imagem];
    UIImage *imagemSolicitado = [UIImage imageWithData: solicitado.imagem];

    [cell mostrarImagemUsuario:imagemSolicitado imagemLivro:imagemLivro];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Celula Selecionada: %@", indexPath);
    [self performSegueWithIdentifier:@"segueDetalheIteracao" sender:self];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueDetalheIteracao"] ){
        NSIndexPath *indexPath = [_listaIteracoes indexPathForSelectedRow];
        Interacoes *iteracao = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ViewControllerIteracoes  *destino = segue.destinationViewController;
        [destino setIteracaoSelecionada:iteracao];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200; //retornar aqui a altura estimada da célula... olhe no XIB a altura.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension; //isso faz a tableView aceitar células com alturas dinâmicas
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
