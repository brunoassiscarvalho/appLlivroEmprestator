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
#import "ViewControllerUsuario2.h"

@import Photos;
@import MobileCoreServices;

@interface ViewControllerUsuario () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *apelido;
@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UIImageView *imagemUsuario;
@property (weak, nonatomic) IBOutlet UITextField *senha01;
@property (weak, nonatomic) IBOutlet UITextField *senha02;
@property (weak, nonatomic) IBOutlet UILabel *labelApelido;
@property (weak, nonatomic) IBOutlet UILabel *labelApelidoBox;
@property (weak, nonatomic) IBOutlet UILabel *labelSenha1;
@property (weak, nonatomic) IBOutlet UILabel *labelSenha2;
@property (assign) BOOL editando;

@property Usuario *usuario;



@end

@implementation ViewControllerUsuario

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_usuarioLogado!=nil){
        [self.email setText:_usuarioLogado.email];
        [self.labelApelidoBox setHidden:YES];
        [self.apelido setHidden:YES];
        [self.nome setText:_usuarioLogado.nome];
        [self.apelido setAllowsEditingTextAttributes:NO];
        [self.labelApelido setText:_usuarioLogado.apelido];
        [self.senha01 setHidden:YES];
        [self.senha02 setHidden:YES];
        [self.labelSenha1 setHidden:YES];
        [self.labelSenha2 setHidden:YES];
        self.editando =YES;
        
        
    }else{
     self.editando =NO;
    }
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
    if(self.editando){
        self.usuario = _usuarioLogado;

    }else{
        self.usuario = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
        
        
        [self.usuario setApelido:self.apelido.text];
        
        if([self.senha01.text isEqualToString:self.senha02.text]){
            [self.usuario setSenha:self.senha01.text];
        }
        
    }

    [self.usuario setNome:self.nome.text];
    [self.usuario setEmail:self.email.text];
      
    
   
    
    NSData *bytesDaImagem = UIImagePNGRepresentation(self.imagemUsuario.image);
    [self.usuario setImagem: bytesDaImagem];
    
    NSError *erroCoreData;
    if(![context save:&erroCoreData]){
        NSLog(@"Deu Erro! %@" , erroCoreData);
    }else{
        NSLog(@"Usuario incluido com sucesso!");
    }

}

- (IBAction)cadastrar1passo:(id)sender {
    [self incluirUsuario];
    [self performSegueWithIdentifier:@"continuarCadastro" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"continuarCadastro"]){
        
        ViewControllerUsuario2  *destino = segue.destinationViewController;
        [destino setNovoUsuario:self.usuario];
        [destino setEditando:self.editando];
        
    }
}



- (IBAction)editarFotoUsuario:(UIButton *)sender {
    
    UIImagePickerController *picker = [UIImagePickerController new];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    //Todos os tipos disponíveis:
    [picker setMediaTypes:[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]];
    
    [self presentViewController:picker animated:YES completion:nil];

}
/*-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *imagem = info[UIImagePickerControllerOriginalImage];
    
}*/

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *imagemEscolhida = info[UIImagePickerControllerEditedImage]; //Veja as outras opções.
    
    //Você vai precisar disso para o exercício
 NSData *bytesDaImagem = UIImagePNGRepresentation(imagemEscolhida);
    
    //Para converter de volta
UIImage *imagem = [UIImage imageWithData:bytesDaImagem];
    
    [self.imagemUsuario setImage:imagem];
   
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"Usuário cancelou.");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)voltar:(UIBarButtonItem *)sender {
    if(_editando){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    [self performSegueWithIdentifier:@"voltarLogin" sender:self];
    }
}

@end
