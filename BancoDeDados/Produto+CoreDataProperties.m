//
//  Produto+CoreDataProperties.m
//  BancoDeDados
//
//  Created by ALUNO on 19/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Produto+CoreDataProperties.h"

@implementation Produto (CoreDataProperties)

+ (NSFetchRequest<Produto *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Produto"];
}

@dynamic descricao;
@dynamic marca;
@dynamic validade;
@dynamic preco;

@end
