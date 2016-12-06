//
//  TableViewControllerListaLivros.h
//  LivroEmprestator
//
//  Created by ALUNO on 07/11/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewControllerListaLivros : UITableViewController
typedef void (^CallbackDownloadFoto)(UIImage *foto, NSError *erro);
@property (weak, nonatomic) IBOutlet UITableView *tabelaMeusLivros;

@end
