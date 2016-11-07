//
//  ViewController.m
//  Exercicios
//
//  Created by ALUNO on 28/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelBemVindo;
@property (weak, nonatomic) IBOutlet UIView *viewUsuario;
@property (weak, nonatomic) IBOutlet UIView *viewSenha;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 /*   CGRect inicio =  self.viewSenha.frame;
    inicio.origin = CGPointMake(self.view.frame.size.width, inicio.origin.y);*/
   
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:0
                     animations:^{
        CGRect frame =  self.labelBemVindo.frame;
        CGPoint centro = self.view.center;
        frame.origin = CGPointMake(centro.x-frame.size.width/2.0,frame.origin.y);
        [self.labelBemVindo setFrame: frame];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
  
    
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options:0
                     animations:^{
        CGRect frame =  self.viewUsuario.frame;
        CGPoint centro = self.view.center;
        frame.origin = CGPointMake(centro.x-frame.size.width/2.0,frame.origin.y);
        [self.viewUsuario setFrame: frame];
    }completion:^(BOOL finished){
        NSLog(@"Done!");
    }];
    
    [UIView animateWithDuration:1.0
                          delay:2.0
                        options:0
                     animations:^{
        CGRect frame =  self.viewSenha.frame;
        CGPoint centro = self.view.center;
        frame.origin = CGPointMake(centro.x-frame.size.width/2.0,frame.origin.y);
        [self.viewSenha setFrame: frame];
    }completion:^(BOOL finished){
        NSLog(@"Done!");
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
