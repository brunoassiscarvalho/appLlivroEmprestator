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
    [self fibonacci: 50];
    [self impares:4];
    [self palindromo: @"SOCORRAM-ME, SUBI NO ÔNIBUS EM MARROCOS"];
    [self armstrong:23];
    
    NSArray *array = @[@1, @2, @3, @4, @5, @6];
    [self somaMatriz: array ];
    [self imprimeDiagonal:@"ola pessoal"];
    
     
    
    
   
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

-(void)impares:(int)quantidade{
    int resposta = 1;
    for (int i =0; i< quantidade; i++)
    {
    
        NSLog(@"%d",resposta);
        resposta+=2;
    }
}

-(Boolean)palindromo: (NSString*) oracao{
    
    Boolean retorno = false;
    NSData *temp = [oracao dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableString *textoLimpo =[[NSMutableString alloc] initWithData:temp encoding:NSASCIIStringEncoding];
    
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    textoLimpo = [[textoLimpo  componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    
    NSMutableString *textoReverso = [NSMutableString string];
    NSInteger charIndex = [textoLimpo  length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [textoReverso appendString:[textoLimpo  substringWithRange:subStrRange]];
    }
    if ([textoLimpo caseInsensitiveCompare: textoReverso] == NSOrderedSame){
        retorno=true;
        NSLog(@"  %@ é um palindromo", oracao);
        
    }else{
        NSLog(@"  %@ não é um palindromo", oracao);
    }
    return retorno;
}

-(void) somaMatriz: (NSArray*) matriz{
    NSLog(@"a soma da matriz é:  %ld",[[matriz valueForKeyPath:@"@sum.self"] integerValue]);
    
}

-(void) imprimeDiagonal: (NSString*) texto{
    NSInteger charIndex = [texto  length];
    for (int i =0; i<charIndex ; i++) {
        NSRange subStrRange = NSMakeRange(i, 1);
        NSLog(@"%@%@ ", [@"" stringByPaddingToLength:i withString:@" " startingAtIndex:0],[texto  substringWithRange:subStrRange]);
    }
    
}





-(void)armstrong:(int)num{
    
    NSString* myString2 = [NSString stringWithFormat:@"%d",num];
    long i = myString2.length;
    int temp=num;
    int sum=0, r=0;
    while(num!=0){
        r=num%10;
        num=num/10;
        sum=sum+pow(r,i);
    }
    if(sum==temp)
        NSLog(@"%d é um numero de Armstrong",temp);
    else
        NSLog(@"%d não é um numero de Armstrong",temp);
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
