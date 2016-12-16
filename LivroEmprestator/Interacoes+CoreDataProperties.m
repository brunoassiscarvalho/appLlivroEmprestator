//
//  Interacoes+CoreDataProperties.m
//  LivroEmprestator
//
//  Created by ALUNO on 16/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Interacoes+CoreDataProperties.h"

@implementation Interacoes (CoreDataProperties)

+ (NSFetchRequest<Interacoes *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Interacoes"];
}

@dynamic timestamp;
@dynamic tipoIteracao;
@dynamic livro;
@dynamic usuarioSolicitado;
@dynamic usuarioSolicitante;

@end
