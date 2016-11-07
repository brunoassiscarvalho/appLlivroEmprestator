//
//  ViewControllerSegundaTela.m
//  desafio1
//
//  Created by ALUNO on 26/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerSegundaTela.h"

@interface ViewControllerSegundaTela ()

@property (weak, nonatomic) IBOutlet UILabel *nomeUsuario;

@end

@implementation ViewControllerSegundaTela

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.nomeUsuario setText:self.nomeAlterado];
}
- (IBAction)mudarNome:(UIButton *)sender {
    self.nomeAlterado = @"Joaquim Fonseca";
    [self.nomeUsuario setText:self.nomeAlterado];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
