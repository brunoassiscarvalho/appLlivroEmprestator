//
//  ViewControllerConfig.m
//  LivroEmprestator
//
//  Created by ALUNO on 22/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerConfig.h"

#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"
#import "ViewControllerUsuario.h"

@interface ViewControllerConfig ()<NSURLSessionDataDelegate, NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property Usuario *usuarioLogado;

@end

@implementation ViewControllerConfig

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
    
    NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
    
    _usuarioLogadoConfig = [context objectWithID:idSolicitante];
 

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

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueConfigMeusDados"]){        ViewControllerUsuario *destino = segue.destinationViewController;
        
        
    }
}*/
- (IBAction)meusDados:(UIButton *)sender {
    [self performSegueWithIdentifier:@"configMeusDados" sender:sender];
    
}

- (IBAction)minhaEstante:(UIButton *)sender {
    [self performSegueWithIdentifier:@"configEstante" sender:sender];
}

- (IBAction)alterarSenha:(UIButton *)sender {
 [self performSegueWithIdentifier:@"configAlterarSenha" sender:sender];
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Celula Selecionada: %@", indexPath);

    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"configMeusDados"] ){
        
        
        ViewControllerUsuario  *destino = segue.destinationViewController;
        [destino setUsuarioLogado:_usuarioLogadoConfig];
        
    }
}

@end
