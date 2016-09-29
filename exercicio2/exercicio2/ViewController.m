//
//  ViewController.m
//  exercicio2
//
//  Created by ALUNO on 28/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fatorial: 10];
    [self fibonacci: 100];
    
    
   
}

-(void)fatorial:(int)numero{
    double resultado = tgammaf(numero+1);
    NSLog(@"O Fatorial de %d é %f",numero,resultado);
}
/*-(void)fibonacci:(int)numero{
    for (int n=1; n<=numero; n++){
         NSLog(@"%d = %ld \n",n,[self fib:n]);
    }
}

-(long)fib:(long)num{
    if (num == 0) {
        return 0;
    }
    if (num == 1) {
        return 1;
    }
    return [self fib:num - 1] + [self fib:num - 2];
}*/

-(void)fibonacci:(int)range{
    //int range = 15;
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    for (int k =0; k< range; k++)
    {
        if(k<2)
        {
            [arr addObject:[NSString stringWithFormat:@"%d",k]];
            continue;
        }
        else
        {
            long fib = [[arr objectAtIndex:k-2] intValue] + [[arr objectAtIndex:k-1] intValue];
            [arr addObject:[NSString stringWithFormat:@"%ld",fib]];
        }
        
    }
    
    NSLog(@"%@",arr);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
