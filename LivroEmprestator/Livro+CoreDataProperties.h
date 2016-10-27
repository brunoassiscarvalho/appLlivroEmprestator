//
//  Livro+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 25/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Livro+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Livro (CoreDataProperties)

+ (NSFetchRequest<Livro *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *ano;
@property (nonatomic) int32_t edicao;
@property (nullable, nonatomic, copy) NSString *resumo;
@property (nullable, nonatomic, copy) NSString *titulo;

@end

NS_ASSUME_NONNULL_END
