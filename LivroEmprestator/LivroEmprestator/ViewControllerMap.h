//
//  ViewControllerMap.h
//  LivroEmprestator
//
//  Created by ALUNO on 14/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewControllerMap : UIViewController{
    MKMapView *mapview;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapview;

@end
