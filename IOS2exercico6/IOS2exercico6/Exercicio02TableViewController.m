//
//  Exercicio02TableViewController.m
//  IOS2exercico6
//
//  Created by ALUNO on 01/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Exercicio02TableViewController.h"
#import "Exercicio02TableViewCell.h"

@interface Exercicio02TableViewController ()

@end

@implementation Exercicio02TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"Exercicio02TableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Exercicio02TableViewCell"];
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
    Exercicio02TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Exercicio02TableViewCell" forIndexPath:indexPath];
    //chamar um método para alimentar a célula
    //Exemplo: [cell alimentarComTexto:@"xpto"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 525; //retornar aqui a altura estimada da célula... olhe no XIB a altura.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension; //isso faz a tableView aceitar células com alturas dinâmicas
}
@end
