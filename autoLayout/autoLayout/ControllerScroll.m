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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateOneFrame
{
    NSRect viewBounds = [self bounds];
    dispatch_queue_t queue = dispatch_get_current_queue();
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSImage *image = [self extractImageFrom:@"my_url.com"];
        NSSize imageSize = [image size];
        NSRect imageRect = NSMakeRect( 0, 0, imageSize.width, imageSize.height );
        
        dispatch_sync(queue, ^{
            [image drawInRect:viewBounds fromRect:imageRect operation:NSCompositeCopy fraction:1.0];
        });
        
    });
    return;
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
