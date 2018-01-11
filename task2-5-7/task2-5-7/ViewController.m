//
//  ViewController.m
//  task2-5-7
//
//  Created by 新井岩生 on 2018/01/11.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    MKCoordinateRegion cr = self.mapView.region;
    cr.center = CLLocationCoordinate2DMake(35.623655,139.724858);
    cr.span = MKCoordinateSpanMake(0.01, 0.01);
    [self.mapView setRegion:cr animated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D kamataCoordinate = CLLocationCoordinate2DMake(35.623655,139.724858);
    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = kamataCoordinate;
    pin.title = @"スマートテック・ベンチャーズ";
    [self.mapView addAnnotation:pin];
}


@end
