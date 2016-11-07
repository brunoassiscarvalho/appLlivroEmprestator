//
//  ViewController.m
//  BancoDeDados
//
//  Created by ALUNO on 19/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Produto+CoreDataClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self incluirProduto];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) incluirProduto{
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    Produto *produto = [NSEntityDescription insertNewObjectForEntityForName:@"Produto" inManagedObjectContext:context];
    [produto setDescricao:@"Projetor"];
    [produto setPreco:899.99];
    [produto setMarca:@"EPSON"];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *data = [formatter dateFromString:@"20/02/2025"];
    [produto setValidade:data];
    
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Deu Erro! %@" , erroCoreData);
    }else{
        NSLog(@"Produto incluido com sucesso!");
    }
    
    
    
}


-(void) viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear: animated];
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Produto"];
    
    //Link : http://nshipster.com/nspredicate/
    [fr setPredicate:[NSPredicate predicateWithFormat:@"descricao ==[cd] %@", @"projetor"]];
    
    // ordena por validade ASC
    [fr setSortDescriptors:
     @[[NSSortDescriptor sortDescriptorWithKey:@"validade" ascending:YES]]];
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    NSError *erroFetch;
    
    NSArray *resultado  = [context executeFetchRequest:fr error:&erroFetch];
    
    if(!erroFetch){
        NSLog(@"Resultado: %@", resultado);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
