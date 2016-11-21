//
//  TableViewCellContato.m
//  LivroEmprestator
//
//  Created by ALUNO on 16/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "TableViewCellContato.h"

@interface TableViewCellContato()
@property (weak, nonatomic) IBOutlet UILabel *apelido;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;


@end

@implementation TableViewCellContato

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) preencherComApelido: (NSString *)apelido {
    [self.apelido setText:apelido];
    
    }


@end
