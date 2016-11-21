//
//  Usuario+CoreDataProperties.m
//  LivroEmprestator
//
//  Created by ALUNO on 21/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Usuario+CoreDataProperties.h"

@implementation Usuario (CoreDataProperties)

+ (NSFetchRequest<Usuario *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Usuario"];
}

@dynamic apelido;
@dynamic cidade;
@dynamic datanascimento;
@dynamic email;
@dynamic nome;
@dynamic sexo;
@dynamic uf;
@dynamic imagem;

@end
