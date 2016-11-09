//
//  Exercicio03TableViewController.m
//  IOS2exercico6
//
//  Created by ALUNO on 01/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Exercicio03TableViewController.h"
#import "Exercicio03TableViewCell.h"

@interface Exercicio03TableViewController ()

@end

@implementation Exercicio03TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"Exercicio03TableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Exercicio03TableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Exercicio03TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Exercicio03TableViewCell" forIndexPath:indexPath];
    //chamar um método para alimentar a célula
    //Exemplo: [cell alimentarComTexto:@"xpto"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 196; //retornar aqui a altura estimada da célula... olhe no XIB a altura.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension; //isso faz a tableView aceitar células com alturas dinâmicas
}
@end
