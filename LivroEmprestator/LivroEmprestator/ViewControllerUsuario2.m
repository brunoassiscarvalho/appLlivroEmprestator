//
//  ViewControllerUsuario2.m
//  LivroEmprestator
//
//  Created by ALUNO on 07/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerUsuario2.h"
#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"

@interface ViewControllerUsuario2 ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dataNascimento;
@property (weak, nonatomic) IBOutlet UISwitch *sexo;
@property (weak, nonatomic) IBOutlet UITextField *uf;
@property (weak, nonatomic) IBOutlet UITextField *cidade;

@end

@implementation ViewControllerUsuario2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) incluirUsuario{
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    Usuario *usuario = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    //NSDate *data = [formatter dateFromString:self.dataNascimento.date];
     [usuario setDatanascimento:self.dataNascimento.date];
     if( self.sexo.on){
     [usuario setSexo:@"F"];
     }else{
     [usuario setSexo:@"M"];
     }
     
     [usuario setUf:self.uf.text];
     [usuario setCidade:self.cidade.text];
    
    
    
    
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Deu Erro! %@" , erroCoreData);
    }else{
        NSLog(@"Usuario incluido com sucesso!");
    }
    
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
