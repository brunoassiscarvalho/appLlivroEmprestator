//
//  TableViewCellLivro.m
//  LivroEmprestator
//
//  Created by ALUNO on 16/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewCellLivro.h"

@interface TableViewCellLivro ()
@property (weak, nonatomic) IBOutlet UILabel *tituloLivro;
@property (weak, nonatomic) IBOutlet UILabel *nomeAutor;
@property (weak, nonatomic) IBOutlet UIImageView *imagemLivro;
@end

@implementation TableViewCellLivro

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) preencherComTitulo: (NSString *)tituloLivro autor:(NSString*)nomeAutor imagem:(UIImage*) imagemLivro{
    [self.tituloLivro setText:tituloLivro];
    [self.tituloLivro setText:nomeAutor];
    [self.imagemLivro setImage: imagemLivro];
}


@end
