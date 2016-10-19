//
//  Produto+CoreDataProperties.h
//  BancoDeDados
//
//  Created by ALUNO on 19/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Produto+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Produto (CoreDataProperties)

+ (NSFetchRequest<Produto *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *descricao;
@property (nullable, nonatomic, copy) NSString *marca;
@property (nullable, nonatomic, copy) NSDate *validade;
@property (nonatomic) float preco;

@end

NS_ASSUME_NONNULL_END
