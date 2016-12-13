//
//  Autor+CoreDataProperties.m
//  LivroEmprestator
//
//  Created by ALUNO on 13/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Autor+CoreDataProperties.h"

@implementation Autor (CoreDataProperties)

+ (NSFetchRequest<Autor *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Autor"];
}

@dynamic nome;
@dynamic livro;

@end
