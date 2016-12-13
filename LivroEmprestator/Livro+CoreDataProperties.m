//
//  Livro+CoreDataProperties.m
//  LivroEmprestator
//
//  Created by ALUNO on 13/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Livro+CoreDataProperties.h"

@implementation Livro (CoreDataProperties)

+ (NSFetchRequest<Livro *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Livro"];
}

@dynamic ano;
@dynamic edicao;
@dynamic imagem;
@dynamic resumo;
@dynamic titulo;
@dynamic autor;
@dynamic usuario;

@end
