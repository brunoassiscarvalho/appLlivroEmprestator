//
//  ViewControllerConfig.m
//  LivroEmprestator
//
//  Created by ALUNO on 22/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerConfig.h"
#import "ViewControllerUsuario.h"

@interface ViewControllerConfig ()

@end

@implementation ViewControllerConfig

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

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"segueConfigMeusDados"]){        ViewControllerUsuario *destino = segue.destinationViewController;
        
        
    }
}*/
- (IBAction)meusDados:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueConfigMeusDados" sender:sender];
    
}

- (IBAction)meusLivros:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueConfigMeusLivros" sender:sender];
    
}

@end
