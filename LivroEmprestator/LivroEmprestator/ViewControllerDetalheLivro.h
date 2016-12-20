//
//  ViewControllerDetalheLivro.h
//  LivroEmprestator
//
//  Created by ALUNO on 22/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewController.h"
#import "Livro+CoreDataClass.h"

@interface ViewControllerDetalheLivro : ViewController
@property Livro *livroSelecionado;
@property Usuario *usuarioEstante;

@end
