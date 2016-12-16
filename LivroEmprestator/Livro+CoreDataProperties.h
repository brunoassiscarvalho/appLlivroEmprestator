//
//  Livro+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 16/12/16.
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
@property (nullable, nonatomic, retain) NSSet<Autor *> *autor;
@property (nullable, nonatomic, retain) NSSet<Usuario *> *usuario;
@property (nullable, nonatomic, retain) NSSet<Interacoes *> *interacoes;

@end

@interface Livro (CoreDataGeneratedAccessors)

- (void)addAutorObject:(Autor *)value;
- (void)removeAutorObject:(Autor *)value;
- (void)addAutor:(NSSet<Autor *> *)values;
- (void)removeAutor:(NSSet<Autor *> *)values;

- (void)addUsuarioObject:(Usuario *)value;
- (void)removeUsuarioObject:(Usuario *)value;
- (void)addUsuario:(NSSet<Usuario *> *)values;
- (void)removeUsuario:(NSSet<Usuario *> *)values;

- (void)addInteracoesObject:(Interacoes *)value;
- (void)removeInteracoesObject:(Interacoes *)value;
- (void)addInteracoes:(NSSet<Interacoes *> *)values;
- (void)removeInteracoes:(NSSet<Interacoes *> *)values;

@end

NS_ASSUME_NONNULL_END
