//
//  ViewControllerImagem.m
//  LivroEmprestator
//
//  Created by ALUNO on 29/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerImagem.h"

@interface ViewControllerImagem ()
@property (weak, nonatomic) IBOutlet UIImageView *imagem;

@end

@implementation ViewControllerImagem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    NSURL *url = [NSURL URLWithString: @"http://lorempixel.com/400/400/"] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *taskFoto = [session downloadTaskWithURL:url
                                            completionHandler:^(NSURL *_Nullable location,
                                                NSURLResponse * _Nullable response,
                                                NSError * _Nullable error){
                                                        
                                                if(error) {
                                                            
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
