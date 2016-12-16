//
//  Usuario+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 16/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Usuario+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Usuario (CoreDataProperties)

+ (NSFetchRequest<Usuario *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *apelido;
@property (nullable, nonatomic, copy) NSString *cidade;
@property (nullable, nonatomic, copy) NSDate *datanascimento;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, retain) NSData *imagem;
@property (nullable, nonatomic, copy) NSString *nome;
@property (nullable, nonatomic, copy) NSString *senha;
@property (nullable, nonatomic, copy) NSString *sexo;
@property (nullable, nonatomic, copy) NSString *uf;
@property (nullable, nonatomic, retain) NSSet<Interacoes *> *iteracoesSolicitado;
@property (nullable, nonatomic, retain) NSSet<Interacoes *> *iteracoesSolicitante;
@property (nullable, nonatomic, retain) NSSet<Livro *> *livro;

@end

@interface Usuario (CoreDataGeneratedAccessors)

- (void)addIteracoesSolicitadoObject:(Interacoes *)value;
- (void)removeIteracoesSolicitadoObject:(Interacoes *)value;
- (void)addIteracoesSolicitado:(NSSet<Interacoes *> *)values;
- (void)removeIteracoesSolicitado:(NSSet<Interacoes *> *)values;

- (void)addIteracoesSolicitanteObject:(Interacoes *)value;
- (void)removeIteracoesSolicitanteObject:(Interacoes *)value;
- (void)addIteracoesSolicitante:(NSSet<Interacoes *> *)values;
- (void)removeIteracoesSolicitante:(NSSet<Interacoes *> *)values;

- (void)addLivroObject:(Livro *)value;
- (void)removeLivroObject:(Livro *)value;
- (void)addLivro:(NSSet<Livro *> *)values;
- (void)removeLivro:(NSSet<Livro *> *)values;

@end

NS_ASSUME_NONNULL_END
