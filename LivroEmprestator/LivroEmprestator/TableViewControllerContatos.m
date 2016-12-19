//
//  TableViewControllerContatos.m
//  LivroEmprestator
//
//  Created by ALUNO on 16/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewControllerContatos.h"
#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"
#import "TableViewCellContato.h"
#import "ViewControllerIteracoes.h"
#import "ViewControllerDetalheUsuario.h"

@interface TableViewControllerContatos () <NSURLSessionDataDelegate,NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong , nonatomic) NSMutableData * bytesResposta;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property Usuario *usuarioLogado;


@end

@implementation TableViewControllerContatos

- (void)viewDidLoad {
    [super viewDidLoad];
    _bytesResposta = [NSMutableData new];
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
    
    NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
    
    self.usuarioLogado = [context objectWithID:idSolicitante];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    NSError *erro;
    if (![self.fetchedResultsController performFetch:&erro]) {
        NSLog(@"Erro ao recuperar pessoas: %@", erro);
    }else {
        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NSURLSessionDataDelegate





- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSPersistentContainer *persistentContainer = delegate.persistentContainer;
        
        NSFetchRequest *fetchRequest = [Usuario fetchRequest];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"apelido != %@", self.usuarioLogado.apelido]];
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"apelido" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:persistentContainer.viewContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        [_fetchedResultsController setDelegate:self];
    }
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCellContato" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TableViewCellContato"];
    
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
return self.fetchedResultsController.sections.count;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger linhas;
    if(_livroSelecionado!=nil){
        linhas = _livroSelecionado.usuario.count;
    }else{
         linhas= [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
    }
    
   
return linhas;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celulaLivro"
     forIndexPath:indexPath];*/
    TableViewCellContato *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellContato" forIndexPath:indexPath];
    [self configurarCelula:cell noIndexPath:indexPath];
    return cell;
}

- (void) configurarCelula: (TableViewCellContato *) cell noIndexPath: (NSIndexPath *) indexPath {
    Usuario *contato;
    if(_livroSelecionado!=nil){
        
        NSSet *usuarioQueTemEsteLivro = _livroSelecionado.usuario;
        if(usuarioQueTemEsteLivro != nil){
            NSArray *myArray = [usuarioQueTemEsteLivro allObjects];
            
            contato = [myArray objectAtIndex:(indexPath.row)];
        }
        
        
    }else{
        contato =[self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    if(contato!=nil){
        UIImage *imagem = [UIImage imageWithData:contato.imagem];
        [cell preencherComApelido:contato.apelido comImagem:imagem];
    }
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Celula Selecionada: %@", indexPath);
    if([_valor isEqualToString:@"pegarEmprestado"]){
        [self performSegueWithIdentifier:@"confirmarInteracao" sender:self];
    }else{
        [self performSegueWithIdentifier:@"detalheUsuario" sender:self];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"confirmarInteracao"] ){
        NSSet *usuarioQueTemEsteLivro = _livroSelecionado.usuario;
        NSIndexPath *indexPath = [_listaUsuarios indexPathForSelectedRow];
        NSArray *myArray = [usuarioQueTemEsteLivro allObjects];
        Usuario *usuarioIteracao = [myArray objectAtIndex:(indexPath.row)];
        //Usuario *usuarioIteracao = [self.fetchedResultsController objectAtIndexPath:indexPath];
        Livro *livroIteracao = _livroSelecionado;
        ViewControllerIteracoes  *destino = segue.destinationViewController;
        [destino setLivroSelecionado:livroIteracao];
        [destino setUsuarioSolicitado:usuarioIteracao];
    }else if([segue.identifier isEqualToString:@"detalheUsuario"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Usuario *usuario = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        ViewControllerDetalheUsuario  *destino = segue.destinationViewController;
        [destino setUsuarioSelecionado:usuario];
    }
}

@end
