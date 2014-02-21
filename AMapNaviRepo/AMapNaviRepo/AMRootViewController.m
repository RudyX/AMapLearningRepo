//
//  AMRootViewController.m
//  AMapNaviRepo
//
//  Created by Mofang on 14-2-21.
//  Copyright (c) 2014年 yaonphy. All rights reserved.
//

#import "AMRootViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface AMRootViewController ()<MAMapViewDelegate>
@property (strong, nonatomic) MAMapView * aMapView;
@property (strong, nonatomic) NSMutableArray * annotationMutArr;
@property (strong, nonatomic) MAPolyline *polyLine;
@property (strong, nonatomic) MACircle *circle;
@end

@implementation AMRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [MAMapServices sharedServices].apiKey = @"5fa045642d406d2590e5f1cdadd43652";
    
    self.aMapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    self.aMapView.delegate = self;
//    self.aMapView.mapType = MAMapTypeSatellite;
    self.aMapView.showTraffic = YES;
    self.aMapView.logoCenter = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - 20);
    self.aMapView.showsCompass = NO;
    self.aMapView.showsScale = YES;
    self.aMapView.scaleOrigin = CGPointMake(CGRectGetMidX(self.view.bounds), 20.f);
//    self.aMapView.rotateCameraEnabled = NO;
    
    
    MAPointAnnotation *point_1 = [[MAPointAnnotation alloc]init];
    point_1.coordinate = CLLocationCoordinate2DMake(39.911447, 116.406026);
    point_1.title = @"annotation_one";
    
    MAPointAnnotation *point_2 = [[MAPointAnnotation alloc]init];
    point_2.coordinate = CLLocationCoordinate2DMake(39.900001, 116.292483);
    point_2.title = @"annotation_two";
    
    self.annotationMutArr  = [NSMutableArray arrayWithObjects:point_1,point_2, nil];
    
    [self.aMapView addAnnotations:self.annotationMutArr];
    
    
    
    
    CLLocationCoordinate2D polyLineCoords[4];
    polyLineCoords[0].latitude = 39.855539;
    polyLineCoords[0].longitude = 116.419037;
    polyLineCoords[1].latitude = 39.858172;
    polyLineCoords[1].longitude = 116.520285;
    polyLineCoords[2].latitude = 39.795479;
    polyLineCoords[2].longitude = 116.520859;
    polyLineCoords[3].latitude = 39.788467;
    polyLineCoords[3].longitude = 116.426786;
    self.polyLine = [MAPolyline polylineWithCoordinates:polyLineCoords count:4];
    [self.aMapView addOverlay:self.polyLine];
    
    self.circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(39.996441, 116.411146) radius:15000];
    [self.aMapView addOverlay:self.circle];
    
    [self.view addSubview:self.aMapView];
    
    
}
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString * pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == Nil) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = YES;
            annotationView.draggable = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

        }
        annotationView.pinColor = [self.annotationMutArr indexOfObject:annotationView];
        return annotationView;
    }
    
    return nil;

}
-(MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolygonView *polygonView = [[MAPolygonView alloc]initWithPolygon:overlay];
        polygonView.lineWidth = 2.0f;
        polygonView.strokeColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        polygonView.fillColor = [UIColor orangeColor];
        return polygonView;
    }
    
    return nil;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.aMapView removeAnnotations:self.annotationMutArr];
    [self.aMapView removeOverlay:self.polyLine];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
