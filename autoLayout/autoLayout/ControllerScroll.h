//
//  ControllerScroll.h
//  autoLayout
//
//  Created by ALUNO on 05/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerScroll : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imagemScroll;
@property (weak, nonatomic) IBOutlet UIImageView *viewImagem;

@end
