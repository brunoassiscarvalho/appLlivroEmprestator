//
//  Usuario+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 28/11/16.
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
@property (nullable, nonatomic, copy) NSString *sexo;
@property (nullable, nonatomic, copy) NSString *uf;

@end

NS_ASSUME_NONNULL_END
