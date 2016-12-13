//
//  CollectionViewCellEstante.m
//  LivroEmprestator
//
//  Created by ALUNO on 13/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "CollectionViewCellEstante.h"

@interface CollectionViewCellEstante()
@property (weak, nonatomic) IBOutlet UIImageView *imagemLivro;

@end

@implementation CollectionViewCellEstante



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) preencherComImagem:(UIImage*) imagem{
    [self.imagemLivro setImage:imagem];
    
}

@end
