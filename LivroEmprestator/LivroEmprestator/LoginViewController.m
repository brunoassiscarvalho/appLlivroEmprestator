//
//  LoginViewController.m
//  LivroEmprestator
//
//  Created by hc05mac29 on 06/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "LoginViewController.h"
#import "Usuario+CoreDataClass.h"
#import "AppDelegate.h"

@interface LoginViewController ()<NSURLSessionDataDelegate,NSFetchedResultsControllerDelegate, UITableViewDelegate>
@property (strong , nonatomic) NSMutableData * bytesResposta;
@property (strong , nonatomic) NSMutableData * bytesRespostaImg;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITextField *usuario;
@property (weak, nonatomic) IBOutlet UITextField *senha;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bytesResposta = [NSMutableData new];
    _bytesRespostaImg = [NSMutableData new];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSURLSessionConfiguration *sc = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sc delegate:self delegateQueue:nil];
    NSURLSessionDataTask *dataTask= [ session dataTaskWithURL:[NSURL URLWithString:@"https://jsonplaceholder.typicode.com/users"]];
    [dataTask resume];
   
    

    NSError *erro;
    if (![self.fetchedResultsController performFetch:&erro]) {
        NSLog(@"Erro ao recuperar pessoas: %@", erro);
    }else {
        NSLog(@"Recuperou pessoas");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_bytesResposta appendData:data];
}
-(void)URLSession:(NSURLSession *)session dataTaskImg:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_bytesRespostaImg appendData:data];
}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if(error){
        NSLog(@"Erro de conexão: %@",error);
    }else{
        NSError *erroJSON;
        NSArray<NSDictionary *> *usuarios = [NSJSONSerialization JSONObjectWithData:_bytesResposta options:kNilOptions error:&erroJSON];
        
        
        
        
        if(erroJSON){
            NSLog(@"JSON recebido é inválido: %@",erroJSON);
        }else{
            
            
            

            
            AppDelegate *delegate = (AppDelegate *)
            [[UIApplication sharedApplication]delegate];
            NSPersistentContainer *container = delegate.persistentContainer;
            NSManagedObjectContext *context = container.viewContext;
            
            NSLog(@"Dados recebidos:%@", usuarios);
            
            NSFetchRequest *buscarUsuario = [Usuario fetchRequest];
            
            for (NSDictionary *usuario in usuarios){
               
                
                [buscarUsuario setPredicate:[NSPredicate predicateWithFormat:@"apelido LIKE %@", [usuario objectForKey:@"username"]]];
                [buscarUsuario setFetchLimit:1];
                
                NSError *erroCoreDataUsuario;
                
                Usuario *usuarioQueJaExiste = [[context executeFetchRequest:buscarUsuario error:&erroCoreDataUsuario] firstObject];
                if(usuarioQueJaExiste==nil){
                    Usuario *usuarioCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Usuario" inManagedObjectContext:context];
                    
                  /*  [self baixarImagem:nil comCallback:^(UIImage *foto, NSError *erro) {
                        
                    }];*/
                    
                    
                    
                    NSURL *url = [NSURL URLWithString: @"http://lorempixel.com/400/400/"] ;
                    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    NSURLSession *session = [NSURLSession sharedSession];
                    
                    NSURLSessionDownloadTask *taskFoto = [session downloadTaskWithURL:url
                                                                    completionHandler:^(NSURL *_Nullable location,
                                                                                        NSURLResponse * _Nullable response,
                                                                                        NSError * _Nullable error){
                                                                        
                                                                        if(error) {
                                                                            NSLog(@"erro imagem:%@",error);
                                                                        }else{
                                                                            
                                                                            NSData *bytesDaImagem = UIImagePNGRepresentation([UIImage imageWithContentsOfFile:location.path]);
                                                                            [usuarioCoreData setImagem: bytesDaImagem ];
                                                                        }
                                                                    }];
                    [taskFoto resume];
                    
                    [usuarioCoreData setApelido:[usuario objectForKey:@"username"]];
                    [usuarioCoreData setNome:[usuario objectForKey:@"name"]];
                    [usuarioCoreData setEmail:[usuario objectForKey:@"email"]];
                    [usuarioCoreData setSenha:@"1"];
                     NSLog(@"Usuario: %@", [usuario objectForKey:@"username"]);
                }
                
                
            }
        }
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

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSPersistentContainer *persistentContainer = delegate.persistentContainer;
        
        NSFetchRequest *fetchRequest = [Usuario fetchRequest];
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"apelido" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:persistentContainer.viewContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        [_fetchedResultsController setDelegate:self];
    }
    
    
    return _fetchedResultsController;
}

- (IBAction)validarLogin:(UIButton *)login {
    
    AppDelegate *delegate = (AppDelegate *)
    [[UIApplication sharedApplication]delegate];
    NSPersistentContainer *container = delegate.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    
    NSFetchRequest *fetchPorUsuario = [NSFetchRequest fetchRequestWithEntityName:@"Usuario"];
    
            [fetchPorUsuario setPredicate:[NSPredicate predicateWithFormat:@"apelido == %@", self.usuario.text]];
    
    NSError *erroCoreData;
    Usuario *usuario = [[context executeFetchRequest:fetchPorUsuario error:&erroCoreData] firstObject];
    
    if (usuario && [self.senha.text isEqualToString:usuario.senha]) {
        //[self.senha.text isEqualToString:@"12345678"]
        
        NSString *identificador = [[[usuario objectID] URIRepresentation] absoluteString];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:identificador forKey:@"UsuarioLogado"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        [self performSegueWithIdentifier:@"sucessoLogin" sender:login];
    }else{
        NSLog(@"Erro core data: %@", erroCoreData);
        UIAlertController *falhaLogin = [UIAlertController alertControllerWithTitle:@"ERRO"
                                                                            message:@"Usuário e/ou Senha inválidos! Tente novamente."
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [falhaLogin addAction:ok];
        [self presentViewController:falhaLogin animated:YES completion:nil];
        
    }


}

- (void) baixarImagem: (NSURL *) url comCallback: (CallbackDownloadFoto) callback {
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            callback(nil, error);
        }else {
            UIImage *foto = [UIImage imageWithContentsOfFile:location.path];
            callback(foto, nil);
        }
    }];
    
    [task resume];
}





@end
