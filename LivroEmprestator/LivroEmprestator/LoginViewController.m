//
//  LoginViewController.m
//  LivroEmprestator
//
//  Created by hc05mac29 on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "LoginViewController.h"

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

- (IBAction)validarLogin:(UIButton *)naoLoga {
    
    if([self.usuario.text isEqualToString:@"Bruno"] && [self.senha.text isEqualToString:@"12345678"]){
        [self performSegueWithIdentifier:@"sucessoLogin" sender:naoLoga];
    }else{
        UIAlertController *falhaLogin = [UIAlertController alertControllerWithTitle:@"ERRO"
                                                message:@"Usuário e/ou Senha inválidos! Tente novamente."
                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [falhaLogin addAction:ok];
        
        
        
        [self presentViewController:falhaLogin animated:YES completion:nil];


    }
    
    
    
}
- (IBAction)criarUsuario:(UIButton *)sender {
}


@end
