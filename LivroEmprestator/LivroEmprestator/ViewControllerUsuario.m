//
//  ViewControllerUsuario.m
//  LivroEmprestator
//
//  Created by ALUNO on 25/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerUsuario.h"
#import "AppDelegate.h"
#import "Usuario+CoreDataClass.h"
@interface ViewControllerUsuario ()
@property (weak, nonatomic) IBOutlet UITextField *apelido;
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *dataNascimento;
@property (weak, nonatomic) IBOutlet UITextField *uf;
@property (weak, nonatomic) IBOutlet UITextField *cidade;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UISwitch *sexo;


@end

@implementation ViewControllerUsuario

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

-(void) incluirUsuario{
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    Usuario *usuario = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
    
    [usuario setApelido:self.apelido.text];
    [usuario setNome:self.nome.text];
    
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *data = [formatter dateFromString:self.dataNascimento.text];
    [usuario setDatanascimento:data];
    if( self.sexo.on){
        [usuario setSexo:@"F"];
    }else{
        [usuario setSexo:@"M"];
    }
    
    [usuario setUf:self.uf.text];
    [usuario setCidade:self.cidade.text];
    [usuario setEmail:self.email.text];
    
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Deu Erro! %@" , erroCoreData);
    }else{
        NSLog(@"Produto incluido com sucesso!");
    }
    
    
    
}
- (IBAction)concluirCadastro:(id)sender {
    [self incluirUsuario];
}


@end
