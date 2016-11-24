//
//  LoginViewController.m
//  LivroEmprestator
//
//  Created by hc05mac29 on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "LoginViewController.h"
#import "Usuario+CoreDataClass.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usuario;
@property (weak, nonatomic) IBOutlet UITextField *senha;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)validarLogin:(UIButton *)login {
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    
    NSFetchRequest *fetchPorUsuario = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
    
            [fetchPorUsuario setPredicate:[NSPredicate predicateWithFormat:@"apelido == %@", self.usuario.text]];
    
    NSError *erroCoreData;
    Usuario *usuario = [[context executeFetchRequest:fetchPorUsuario error:&erroCoreData] firstObject];
    
    if (usuario) {
        //[self.senha.text isEqualToString:@"12345678"]
        
        [self performSegueWithIdentifier:@"sucessoLogin" sender:login];
    }else{
        NSLog(@"Erro core data: %@", erroCoreData);
        UIAlertController *falhaLogin = [UIAlertController alertControllerWithTitle:@"ERRO"
                                                                            message:@"Usuário e/ou Senha inválidos! Tente novamente."
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [falhaLogin addAction:ok];
        [self presentViewController:falhaLogin animated:YES completion:nil];
        
    }
    
 /*   if([self.usuario.text isEqualToString:@"Bruno"] && [self.senha.text isEqualToString:@"12345678"]){
        
  //manipular usuario

/*        [[NSUserDefaults standardUserDefaults] setObject:@"usuario" forKey:@"UsuarioLogado"];
 
 [[NSUserDefaults standardUserDefaults] objectForKey:@"UsuarioLogado"];
        
        //salvar
        NSManagedObjectID *identificador = [usuario objectID];
        
        
        NSFetchRequest *fetchPorID = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
        
        //recuperar
        
        [fetchPorID setPredicate:[NSPredicate predicateWithFormat:@"objectID == %@", identificador]];
        [fetchPorID setFetchLimit:1];
        
        Usuario *x = [[context executeFetchRequest:fetchPorID error:nil] firstObject];
  
  }
*/

}




@end
