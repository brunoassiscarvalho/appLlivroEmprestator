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

@interface TableViewControllerContatos () <NSURLSessionDataDelegate,NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong , nonatomic) NSMutableData * bytesResposta;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@end

@implementation TableViewControllerContatos

- (void)viewDidLoad {
    [super viewDidLoad];
    _bytesResposta = [NSMutableData new];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSURLSessionConfiguration *sc = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sc delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataTask= [ session dataTaskWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/users"]];
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
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_bytesResposta appendData:data];
}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if(error){
        NSLog(@"Erro de conexão: %@",error);
    }else{
        NSError *erroJSON;
        NSArray<NSDictionary *> *usuarios = [NSJSONSerialization JSONObjectWithData:_bytesResposta options:kNilOptions error:&erroJSON];
        
        if(erroJSON){
            NSLog(@"JSON recebido é inválido: %@",erroJSON);
        }else{
            
            AppDelegate *delegate = (AppDelegate *)
            [[UIApplication sharedApplication]delegate];
            NSPersistentContainer *container = delegate.persistentContainer;
            NSManagedObjectContext *context = container.viewContext;
            
            NSLog(@"Dados recebidos:%@", usuarios);
            for (NSDictionary *usuario in usuarios){
                NSLog(@"Usuario: %@", [usuario objectForKey:@"name"]);
                Usuario *usuarioCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
                
                [usuarioCoreData setApelido:[usuario objectForKey:@"username"]];
                [usuarioCoreData setNome:[usuario objectForKey:@"name"]];
                [usuarioCoreData setEmail:[usuario objectForKey:@"email"]];
            }
        }
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
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCellContato" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TableViewCellContato"];
    
    return _fetchedResultsController;
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
    TableViewCellContato *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellContato" forIndexPath:indexPath];
    [self configurarCelula:cell noIndexPath:indexPath];
    return cell;
}

- (void) configurarCelula: (TableViewCellContato *) cell noIndexPath: (NSIndexPath *) indexPath {
    Usuario *contato = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // NSInteger numeroIndice = indexPath.row;
    // NSString *integerAsString = [NSString stringWithFormat: @"%ld", (long)numeroIndice];
    //Para converter NSdata para imagem
    //UIImage *imagem = [UIImage imageWithData:livro.imagem];
    [cell preencherComApelido:contato.apelido];
}

@end
