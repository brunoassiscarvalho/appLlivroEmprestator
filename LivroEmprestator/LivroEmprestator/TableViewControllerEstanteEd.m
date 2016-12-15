//
//  TableViewControllerEstanteEd.m
//  LivroEmprestator
//
//  Created by ALUNO on 15/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewControllerEstanteEd.h"
#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"
#import "Livro+CoreDataClass.h"


@interface TableViewControllerEstanteEd ()
<NSURLSessionDataDelegate, NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titulo;

@property (strong, nonatomic) IBOutlet UITableView *tabela;
@property (strong, nonatomic) NSMutableArray<NSString *> *nomes;
@property Usuario *usuarioLogado;

@end

@implementation TableViewControllerEstanteEd

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabela setDataSource:self];
    
    self.nomes = [[NSMutableArray alloc] init];
    
    [self.nomes addObject:[NSString stringWithFormat:@"Fulano"]];
    [self.nomes addObject:[NSString stringWithFormat:@"Beltrano"]];
    [self.nomes addObject:[NSString stringWithFormat:@"Celtrano"]];
    [self.nomes addObject:[NSString stringWithFormat:@"Ciclano"]];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _usuarioLogado.livro.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"ItemLIstaContatos"
                                    forIndexPath:indexPath];
    
    UIColor *verde = [UIColor colorWithRed:141.0/255.0
                                     green:158.0/255.0
                                      blue:129.0/255.0
                                     alpha:1];
    UIColor *verde2 = [UIColor colorWithRed:141.0/255.0
                                     green:158.0/255.0
                                      blue:129.0/255.0
                                     alpha:0.5];
    
    if (indexPath.row % 2) {
        [cell setBackgroundColor:verde];
    }else {
        [cell setBackgroundColor:verde2];
    }
    
    NSSet *livrosUsuario = _usuarioLogado.livro;
    if(livrosUsuario!=nil){
        NSArray *myArray = [livrosUsuario allObjects];
        
        Livro *livroUsuario = [myArray objectAtIndex:(indexPath.row)];
        
                
        NSString *nome = livroUsuario.titulo;
        
        [cell.textLabel setText:nome];

        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    
    
    
    
    
    return cell;
    
    
    
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSSet *livrosUsuario = _usuarioLogado.livro;
        if(livrosUsuario!=nil){
            NSArray *myArray = [livrosUsuario allObjects];
            
            Livro *livroUsuario = [myArray objectAtIndex:(indexPath.row)];

            [_usuarioLogado removeLivroObject:livroUsuario];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //[self.nomes removeObjectAtIndex:indexPath.row];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Deu Erro! %@" , erroCoreData);
    }else{
        NSLog(@"Usuario incluido com sucesso!");
    }
    
    [tableView reloadData];
}





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
