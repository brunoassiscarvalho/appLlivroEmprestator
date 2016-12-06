//
//  ViewControllerImagem.m
//  LivroEmprestator
//
//  Created by ALUNO on 29/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerImagem.h"
#import "NSString+Maiuscula.h"

@interface ViewControllerImagem ()
@property (weak, nonatomic) IBOutlet UIImageView *imagem;

@end

@implementation ViewControllerImagem

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self baixarImagem:nil comCallback:^(UIImage *foto, NSError *erro) {
        
    }];
    
    

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
                                                        self.imagem.image = [UIImage imageWithContentsOfFile:location.path];
                                                }
                            }];
    [taskFoto resume];
    

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

@end
