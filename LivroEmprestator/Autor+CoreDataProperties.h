//
//  Autor+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 13/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Autor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Autor (CoreDataProperties)

+ (NSFetchRequest<Autor *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nome;
@property (nullable, nonatomic, retain) NSSet<Livro *> *livro;

@end

@interface Autor (CoreDataGeneratedAccessors)

- (void)addLivroObject:(Livro *)value;
- (void)removeLivroObject:(Livro *)value;
- (void)addLivro:(NSSet<Livro *> *)values;
- (void)removeLivro:(NSSet<Livro *> *)values;

@end

NS_ASSUME_NONNULL_END
