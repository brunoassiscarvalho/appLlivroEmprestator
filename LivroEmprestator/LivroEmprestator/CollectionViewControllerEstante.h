//
//  CollectionViewControllerEstante.h
//  LivroEmprestator
//
//  Created by ALUNO on 13/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Usuario+CoreDataClass.h"

@interface CollectionViewControllerEstante : UICollectionViewController
@property (weak, nonatomic) IBOutlet UICollectionView *estanteDeLivros;


@property  Usuario *usuarioSelecionado;
@end
