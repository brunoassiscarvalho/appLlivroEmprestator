//
//  Livro+CoreDataProperties.m
//  LivroEmprestator
//
//  Created by ALUNO on 25/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Livro+CoreDataProperties.h"

@implementation Livro (CoreDataProperties)

+ (NSFetchRequest<Livro *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Livro"];
}

@dynamic ano;
@dynamic edicao;
@dynamic resumo;
@dynamic titulo;

@end
