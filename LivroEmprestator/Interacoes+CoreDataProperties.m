//
//  Interacoes+CoreDataProperties.m
//  LivroEmprestator
//
//  Created by ALUNO on 23/11/16.
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
@dynamic usuarioLeitor;
@dynamic usuarioEmprestador;

@end
