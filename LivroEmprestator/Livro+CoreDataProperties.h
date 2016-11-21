//
//  Livro+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 21/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Livro+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Livro (CoreDataProperties)

+ (NSFetchRequest<Livro *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *ano;
@property (nullable, nonatomic, copy) NSString *edicao;
@property (nullable, nonatomic, retain) NSData *imagem;
@property (nullable, nonatomic, copy) NSString *resumo;
@property (nullable, nonatomic, copy) NSString *titulo;

@end

NS_ASSUME_NONNULL_END
