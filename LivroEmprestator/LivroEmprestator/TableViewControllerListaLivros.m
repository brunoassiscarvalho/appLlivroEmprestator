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
#import "Autor+CoreDataClass.h"

@interface TableViewControllerListaLivros ()  <NSURLSessionDataDelegate,NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong , nonatomic) NSMutableData * bytesResposta;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation TableViewControllerListaLivros

- (void)viewDidLoad {
    [super viewDidLoad];
    _bytesResposta = [NSMutableData new];
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURLSessionConfiguration *sc = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sc delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataTask= [ session dataTaskWithURL:[NSURL URLWithString:@"https://www.googleapis.com/books/v1/volumes?q=guerra%20dos%20tronos"]];
    [dataTask resume];
    
    
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
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{    [_bytesResposta appendData:data];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if(error){
        NSLog(@"Erro de conexão: %@",error);
    }else{
        
        //pegar JSON
        NSError *erroJSON;
        NSDictionary *listas = [NSJSONSerialization JSONObjectWithData:_bytesResposta options:kNilOptions error:&erroJSON];
        
        if(erroJSON){
            NSLog(@"JSON recebido é inválido: %@",erroJSON);
        }else{
            
            AppDelegate *delegate = (AppDelegate *)
            [[UIApplication sharedApplication]delegate];
            NSPersistentContainer *container = delegate.persistentContainer;
            NSManagedObjectContext *context = container.viewContext;
            
            NSLog(@"Dados recebidos:%@", listas);
            NSLog(@"Total livros: %@", listas[@"totalItems"]);
 
            NSArray<NSDictionary *> *items = listas[@"items"];
            
            NSFetchRequest *buscarLivro = [Livro fetchRequest];
            
            
            for (NSDictionary *item in items){
                
                NSDictionary *livro = [item objectForKey:@"volumeInfo"];
                NSLog(@"Titulo LIvro: %@", livro[@"title"]);
                NSArray *autores = livro[@"authors"];
                
                [buscarLivro setPredicate:[NSPredicate predicateWithFormat:@"titulo LIKE %@", livro[@"title"]]];
                [buscarLivro setFetchLimit:1];
                
                NSError *erroCoreDataLivro;
                
                Livro *livroQueJaExiste = [[context executeFetchRequest:buscarLivro error:&erroCoreDataLivro] firstObject];
                
                
                if (!livroQueJaExiste) {
                    //grava o livro
                    Livro *livroCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Livro" inManagedObjectContext:context];
                    
                    [livroCoreData setTitulo:[livro objectForKey:@"title"]];
                    [livroCoreData setResumo:[livro objectForKey:@"description"]];
                    
                    
                    NSString *imageLinks = livro[@"imageLinks"][@"smallThumbnail"];
                    
                    [self baixarImagem:[NSURL URLWithString:imageLinks] comCallback:^(UIImage *foto, NSError *erro) {
                        NSData *bytesDaImagem = UIImagePNGRepresentation(foto);
                        [livroCoreData setImagem: bytesDaImagem];
                    }];
                    
                    
                    //buscar os autores e gravar
                    for (NSString *autor in autores) {
                        NSFetchRequest *buscarAutor = [Autor fetchRequest];
                        [buscarAutor setPredicate:[NSPredicate predicateWithFormat:@"nome LIKE %@", autor]];
                        [buscarAutor setFetchLimit:1];
                        
                        NSError *erroCoreData;
                        
                        
                        Autor *autorQueJaExiste = [[context executeFetchRequest:buscarAutor error:&erroCoreData] firstObject];
                        
                        if (!autorQueJaExiste) {
                            
                            Autor *novoAutor = [NSEntityDescription insertNewObjectForEntityForName:@"Autor" inManagedObjectContext:context];
                            [novoAutor setNome:autor];
                            [novoAutor addLivroObject:livroCoreData];
                            
                        }else{
                            [autorQueJaExiste addLivroObject:livroCoreData];
                        }
                    }
                }
            }
        }
    }
    
}

- (void) baixarImagem: (NSURL *) url comCallback: (CallbackDownloadFoto) callback {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        }else {
            UIImage *foto = [UIImage imageWithContentsOfFile:location.path];
            callback(foto, nil);
        }
    }];
    
    [task resume];
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
    
    ///recupera autores
    NSSet *autores = livro.autor;
    Autor *autor;
    NSMutableString *concatenaAutores=[NSMutableString string];
    
    
    for(autor in autores){
        NSMutableString *mutableString = [autor.nome mutableCopy];
        [concatenaAutores appendString:mutableString ];
        [concatenaAutores appendString:@", " ];
    }
    
    // NSInteger numeroIndice = indexPath.row;
    // NSString *integerAsString = [NSString stringWithFormat: @"%ld", (long)numeroIndice];
    //Para converter NSdata para imagem
    UIImage *imagem = [UIImage imageWithData:livro.imagem];
    [cell preencherComTitulo:livro.titulo autor:concatenaAutores imagem:imagem];
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
