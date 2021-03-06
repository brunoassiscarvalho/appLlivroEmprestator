//
//  ControllerScroll.m
//  autoLayout
//
//  Created by ALUNO on 05/10/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ControllerScroll.h"

@interface ControllerScroll ()
@property (weak, nonatomic) IBOutlet UITextView *myScroll;

@end

@implementation ControllerScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imagemScroll setMaximumZoomScale:5.0];
    [self.imagemScroll setMinimumZoomScale:0.1];
    [self.imagemScroll setClipsToBounds:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    __weak typeof (self) weakSelf = self;
    dispatch_queue_t fila = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(fila, ^{
        NSURL *url = [NSURL URLWithString:@"https://s-media-cache-ak0.pinimg.com/originals/4f/c7/84/4fc7841e00ceda2bdc69f00271e4dae7.jpg"];
        
        NSData *bytes = [NSData dataWithContentsOfURL:url];
        UIImage *imagem = [UIImage imageWithData:bytes];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewImagem setImage:(imagem)];
            [self.viewImagem sizeToFit];
            [weakSelf.myScroll setContentSize:imagem.size];
            [weakSelf.myScroll addSubview:self.viewImagem];
            [weakSelf setTitle:@"Game"];
        });
        
                                           
    
    });
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.viewImagem;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
