//
//  TableViewControllerListaLivros.m
//  LivroEmprestator
//
//  Created by ALUNO on 07/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewControllerListaLivros.h"
#import "AppDelegate.h"
#import "Livro+CoreDataClass.h"
#import "ViewControllerLivro.h"
#import "TableViewCellLivro.h"
#import "ViewControllerDetalheLivro.h"

@interface TableViewControllerListaLivros () <NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation TableViewControllerListaLivros

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSPersistentContainer *persistentContainer = delegate.persistentContainer;
        
        NSFetchRequest *fetchRequest = [Livro fetchRequest];
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"titulo" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:persistentContainer.viewContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        [_fetchedResultsController setDelegate:self];
    }
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCellLivro" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TableViewCellLivro"];
    
    return _fetchedResultsController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  /*  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celulaLivro"
                                                            forIndexPath:indexPath];*/
    TableViewCellLivro *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellLivro" forIndexPath:indexPath];
    [self configurarCelula:cell noIndexPath:indexPath];
    return cell;
}

- (void) configurarCelula: (TableViewCellLivro *) cell noIndexPath: (NSIndexPath *) indexPath {
    Livro *livro = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // NSInteger numeroIndice = indexPath.row;
    // NSString *integerAsString = [NSString stringWithFormat: @"%ld", (long)numeroIndice];
    //Para converter NSdata para imagem
    UIImage *imagem = [UIImage imageWithData:livro.imagem];
    [cell preencherComTitulo:livro.titulo autor:@"implementar" imagem:imagem];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Celula Selecionada: %@", indexPath);
    [self performSegueWithIdentifier:@"segueListaLivrosDetalhe" sender:self];
   
}




/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueEditaLivro"]){
        NSIndexPath *indexPath = [_tabelaMeusLivros indexPathForSelectedRow];
        Livro *livro = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ViewControllerLivro  *destino = segue.destinationViewController;
        [destino setLivroSelecionado:livro];
    
    }
}*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueListaLivrosDetalhe"] || [segue.identifier isEqualToString:@"segueEditaLivro"]){
        NSIndexPath *indexPath = [_tabelaMeusLivros indexPathForSelectedRow];
        Livro *livro = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ViewControllerDetalheLivro  *destino = segue.destinationViewController;
        [destino setLivroSelecionado:livro];
        
    }
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 525; //retornar aqui a altura estimada da célula... olhe no XIB a altura.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension; //isso faz a tableView aceitar células com alturas dinâmicas
}



@end
