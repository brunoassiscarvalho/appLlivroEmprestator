//
//  ViewControllerIteracoes.h
//  LivroEmprestator
//
//  Created by ALUNO on 05/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Livro+CoreDataClass.h"
#import "Usuario+CoreDataClass.h"

@interface ViewControllerIteracoes : UIViewController
@property Livro *livroSelecionado;
@property Usuario *usuarioSolicitante;
@property Usuario *usuarioSolicitado;


@end
