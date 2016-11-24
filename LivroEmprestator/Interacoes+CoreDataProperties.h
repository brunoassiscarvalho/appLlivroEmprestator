//
//  Interacoes+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 23/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Interacoes+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Interacoes (CoreDataProperties)

+ (NSFetchRequest<Interacoes *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nonatomic) int16_t tipoIteracao;
@property (nullable, nonatomic, retain) Livro *livro;
@property (nullable, nonatomic, retain) Usuario *usuarioLeitor;
@property (nullable, nonatomic, retain) Usuario *usuarioEmprestador;

@end

NS_ASSUME_NONNULL_END
