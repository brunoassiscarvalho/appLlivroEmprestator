//
//  IncrivelBehavior.h
//  Quadrados
//
//  Created by ALUNO on 21/09/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IncrivelBehavior : UIDynamicBehavior
- (void) adicionarItem: (id<UIDynamicItem>) item;
- (void) removerItem: (id<UIDynamicItem>) item;
@end
