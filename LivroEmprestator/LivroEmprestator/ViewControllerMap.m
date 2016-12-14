//
//  ViewControllerMap.m
//  LivroEmprestator
//
//  Created by ALUNO on 14/12/16.
//  Copyright © 2016 IESB. All rights reserved.
//

#import "ViewControllerMap.h"


@interface ViewControllerMap ()<MKMapViewDelegate>{

CLLocationManager *locationManager;

}



@end



@implementation ViewControllerMap


@synthesize mapview = _mapview;

- (void)viewDidLoad {
    [super viewDidLoad];
/*    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.*/
  //  _mapview.showsUserLocation=YES;
    locationManager =[CLLocationManager new];
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
