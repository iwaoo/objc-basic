//
//  ViewController.m
//  task2-5-6
//
//  Created by 新井岩生 on 2018/01/11.
//  Copyright © 2018年 新井岩生. All rights reserved.
//

#import "ViewController.h"

#import  <CoreLocation/CoreLocation.h>


@interface ViewController () <CLLocationManagerDelegate>


@property (nonatomic, retain) CLLocationManager *locationManager;

// 緯度
@property (weak, nonatomic) IBOutlet UILabel *labelLatitude;

// 経度
@property (weak, nonatomic) IBOutlet UILabel *labelLongitude;


@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    // ユーザから位置情報の利用について承認
    
    if (nil == self.locationManager) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        // iOS 8以上
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            
            //[ self.locationManager requestWhenInUseAuthorization];
            
            [self.locationManager requestAlwaysAuthorization];
            
        }
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
    }
    
    
    // 位置情報を取得
    
    [self.locationManager startUpdatingLocation];
    
    
    
}

// GPSで位置情報の更新があったときに呼ばれる

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    
    CLLocation* location = [locations lastObject];
    NSLog(@"緯度 %+.6f, 経度 %+.6f\n", location.coordinate.latitude,
          
          location.coordinate.longitude);
    
    // 緯度 %+.6f
    
    self.labelLatitude.text = [NSString stringWithFormat:@"緯度 %+.6f",
                               
                               location.coordinate.latitude];
    
    // 経度 %+.6f
    
    self.labelLongitude.text = [NSString stringWithFormat:@"経度 %+.6f",
                                
                                location.coordinate.longitude];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



@end
