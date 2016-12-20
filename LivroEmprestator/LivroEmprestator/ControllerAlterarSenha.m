//
//  ControllerAlterarSenha.m
//  LivroEmprestator
//
//  Created by ALUNO on 19/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ControllerAlterarSenha.h"
#import "Usuario+CoreDataClass.h"
#import "AppDelegate.h"

@interface ControllerAlterarSenha ()
@property (weak, nonatomic) IBOutlet UITextField *senhaAntiga;
@property (weak, nonatomic) IBOutlet UITextField *novaSenha1;
@property (weak, nonatomic) IBOutlet UITextField *novaSenha2;
@property Usuario *usuarioLogado;
@end

@implementation ControllerAlterarSenha

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    NSString *idUsuarioSolicitante = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
    
    NSManagedObjectID *idSolicitante = [container.persistentStoreCoordinator managedObjectIDForURIRepresentation:[NSURL URLWithString:idUsuarioSolicitante]];
    
    self.usuarioLogado = [context objectWithID:idSolicitante];
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
- (IBAction)confirmarAlteracao:(UIButton *)sender {
   
    
    if ([_usuarioLogado.senha isEqualToString:self.senhaAntiga.text] && [self.novaSenha1.text isEqualToString:self.novaSenha2.text]) {

        
        [_usuarioLogado setSenha:self.novaSenha2.text];
        
        AppDelegate *delegate = (AppDelegate *)
        [[UIApplication sharedApplication]delegate];
        NSPersistentContainer *container = delegate.persistentContainer;
        NSManagedObjectContext *context = container.viewContext;
        NSError *erroCoreData;
        if(![context save:&erroCoreData]){
            NSLog(@"Deu Erro ao alterar a senha! %@" , erroCoreData);
        }else{
            NSLog(@"Senha alterada!");
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }else{
       
        UIAlertController *falhaSenha = [UIAlertController alertControllerWithTitle:@"ERRO"
                                                                            message:@"Senha(s) divergente(s). Tente Novamente"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [falhaSenha addAction:ok];
        [self presentViewController:falhaSenha animated:YES completion:nil];
        
    }
    
}

@end
