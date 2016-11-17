//
//  Exercicio01TableViewController.m
//  IOS2exercico6
//
//  Created by ALUNO on 31/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Exercicio01TableViewController.h"
#import "Exercio01TableViewCell.h"

@interface Exercicio01TableViewController ()<UITableViewDelegate>

@end

@implementation Exercicio01TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"Exercio01TableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Exercio01TableViewCell"];
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
    Exercio01TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Exercio01TableViewCell" forIndexPath:indexPath];
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
