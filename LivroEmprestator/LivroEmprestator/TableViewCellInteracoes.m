//
//  TableViewCellInteracoes.m
//  LivroEmprestator
//
//  Created by ALUNO on 22/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewCellInteracoes.h"

@interface TableViewCellInteracoes()
@property (weak, nonatomic) IBOutlet UIImageView *imagemUsuario;
@property (weak, nonatomic) IBOutlet UIImageView *imagemLivro;


@end

@implementation TableViewCellInteracoes


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) mostrarImagemUsuario: (UIImage *)usuarioImagem imagemLivro:(UIImage*) livroImagem{
    
    [self.imagemUsuario setImage:usuarioImagem];
    [self.imagemLivro setImage: livroImagem];
}


@end
