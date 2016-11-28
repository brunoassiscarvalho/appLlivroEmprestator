//
//  Autor+CoreDataProperties.h
//  LivroEmprestator
//
//  Created by ALUNO on 28/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "Autor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Autor (CoreDataProperties)

+ (NSFetchRequest<Autor *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nome;

@end

NS_ASSUME_NONNULL_END
