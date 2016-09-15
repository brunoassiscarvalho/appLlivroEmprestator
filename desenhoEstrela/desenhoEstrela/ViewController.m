//
//  ViewController.m
//  desenhoEstrela
//
//  Created by ALUNO on 24/08/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"
#import "ViewEstrela.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
     ViewEstrela *mv = [[ViewEstrela alloc] initWithFrame:CGRectMake(20, 20, 250, 250)];
     [self.view addSubview:mv];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:0
                     animations:^{
                         [UIView setAnimationRepeatCount:HUGE_VALF];
                         [UIView setAnimationBeginsFromCurrentState:YES];
                         mv.transform = CGAffineTransformMakeRotation(M_PI);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];

   
   
    
   
}

@end
