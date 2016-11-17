//
//  TableViewCellLivro.h
//  LivroEmprestator
//
//  Created by ALUNO on 16/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellLivro : UITableViewCell

-(void) preencherComTitulo: (NSString *)tituloLivro autor:(NSString*)nomeAutor imagem:(UIImage*) imagemLivro;


@end
