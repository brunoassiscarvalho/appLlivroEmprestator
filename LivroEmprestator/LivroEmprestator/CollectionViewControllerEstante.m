//
//  CollectionViewControllerEstante.m
//  LivroEmprestator
//
//  Created by ALUNO on 13/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "CollectionViewControllerEstante.h"
#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"
#import "Livro+CoreDataClass.h"
#import "CollectionViewCellEstante.h"


@interface CollectionViewControllerEstante ()<NSURLSessionDataDelegate, NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property Usuario *usuarioLogado;
@end

@implementation CollectionViewControllerEstante

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
    
    NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
    
    self.usuarioLogado = [context objectWithID:idSolicitante];
    
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCellEstante" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CollectionViewCellEstante"];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _usuarioLogado.livro.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCellEstante *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellEstante" forIndexPath:indexPath];
    
    // Configure the cell
    [self configurarCelula:cell noIndexPath:indexPath];
    return cell;
}

- (void) configurarCelula: (CollectionViewCellEstante*) cell noIndexPath: (NSIndexPath *) indexPath {
    
    
    NSSet *livrosUsuario = _usuarioLogado.livro;
    if(livrosUsuario!=nil){
        NSArray *myArray = [livrosUsuario allObjects];
        
        Livro *livroUsuario = [myArray objectAtIndex:(indexPath.row)];
        
        UIImage *imagemLivro = [UIImage imageWithData:livroUsuario.imagem];
        
        
        [cell preencherComImagem:imagemLivro];
    }
    
   
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
